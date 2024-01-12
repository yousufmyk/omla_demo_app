import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(loginEvent);
    on<SignUpEvent>(signUpEvent);
    on<SignUpNavigateEvent>(signUpNavigateEvent);
    on<LoginNavigateEvent>(loginNavigateEvent);
    
    
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async{
    
    emit(AuthLoadingState());
    try {
      await auth
        .signInWithEmailAndPassword(
      email: event.email.toString(),
      password: event.password.toString(),
    )
        .then((userCredential) {
      emit(AuthLoadingSucessState());
      
     
    });
    } on FirebaseAuthException catch (e) {
      var message = e.code;
      
      emit(AuthErrorState(errorMessage: message));
      
    }
    

  }


  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());
    try {
      await auth
        .createUserWithEmailAndPassword(
      email: event.email.toString(),
      password: event.password.toString(),
    )
        .then((userCredential) {
     emit(AuthLoadingSucessState());
      if (kDebugMode) {
        print('Sign up sucess');
      }
    });
    } on FirebaseAuthException catch (e) {
      var message = e.code;
      
      emit(AuthErrorState(errorMessage: message));
      
    }
  }

  

  FutureOr<void> signUpNavigateEvent(SignUpNavigateEvent event, Emitter<AuthState> emit) {
    
    emit(SignUpNavigateState());
  }

  FutureOr<void> loginNavigateEvent(LoginNavigateEvent event, Emitter<AuthState> emit) {
    emit(LoginNavigateState());
  }

  
}
