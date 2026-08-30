import 'package:flutter/material.dart';
import 'package:taxawu/theme/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final Icon? icon;
  final IconButton? suffixedIcon;
  final String? Function(String?)? validator;
  final String title;
  final String? hintText;
  final bool obscurePassword;

  const CustomFormField(
      {super.key,
      required this.title,
      this.icon,
      this.type = TextInputType.text,
      required this.controller,
      required this.validator,
      this.hintText,
      this.suffixedIcon,
      this.obscurePassword = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          keyboardType: type,
          obscureText: obscurePassword,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
              hintText: hintText ?? "",
              prefixIcon: icon,
              filled: true,
              fillColor: AppColors.blanc,
              labelStyle: const TextStyle(fontSize: 12),
              hintStyle: const TextStyle(fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: AppColors.lineColor,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: AppColors.vertFonce,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              errorStyle: const TextStyle(fontSize: 8),
              suffixIcon: suffixedIcon),
          validator: validator,
        )
      ],
    );
  }
}
