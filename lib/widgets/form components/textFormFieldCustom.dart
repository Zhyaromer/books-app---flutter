import 'package:flutter/material.dart';

Widget textFormFieldCustom({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String hintText,
  String? Function(String?)? validator,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    decoration: InputDecoration(
      hintText: hintText,
      filled: true,
      errorStyle: const TextStyle(color: Colors.red, fontSize: 14),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 2, color: Colors.red),
      ),
      errorMaxLines: 2,
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      fillColor: Colors.deepPurple[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(width: 2, color: Colors.red),
      ),
    ),
  );
}
