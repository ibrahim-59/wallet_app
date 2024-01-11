import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:wallet_app/models/finance.dart';

part 'add_data_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataInitial());

  addDataToHive({required Finance finance}) async {
    emit(AddDataLoading());
    try {
      await Hive.box<Finance>("financeBox").add(finance);
      emit(AddDataSuccess());
    } on Exception catch (e) {
      emit(AddDataFailure(error: e.toString()));
    }
  }
}
