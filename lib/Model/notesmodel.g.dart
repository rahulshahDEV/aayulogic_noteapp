// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notesmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteModalAdapter extends TypeAdapter<NoteModal> {
  @override
  final int typeId = 0;

  @override
  NoteModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NoteModal(
      imagePath: fields[4] as String,
      title: fields[0] as String,
      content: fields[1] as String,
      created: fields[2] as String,
      updated: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NoteModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.created)
      ..writeByte(3)
      ..write(obj.updated)
      ..writeByte(4)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
