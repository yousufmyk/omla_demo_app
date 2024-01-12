part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String? email;
  final String? password;

  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthEvent{
  final String? email;
  final String? password;

  SignUpEvent({required this.email, required this.password});
}

class SignUpNavigateEvent extends AuthEvent{}

class LoginNavigateEvent extends AuthEvent{}




