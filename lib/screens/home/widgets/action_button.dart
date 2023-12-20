import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String decoration;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ActionButton({
    Key? key,
    required this.decoration,
    required this.onPressed,
    required this.backgroundColor,
    required String title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(decoration, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
      ),
    );
  }
}
