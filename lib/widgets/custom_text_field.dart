import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // Properties
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  // Constructor
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Controller
      controller: controller,

      // Appearance
      maxLines: maxLines,

      // Decoration
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),

      // Validation
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Enter $hintText';
        }
        return null;
      },
    );
  }
}
