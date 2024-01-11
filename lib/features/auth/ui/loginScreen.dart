import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omla_demo_app/features/CustomWidgets/appButton.dart';
import 'package:omla_demo_app/features/CustomWidgets/appTextFeild.dart';
import 'package:omla_demo_app/features/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final AuthBloc authBloc = AuthBloc();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: AuthBloc(),
      listener: (context, state) {
        
      },
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is !AuthActionState,
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
                  AppButton(
                    text: 'helo',
                    onTap: () {
                      authBloc.add(LoginEvent(email: emailController.text.toString(),password: passwordController.text.toString()));
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
