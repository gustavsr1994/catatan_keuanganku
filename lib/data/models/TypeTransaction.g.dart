// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TypeTransaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeTransactionAdapter extends TypeAdapter<TypeTransaction> {
  @override
  final int typeId = 0;

  @override
  TypeTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeTransaction(
      nameTransaction: fields[0] as String,
      type: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TypeTransaction obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameTransaction)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
