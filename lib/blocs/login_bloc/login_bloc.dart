import 'dart:async';

import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:app_aposento_alto_calle80/services/repositories/authentication_repository.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:app_aposento_alto_calle80/utils/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository;

  LoginBloc()
      : _authenticationRepository = getIt.get<AuthenticationRepository>(),
        super(LoginState.empty());

  // to do debounce (to add times to observe in the writting of the user)
  // in the events emailChanged and passwordChanged
  @override
  Stream<Transition<LoginEvent, LoginState>> transformEvents(
    Stream<LoginEvent> events,
    TransitionFunction<LoginEvent, LoginState> transitionFn,
  ) {
    final nonDebounceStream = events.where(
      (event) => (event is! EmailChanged && event is! PasswordChanged),
    );

    final debounceStream = events
        .where(
          (event) => (event is EmailChanged || event is PasswordChanged),
        )
        .debounceTime(errorFormFieldVerificationDuration);

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    }
    if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    }
    if (event is LoginWithGooglePressed) {
      yield* _mapLoginWithGooglePressedToState();
    }
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
        email: event.email,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressedToState() async* {
    try {
      await _authenticationRepository.loginWithGoogle();
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState({
    required String email,
    required String password,
  }) async* {
    yield LoginState.loading();
    try {
      yield await Future.delayed(
        loginDuration,
        () async {
          await _authenticationRepository.loginWithEmailAndPassword(email, password);
          return LoginState.success();
        },
      );
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
