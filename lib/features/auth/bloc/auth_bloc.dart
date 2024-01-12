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
    await auth
        .signInWithEmailAndPassword(
      email: event.email.toString(),
      password: event.password.toString(),
    )
        .then((userCredential) {
      emit(AuthLoadingSucessState());
      if (kDebugMode) {
        print("Login Sucess");
      }
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => const PostScreen()));
    }).catchError((e) {
      emit(AuthLoadingSucessState());
      if (kDebugMode) {
        print(e.toString());
      }
    });
    //emit(AuthLoadingSucessState());
    // print(event.email);
    // print(event.password);

  }

  FutureOr<void> signUpEvent(SignUpEvent event, Emitter<AuthState> emit) {
    auth
        .createUserWithEmailAndPassword(
      email: event.email.toString(),
      password: event.password.toString(),
    )
        .then((userCredential) {
     
      print('Sign up sucess');
    }).catchError((e) {
      print("Sign up error${e.toString()}");
      return e;
    });
  }

  

  FutureOr<void> signUpNavigateEvent(SignUpNavigateEvent event, Emitter<AuthState> emit) {
    // emit(SignUpNavigateState());
    print("SignUpNavigateState emitted");
    emit(SignUpNavigateState());
  }

  FutureOr<void> loginNavigateEvent(LoginNavigateEvent event, Emitter<AuthState> emit) {
    emit(LoginNavigateState());
  }

  
}
