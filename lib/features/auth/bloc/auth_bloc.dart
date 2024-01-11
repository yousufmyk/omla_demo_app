import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(loginEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) {
    print(event.email);
    print(event.password);
  }
}
