import 'package:flutter/material.dart';

class HomeTextField extends StatelessWidget {
  const HomeTextField({
    super.key,
    this.hintText,
    this.isPassword,
    required this.controller,
    this.filledCollor,
    this.hintColor,
    this.textColor,
    this.height,
    this.width,
  });
  final String? hintText;
  final bool? isPassword;
  final TextEditingController controller;
  final Color? filledCollor;
  final Color? hintColor;
  final Color? textColor;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 60,
      width: width ?? 270,
      child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        style: TextStyle(
            color: textColor ?? Colors.white, fontWeight: FontWeight.w700),
        keyboardType: TextInputType.number,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          hintStyle: TextStyle(
              color: hintColor ?? const Color.fromARGB(125, 255, 255, 255)),
          hintText: hintText,
          filled: true,
          fillColor: filledCollor ?? const Color.fromARGB(147, 77, 44, 207),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
