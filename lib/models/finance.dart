import 'package:hive/hive.dart';
part 'finance.g.dart';

@HiveType(typeId: 0)
class Finance extends HiveObject {
  @HiveField(0)
  String details;
  @HiveField(1)
  double value;
  @HiveField(2)
  DateTime dateTime;

  Finance({required this.details, required this.value, required this.dateTime});
}
