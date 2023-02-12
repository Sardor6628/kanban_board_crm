part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;
  SignInRequested({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  SignUpRequested({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}
class GoogleSignInRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}
class SignOutRequested extends AuthEvent {
  @override
  List<Object> get props => [];
}

