import 'package:flutter/material.dart';

import '../../../core/styles/colors.dart';

class AddPageButton extends StatelessWidget {
  const AddPageButton({
    super.key,
    required this.title,
    required this.isDone,
    required this.onPressed,
  });
  final String title;
  final bool isDone;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: isDone ? kSecondryBlue : kSecondryRed,
                foregroundColor: isDone ? kPrimaryBlue : kPrimaryRed,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20)),
            onPressed: onPressed,
            child: Text(
              title,
              style: const TextStyle(fontSize: 16),
            )));
  }
}
