import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/core/styles/colors.dart';
import 'package:wallet_app/models/finance.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.finance,
  });
  final Finance finance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: finance.value > 0 ? kPrimaryPurple : kPrimaryRed,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(finance.details),
                Text(DateFormat.yMMMEd().format(finance.dateTime)),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Text(finance.value > 0 ? "+" : ""),
                Text(finance.value.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}
