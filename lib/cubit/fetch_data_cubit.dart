import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:wallet_app/models/finance.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  List<Finance> financeList = [];
  List<Finance> todayFinanceList = [];
  DateTime sel = DateTime.now();
  double sum = 0.0;
  double todaySum = 0.0;

  fetchData() {
    emit(FetchDataLoading());
    try {
      financeList = Hive.box<Finance>("financeBox").values.toList();
      fetchDateData();
      todaySum = 0;
      sum = 0;
      for (var element in financeList) {
        sum += element.value;
      }
      for (var element in todayFinanceList) {
        todaySum += element.value;
      }
      emit(FetchDataSuccess());
    } catch (e) {
      emit(FetchDataFailure(error: e.toString()));
    }
    return financeList;
  }

  fetchDateData({DateTime? dateTime}) {
    todayFinanceList = Hive.box<Finance>("financeBox")
        .values
        .toList()
        .where((element) =>
            DateFormat.yMMMEd().format(element.dateTime) ==
            DateFormat.yMMMEd().format(dateTime ?? DateTime.now()))
        .toList();
  }
}
