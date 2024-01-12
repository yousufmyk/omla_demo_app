import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,  required this.text, required this.onTap,  this.loading = false,
  });
final String text;
final VoidCallback onTap;
final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: 170,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xffa444d0), Color(0xff21da94)],
          ),
        ),
        child:  Center(
            child: loading ? const CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        )),
      ),
    );
  }
}