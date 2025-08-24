import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const CustomButton({super.key, required this.text, required this.onTap, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.orange,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Text(text, style: TextStyle(color: backgroundColor == null ? Colors.white : Colors.black),),
    );
  }
}
