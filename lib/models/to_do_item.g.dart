// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'to_do_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ToDoItemAdapter extends TypeAdapter<ToDoItem> {
  @override
  final int typeId = 0;

  @override
  ToDoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ToDoItem(
      id: fields[0] as String?,
      title: fields[1] as String,
      description: fields[2] as String?,
      reqDescription: fields[3] as bool,
      dateCreated: fields[4] as DateTime?,
      dateFinished: fields[5] as DateTime?,
      completion: fields[6] as bool,
      priority: fields[7] as String?,
      dueDate: fields[8] as DateTime?,
      reqDueDate: fields[9] as bool,
      allDay: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ToDoItem obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.reqDescription)
      ..writeByte(4)
      ..write(obj.dateCreated)
      ..writeByte(5)
      ..write(obj.dateFinished)
      ..writeByte(6)
      ..write(obj.completion)
      ..writeByte(7)
      ..write(obj.priority)
      ..writeByte(8)
      ..write(obj.dueDate)
      ..writeByte(9)
      ..write(obj.reqDueDate)
      ..writeByte(10)
      ..write(obj.allDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ToDoItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
