part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInRequested extends AuthEvent {
  final LoginParam loginParam;

  SignInRequested(this.loginParam);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested(this.email, this.password);
}

class SignOutRequested extends AuthEvent {}
