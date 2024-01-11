import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.hintText,  this.isPassword,required this.controller,
  });
  final String? hintText;
  final bool? isPassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
      ),
      obscureText: isPassword ?? false,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Color.fromARGB(125, 255, 255, 255)),
        hintText: hintText,
        
        filled: true,
        fillColor: const Color.fromARGB(147, 77, 44, 207),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
