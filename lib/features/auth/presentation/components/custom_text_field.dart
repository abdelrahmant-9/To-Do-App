import 'package:flutter/material.dart';
import 'package:todo_app/core/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.controller, this.obscureText = false,
  });

  final String hint;
  final TextEditingController controller;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText!,
      
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.softGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: AppColors.softGrey),
        ),
        suffixIcon: obscureText!? Icon(Icons.visibility_off):null
      ),
    );
  }
}
