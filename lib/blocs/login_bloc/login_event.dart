part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Five events"
// 1. EmailChanged - when the email field is changed
class EmailChanged extends LoginEvent {
  final String email;

  EmailChanged({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

// 2. PasswordChanged - when the password field is changed
class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

// 3. submitted - sended
class Submitted extends LoginEvent {
  final String email;
  final String password;

  Submitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password }';
  }
}

// 4. LoginWithGooglePressed - when the user press the google button
class LoginWithGooglePressed extends LoginEvent {}

// 5. LoginWithCredentialsPressed - when the user press the login button
class LoginWithCredentialsPressed extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsPressed({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'LoginWithCredentialsPressed { email: $email, password: $password }';
  }
}
