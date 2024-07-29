import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final String? helperText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final int? maxLength;
  final String? initialValue;
  final TextInputType? textInputType; // Tambahkan parameter baru

  final String? Function(String?)? validator;

  const CustomForm({
    Key? key,
    required this.hintText,
    this.helperText,
    this.controller,
    this.prefixIcon,
    this.maxLength,
    this.textInputType, // Tambahkan parameter baru
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType, // Gunakan textInputType di sini
      maxLength: maxLength,
      initialValue: initialValue,
      inputFormatters: textInputType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null, // Sesuaikan inputFormatters berdasarkan textInputType
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 14.0,
        ),
        helperText: helperText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
