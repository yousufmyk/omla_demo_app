import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omla_demo_app/features/CustomWidgets/appButton.dart';
import 'package:omla_demo_app/features/CustomWidgets/appTextFeild.dart';
import 'package:omla_demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:omla_demo_app/features/auth/ui/signUpScreen.dart';
import 'package:omla_demo_app/features/home/ui/homeScreen.dart';
import 'package:omla_demo_app/features/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc authBloc = AuthBloc();

  var isloading = false;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void startLoading() {
    setState(() {
      isloading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is SignUpNavigateState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpScreen()));
        } else if (state is AuthLoadingState) {
          startLoading();
        } else if (state is AuthLoadingSucessState) {
          stopLoading();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (state is AuthErrorState) {
          Utils().errorMessage(state.errorMessage.toString(), context);
          stopLoading();
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          'assets/images/Screenshot 2024-01-11 at 5.48.17 PM.png'),
                      fit: BoxFit.fill)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color:
                      const Color.fromARGB(18, 255, 255, 255).withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 30,),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(
                    height: 30,
                  ),

                  AppTextField(
                    hintText: 'email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppTextField(
                    hintText: 'password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          authBloc.add(SignUpNavigateEvent());
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                            decorationColor: Colors.white,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AppButton(
                    text: 'LogIn',
                    loading: isloading,
                    onTap: () {
                      authBloc.add(LoginEvent(
                          email: emailController.text.toString(),
                          password: passwordController.text.toString()));
                    },
                  )
                ],
              ),
            )
          ],
        ));
      },
    );
  }
}
