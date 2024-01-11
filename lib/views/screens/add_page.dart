import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/core/styles/colors.dart';
import 'package:wallet_app/cubit/addcubit/add_data_cubit.dart';
import 'package:wallet_app/cubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/finance.dart';
import 'package:wallet_app/views/widgets/add_page/add_page_button.dart';

import '../widgets/add_page/key_bad_item.dart';

class AddPage extends StatefulWidget {
  final bool isDone;
  final Finance? finance;
  const AddPage({super.key, required this.isDone, this.finance});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController detailscontroller = TextEditingController();
  String num = '';
  @override
  void initState() {
    if (widget.finance != null) {
      detailscontroller.text = widget.finance!.details;
      // num = (widget.finance!.value).toString();
      num = widget.finance!.value > 0
          ? (widget.finance!.value).toString()
          : (widget.finance!.value * -1).toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.isDone ? "Add Money" : "Remove Money"),
      ),
      body: BlocProvider(
        create: (context) => AddDataCubit(),
        child: BlocBuilder<AddDataCubit, AddDataState>(
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                BlocProvider.of<FetchDataCubit>(context).fetchData();
                return true;
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kPrimaryPurple,
                          borderRadius: BorderRadius.circular(16)),
                      child: TextFormField(
                        controller: detailscontroller,
                        style: TextStyle(color: kSecondryPurple),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Details ...",
                            contentPadding: const EdgeInsets.all(12),
                            hintStyle: TextStyle(color: kSecondryPurple)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color:
                                widget.isDone ? kSecondryGreen : kSecondryRed,
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                          child: Text(
                            widget.isDone
                                ? (num == '' ? "+ 0.0" : "+ $num")
                                : (num == '' ? "- 0.0" : "- $num"),
                            style: TextStyle(
                                color:
                                    widget.isDone ? kPrimaryGreen : kPrimaryRed,
                                fontSize: 24),
                          ),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  KeyBadItem(
                                    title: "1",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}1";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "2",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}2";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "3",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}3";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  KeyBadItem(
                                    title: "4",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}4";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "5",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}5";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "6",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}6";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  KeyBadItem(
                                    title: "7",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}7";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "8",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}8";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "9",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}9";
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  KeyBadItem(
                                    title: ".",
                                    onTap: () {
                                      setState(() {
                                        num.contains(".")
                                            ? null
                                            : num = "$num.";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "0",
                                    onTap: () {
                                      setState(() {
                                        num = "${num}0";
                                      });
                                    },
                                  ),
                                  KeyBadItem(
                                    title: "<",
                                    onTap: () {
                                      setState(() {
                                        num == ""
                                            ? null
                                            : num = num.substring(
                                                0, num.length - 1);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        AddPageButton(
                          isDone: true,
                          title: widget.finance != null ? "Edit" : "Done",
                          onPressed: () {
                            if (widget.finance != null) {
                              widget.finance!.details = detailscontroller.text;
                              widget.finance!.value = widget.isDone
                                  ? double.parse(num)
                                  : double.parse(num) < 0
                                      ? double.parse(num)
                                      : double.parse(num) * -1;
                              widget.finance!.save();
                            } else {
                              BlocProvider.of<AddDataCubit>(context)
                                  .addDataToHive(
                                      finance: Finance(
                                          details: detailscontroller.text,
                                          value: widget.isDone
                                              ? double.parse(num)
                                              : double.parse(num) * -1,
                                          dateTime: DateTime.now()));
                            }
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchData();
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchDateData(
                                    dateTime:
                                        BlocProvider.of<FetchDataCubit>(context)
                                            .sel);
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        AddPageButton(
                          isDone: false,
                          title: "Cancel",
                          onPressed: () {
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchData();
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
