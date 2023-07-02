import 'dart:async';

import 'package:app_aposento_alto_calle80/models/user_app.dart';
import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:app_aposento_alto_calle80/services/repositories/authentication_repository.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<UserApp?> _userSubscription;

  AuthenticationBloc()
      : _authenticationRepository = getIt.get<AuthenticationRepository>(),
        super(Uninitialized()) {
    _userSubscription = _authenticationRepository.user.listen(
      (UserApp? user) => add(AuthenticationUserChanged(user)),
    );
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield* _mapAuthenticationUserChangedToState(event);
    }
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
    if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationUserChangedToState(AuthenticationUserChanged event) async* {
    if (event.user != null) {
      UserApp user = event.user!;
      if (!await _authenticationRepository.userExistsOnDataBase(user.id!)) {
        yield FirstTime(user);
        Get.offNamed('/complete_profile_screen');
      } else {
        yield Authenticated(user);
        Get.offNamed('/home');
      }
    } else {
      yield Unauthenticated();
      Get.offNamed('/login');
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _authenticationRepository.isSignedIn();
      if (isSignedIn) {
        final UserApp user = await _authenticationRepository.getUser();
        if (!await _authenticationRepository.userExistsOnDataBase(user.id!)) {
          yield FirstTime(user);
          Get.offNamed('/complete_profile_screen');
        } else {
          // Activate when need to see the splash screen
          yield await Future.delayed(
            splashScreenDuration,
            () => Authenticated(user),
          );
          Get.offNamed('/home');
          // Activate when not need to see splash screen
          //yield Authenticated(user);
        }
      } else {
        // Activate when need to see the splash screen
        yield await Future.delayed(
          splashScreenDuration,
          () => Unauthenticated(),
        );
        // Activate when not need to see splash screen
        //yield Unauthenticated();
        Get.offNamed('/login');
      }
    } catch (_) {
      yield Unauthenticated();
      Get.offNamed('/login');
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    _authenticationRepository.logOut();
    Get.offNamed('/login');
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
