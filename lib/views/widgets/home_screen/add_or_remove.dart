import 'package:flutter/material.dart';

import '../../../core/styles/colors.dart';

class AddorRemoveMoney extends StatelessWidget {
  const AddorRemoveMoney({
    super.key,
    required this.isRemove,
    required this.onTap,
  });
  final bool isRemove;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isRemove ? kSecondryRed : kSecondryGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              isRemove ? Icons.remove : Icons.add,
              color: isRemove ? kPrimaryRed : kPrimaryGreen,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              isRemove ? "Remove" : "Add",
              style: TextStyle(color: isRemove ? kPrimaryRed : kPrimaryGreen),
            )
          ],
        ),
      ),
    ));
  }
}
