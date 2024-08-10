import 'package:flutter/material.dart';
import 'package:roulette_task/presentation/global/colors/colors.dart';

class TextButtonSettings extends StatelessWidget {
  const TextButtonSettings(
      {super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.blackText,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
