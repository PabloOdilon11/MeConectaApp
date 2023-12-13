// lib/screens/home/widgets/action_button.dart
import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final Function() onPressed;
  final Color backgroundColor;

  const ActionButton({
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
      ),
    );
  }
}
