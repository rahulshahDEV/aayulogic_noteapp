import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'notesmodel.g.dart';

@HiveType(typeId: 0)
class NoteModal extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String content;
  @HiveField(2)
  String created;
  @HiveField(3)
  String updated;
  @HiveField(4)
  String imagePath;
  @HiveField(5)
  String colours;
  // @HiveField(4)
  // Color activeBoxColour;

  NoteModal(
      {required this.imagePath,
      required this.title,
      required this.content,
      required this.created,
      required this.updated,
      required this.colours});
}
