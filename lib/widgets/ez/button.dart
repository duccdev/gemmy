import 'package:flutter/material.dart';

typedef OnPressedCallback = void Function();

class EzButton extends StatelessWidget {
  const EzButton({super.key, required this.child, required this.onPressed});

  final Widget child;
  final OnPressedCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF282A2C),
        disabledBackgroundColor: const Color(0xFF1A1A1C),
        disabledForegroundColor: Colors.white54,
        overlayColor: Colors.white,
      ),
      child: child,
    );
  }
}
