part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}
abstract class AuthActionState extends AuthState{}

class AuthLoadingState extends AuthState{}
class AuthSucessState extends AuthState{}
