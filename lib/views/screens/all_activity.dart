import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wallet_app/cubit/fetch_data_cubit.dart';
import 'package:wallet_app/models/finance.dart';
import 'package:wallet_app/views/screens/add_page.dart';
import 'package:wallet_app/views/widgets/home_screen/list_item.dart';

import '../../core/styles/colors.dart';

class AllActivity extends StatefulWidget {
  const AllActivity({super.key});

  @override
  State<AllActivity> createState() => _AllActivityState();
}

class _AllActivityState extends State<AllActivity> {
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  @override
  void initState() {
    BlocProvider.of<FetchDataCubit>(context)
        .fetchDateData(dateTime: selectedDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Activity"),
      ),
      body: BlocBuilder<FetchDataCubit, FetchDataState>(
        builder: (context, state) {
          return Column(
            children: [
              TableCalendar(
                firstDay: DateTime(2024),
                lastDay: DateTime.now(),
                focusedDay: focusedDate,
                calendarFormat: calendarFormat,
                currentDay: selectedDate,
                onFormatChanged: (format) {
                  setState(() {
                    calendarFormat = format;
                  });
                },
                onDaySelected: (selectedDay, focusedDay) {
                  selectedDate = selectedDay;
                  focusedDate = focusedDay;
                  BlocProvider.of<FetchDataCubit>(context)
                      .fetchDateData(dateTime: selectedDay);
                  BlocProvider.of<FetchDataCubit>(context).sel = selectedDay;
                  setState(() {});
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: BlocProvider.of<FetchDataCubit>(context)
                    .todayFinanceList
                    .length,
                itemBuilder: (context, index) {
                  List<Finance> myList =
                      BlocProvider.of<FetchDataCubit>(context)
                          .todayFinanceList
                          .reversed
                          .toList();
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: kSecondryGreen,
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.edit,
                            color: kPrimaryGreen,
                          )),
                    ),
                    secondaryBackground: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: kSecondryRed,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: kPrimaryRed,
                          )),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: AddPage(
                                  isDone:
                                      myList[index].value > 0 ? true : false,
                                  finance: myList[index],
                                ),
                                type: PageTransitionType.bottomToTop));
                      } else if (direction == DismissDirection.endToStart) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Do you want to Delete',
                          confirmBtnText: 'Confirm',
                          cancelBtnText: 'Cancel',
                          confirmBtnColor: Colors.green,
                          onConfirmBtnTap: () {
                            myList[index].delete();
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchData();
                            Navigator.pop(context);
                          },
                          onCancelBtnTap: () {
                            BlocProvider.of<FetchDataCubit>(context)
                                .fetchData();
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    child: ListItem(finance: myList[index]),
                  );
                },
              ))
            ],
          );
        },
      ),
    );
  }
}
