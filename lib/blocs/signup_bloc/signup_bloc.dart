import 'dart:async';

import 'package:app_aposento_alto_calle80/services/get_it.dart';
import 'package:app_aposento_alto_calle80/services/repositories/authentication_repository.dart';
import 'package:app_aposento_alto_calle80/shared/constants.dart';
import 'package:app_aposento_alto_calle80/utils/validators.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthenticationRepository _authenticationRepository;

  SignupBloc()
      : _authenticationRepository = getIt.get<AuthenticationRepository>(),
        super(SignupState.empty());

  @override
  Stream<Transition<SignupEvent, SignupState>> transformEvents(
    Stream<SignupEvent> events,
    TransitionFunction<SignupEvent, SignupState> transitionFn,
  ) {
    final nonDebounceStream = events.where(
      (event) => (event is! EmailChanged && event is! PasswordChanged),
    );

    final debounceStream = events.where((event) => (event is EmailChanged || event is PasswordChanged)).debounceTime(errorFormFieldVerificationDuration);

    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.email, event.password);
    }
  }

  Stream<SignupState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<SignupState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<SignupState> _mapFormSubmittedToState(String email, String password) async* {
    yield SignupState.loading();
    try {
      yield await Future.delayed(
        signUpDuration,
        () async {
          await _authenticationRepository.signUp(email, password);
          return SignupState.success();
        },
      );
    } catch (_) {
      yield SignupState.failure();
    }
  }
}
