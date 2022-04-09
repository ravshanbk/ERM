// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'creteria_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CriteriaAdapter extends TypeAdapter<Criteria> {
  @override
  final int typeId = 0;

  @override
  Criteria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Criteria()
      ..criteriaLetter = fields[0] as String
      ..criteriaText = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, Criteria obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.criteriaLetter)
      ..writeByte(1)
      ..write(obj.criteriaText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CriteriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
