import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omla_demo_app/features/CustomWidgets/appButton.dart';
import 'package:omla_demo_app/features/CustomWidgets/appTextFeild.dart';
import 'package:omla_demo_app/features/auth/bloc/auth_bloc.dart';
import 'package:omla_demo_app/features/auth/ui/loginScreen.dart';
import 'package:omla_demo_app/features/home/ui/homeScreen.dart';
import 'package:omla_demo_app/features/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final AuthBloc authBloc = AuthBloc();
  var isloading = false;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
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
        if (state is LoginNavigateState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else if (state is AuthLoadingState) {
          startLoading();
        } else if (state is AuthLoadingSucessState) {
          stopLoading();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else if (state is AuthErrorState) {
          Utils().errorMessage(state.errorMessage.toString(), context);
          stopLoading();
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              child: SingleChildScrollView(
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
                      hintText: 'first name',
                      controller: firstNameController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextField(
                      hintText: 'last name',
                      controller: lastNameController,
                    ),
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
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            authBloc.add(LoginNavigateEvent());
                          },
                          child: const Text(
                            'LogIn',
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
                      text: 'SignUp',
                      loading: isloading,
                      onTap: () {
                        authBloc.add(SignUpEvent(
                            email: emailController.text.toString(),
                            password: passwordController.text.toString()));
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
