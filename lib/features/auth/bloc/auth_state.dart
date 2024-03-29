part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}
abstract class AuthActionState extends AuthState{}

final class AuthInitial extends AuthState {}


class AuthLoadingState extends AuthActionState{}
class AuthLoadingSucessState extends AuthActionState{}
class AuthErrorState extends AuthActionState{
  final String? errorMessage;

  AuthErrorState({required this.errorMessage});
}
class AuthSucessState extends AuthState{}
class SignUpNavigateState extends AuthActionState{}
class LoginNavigateState extends AuthActionState{}

