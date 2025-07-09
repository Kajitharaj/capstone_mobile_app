import 'package:flutter/material.dart';

enum AppTextFieldType { filled, outlined, underlined }

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final bool obscureText;
  final AppTextFieldType type;

  const AppTextField._({
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
    required this.type,
  });

  factory AppTextField.filled({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    bool obscureText = false,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      obscureText: obscureText,
      type: AppTextFieldType.filled,
    );
  }

  factory AppTextField.outlined({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    bool obscureText = false,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      obscureText: obscureText,
      type: AppTextFieldType.outlined,
    );
  }

  factory AppTextField.underlined({
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    bool obscureText = false,
  }) {
    return AppTextField._(
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      obscureText: obscureText,
      type: AppTextFieldType.underlined,
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseDecoration = InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon,
      filled: type == AppTextFieldType.filled,
      fillColor: type == AppTextFieldType.filled
          ? const Color(0xFFFFF8E1)
          : null, // light yellow
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(focused: true),
    );

    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: baseDecoration,
    );
  }

  InputBorder _buildBorder({bool focused = false}) {
    switch (type) {
      case AppTextFieldType.filled:
      case AppTextFieldType.outlined:
        return OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: focused ? const Color(0xFFFF5722) : Colors.grey.shade400,
            width: 1.5,
          ),
        );
      case AppTextFieldType.underlined:
        return UnderlineInputBorder(
          borderSide: BorderSide(
            color: focused ? const Color(0xFFFF5722) : Colors.grey.shade400,
            width: 1.5,
          ),
        );
    }
  }
}
