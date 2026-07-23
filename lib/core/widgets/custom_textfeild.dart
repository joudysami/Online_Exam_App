import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
     this.label,
    required this.hint,
    this.validator,
    this.controller,
    this.obscureText, 
     this.icon,
  });

  final String? label;
  final bool? obscureText;
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: obscureText ?? false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
