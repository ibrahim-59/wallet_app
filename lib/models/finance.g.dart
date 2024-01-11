// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinanceAdapter extends TypeAdapter<Finance> {
  @override
  final int typeId = 0;

  @override
  Finance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Finance(
      details: fields[0] as String,
      value: fields[1] as double,
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Finance obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.details)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
