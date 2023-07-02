part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// Three states:

// 1. Uninitialized - (No inicializado) -> splash screen
class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

// 2. Unauthenticated - (No autenticado) -> login screen
class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

// 3. Authenticated - (Autenticado) -> home screen
class Authenticated extends AuthenticationState {
  final UserApp user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated { User: ${user.email} }';
}

// 4. FirstTime - (Primera vez) -> complete profile screen
class FirstTime extends AuthenticationState {
  final UserApp user;

  const FirstTime(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'FirstTime { User: ${user.email} }';
}
