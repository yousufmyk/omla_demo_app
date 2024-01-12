import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:omla_demo_app/features/auth/ui/loginScreen.dart';
import 'package:omla_demo_app/features/utils/utils.dart';
import 'package:omla_demo_app/firebase_options.dart';

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
      home: LoginScreen(),
      //home: Test(),
    );
  }
}

// class Test extends StatelessWidget {
//   const Test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//               child: const Text('Show Awesome SnackBar'),
//               onPressed: () {
//                 // final snackBar = SnackBar(
//                 //   /// need to set following properties for best effect of awesome_snackbar_content
//                 //   elevation: 0,
//                 //   behavior: SnackBarBehavior.floating,
//                 //   backgroundColor: Colors.transparent,
//                 //   content: AwesomeSnackbarContent(
//                 //     title: 'On Snap!',
//                 //     message:
//                 //         'This is an example error message that will be shown in the body of snackbar!',

//                 //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
//                 //     contentType: ContentType.failure,
//                 //   ),
//                 // );

//                 // ScaffoldMessenger.of(context)
//                 //   ..hideCurrentSnackBar()
//                 //   ..showSnackBar(snackBar);
//                 Utils().errorMessage("is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",context);
//               },
//             ),
//       ),
//     );
//   }
// }

