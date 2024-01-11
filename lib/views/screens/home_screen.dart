import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallet_app/core/methods/appbar.dart';
import 'package:wallet_app/core/services/utils.dart';
import 'package:wallet_app/core/styles/colors.dart';
import 'package:wallet_app/cubit/fetch_data_cubit.dart';
import 'package:wallet_app/views/screens/add_page.dart';
import 'package:wallet_app/views/screens/all_activity.dart';
import 'package:wallet_app/views/widgets/home_screen/balanc_widget.dart';
import 'package:wallet_app/views/widgets/home_screen/list_item.dart';
import 'package:quickalert/quickalert.dart';
import '../widgets/home_screen/add_or_remove.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<FetchDataCubit>(context).fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final dada = BlocProvider.of<FetchDataCubit>(context);
    return Scaffold(
      appBar: appBar(context),
      body: BlocBuilder<FetchDataCubit, FetchDataState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: state is FetchDataLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      BalanceWidget(
                        size: size,
                        color: kSecondryPurple,
                        isBottom: false,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BalanceWidget(
                        size: size,
                        color: kSecondryRed,
                        isBottom: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          AddorRemoveMoney(
                            isRemove: false,
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    child: const AddPage(
                                      isDone: true,
                                    ),
                                    type: PageTransitionType.bottomToTop)),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          AddorRemoveMoney(
                            isRemove: true,
                            onTap: () => Navigator.push(
                                context,
                                PageTransition(
                                    child: const AddPage(
                                      isDone: false,
                                    ),
                                    type: PageTransitionType.bottomToTop)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            "Activity",
                            style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                          ),
                          const Spacer(),
                          TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  PageTransition(
                                      child: const AllActivity(),
                                      type: PageTransitionType.bottomToTop)),
                              child: Text(
                                "See All",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                          child: ListView.builder(
                        itemCount: dada.todayFinanceList.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: kSecondryGreen,
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.edit,
                                    color: kPrimaryGreen,
                                  )),
                            ),
                            secondaryBackground: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                          isDone: dada.todayFinanceList.reversed
                                                      .toList()[index]
                                                      .value <
                                                  0
                                              ? false
                                              : true,
                                          finance: dada
                                              .todayFinanceList.reversed
                                              .toList()[index],
                                        ),
                                        type: PageTransitionType.bottomToTop));
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.confirm,
                                  text: 'Do you want to Delete',
                                  confirmBtnText: 'Confirm',
                                  cancelBtnText: 'Cancel',
                                  confirmBtnColor: Colors.green,
                                  onConfirmBtnTap: () {
                                    dada.todayFinanceList.reversed
                                        .toList()[index]
                                        .delete();
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
                            child: ListItem(
                                finance: dada.todayFinanceList.reversed
                                    .toList()[index]),
                          );
                        },
                      ))
                    ],
                  ),
          );
        },
      ),
    );
  }
}
