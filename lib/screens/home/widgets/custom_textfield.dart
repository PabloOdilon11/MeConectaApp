import 'package:flutter/material.dart';

class TextField extends StatelessWidget {
  final String title;
  final VoidCallback onChanged;
  final Color inputFormatters;

  const TextField({
    Key? key,
    required this.title,
    required this.onChanged,
    required this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onChanged,
      child: Text(title, style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        primary: inputFormatters,
      ),
    );
  }
}
