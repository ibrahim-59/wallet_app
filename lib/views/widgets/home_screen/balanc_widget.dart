import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/cubit/fetch_data_cubit.dart';

import '../../../core/styles/colors.dart';

class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    super.key,
    required this.size,
    required this.color,
    required this.isBottom,
  });

  final Size size;
  final Color color;
  final bool isBottom;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: size.width / 3,
        width: double.infinity,
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Container(
                  width: size.width / 1.2,
                  decoration: BoxDecoration(
                      color: kBlackColor,
                      borderRadius: isBottom
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(15))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(15))),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          isBottom ? "Today Balance" : "My Balance",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          isBottom
                              ? NumberFormat.compactCurrency(
                                      symbol: "", decimalDigits: 2)
                                  .format(
                                      BlocProvider.of<FetchDataCubit>(context)
                                          .todaySum)
                                  .toString()
                              : NumberFormat.compactCurrency(
                                      symbol: "", decimalDigits: 2)
                                  .format(
                                      BlocProvider.of<FetchDataCubit>(context)
                                          .sum)
                                  .toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                      ],
                    ),
                  )),
            ),
            Flexible(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: isBottom
                        ? const BorderRadius.only(
                            bottomRight: Radius.circular(15))
                        : const BorderRadius.only(
                            topRight: Radius.circular(15))),
              ),
            ),
          ],
        ));
  }
}
