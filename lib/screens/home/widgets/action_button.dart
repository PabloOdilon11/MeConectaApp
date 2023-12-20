import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ActionButton({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
      ),
    );
  }
}
