import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:omla_demo_app/features/auth/ui/loginScreen.dart';
import 'package:omla_demo_app/features/price/ui/priceScreen.dart';
import 'package:omla_demo_app/features/utils/utils.dart';
import 'package:omla_demo_app/firebase_options.dart';
import 'package:omla_demo_app/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
