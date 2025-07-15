import 'package:flutter/material.dart';

enum ButtonType { text, elevated, outlined }

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final ButtonType type;
  final ButtonStyle? style;

  const AppButton._({
    required this.onPressed,
    required this.child,
    this.style,
    required this.type,
  });

  factory AppButton.text({
    required String text,
    required VoidCallback? onPressed,
    TextStyle? textStyle,
    ButtonStyle? style,
  }) {
    return AppButton._(
      onPressed: onPressed,
      type: ButtonType.text,
      style: style,
      child: Text(text, style: textStyle),
    );
  }

  factory AppButton.icon({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    IconData? trailingIcon,
  }) {
    return AppButton._(
      onPressed: onPressed,
      type: ButtonType.elevated,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
          if (trailingIcon != null) ...[
            const SizedBox(width: 8),
            Icon(trailingIcon),
          ],
        ],
      ),
    );
  }

  factory AppButton.elevated({
    required String text,
    required VoidCallback? onPressed,
  }) {
    return AppButton._(
      onPressed: onPressed,
      type: ButtonType.elevated,
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.text:
        return TextButton(onPressed: onPressed, style: style, child: child);
      case ButtonType.elevated:
        return ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: const Color(0xFFFF5722),
            foregroundColor: Colors.white,
          ),
          child: child,
        );
      case ButtonType.outlined:
        return OutlinedButton(onPressed: onPressed, style: style, child: child);
    }
  }
}
