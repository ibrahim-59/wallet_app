import 'package:flutter/material.dart';

import '../../../core/styles/colors.dart';

class KeyBadItem extends StatelessWidget {
  const KeyBadItem({
    super.key,
    required this.onTap,
    required this.title,
  });
  final void Function() onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: kBlackColor, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: kWhiteColor),
            ),
          ),
        ),
      ),
    ));
  }
}
