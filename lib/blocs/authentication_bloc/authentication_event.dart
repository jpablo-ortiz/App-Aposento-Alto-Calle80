part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

// Three events for the authentication bloc:

// 1. AppStarted
class AppStarted extends AuthenticationEvent {}

// 2. AuthenticationUserChanged
class AuthenticationUserChanged extends AuthenticationEvent {
  final UserApp? user;

  AuthenticationUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

// 3. LoggedOut
class LoggedOut extends AuthenticationEvent {}
