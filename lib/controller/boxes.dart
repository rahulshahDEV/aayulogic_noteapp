import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/Model/notesmodel.dart';
import 'package:notes/extension/extension.dart';

import 'package:notes/widgets/mydialog.dart';
import 'package:path_provider/path_provider.dart';

class Boxes {
  static Box<NoteModal> getData() => Hive.box<NoteModal>('notes');

  static var box = Boxes.getData();

  static Future<void> pickAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');
      print(savedImage.path);
      // final box = await Hive.openBox('images');
      // box.add(savedImage.path); // Store the image path
    }
  }

  static Future<void> postData(String title, note, BuildContext context) async {
    // final Color activeColour = context.watch<Notesprovider>().boxcolour;

    if (note.toString().isNotEmpty) {
      final data = NoteModal(
          title: title,
          content: note,
          // activeBoxColour: Pallette.sblack,
          created: DateTime.now().toString(),
          updated: DateTime.now().toString());
      await box.add(data).then((value) {
        showDialog(
          context: context,
          builder: (context) => MyDialog(context),
        );
      });
      data.save();
    } else {
      context.showSnackBar('Empty Note Discarded !');
    }
  }

  static Future<void> updateData(NoteModal data, String title, note) async {
    // print(box.values.toList().indexOf(data));

    final storedData = box.values.toList();
    int index = storedData.indexOf(data);
    if (index.toString().isNotEmpty) {
      final dataa = NoteModal(
          title: title,
          content: note,
          // activeBoxColour: Pallette.sblack,
          created: DateTime.now().toString(),
          updated: DateTime.now().toString());
      await box.putAt(index, dataa);
      // data.save();
    }
  }

  static Future<void> delete(NoteModal data) async {
    data.delete();
  }

  static Future<void> deleteByMenu(String data, BuildContext context) async {
    final storedData = box.values.toList();

    List<num> filterNumbers(List inputList) =>
        inputList.whereType<num>().toList();

    var index = storedData.map(
      (element) {
        if (element.content == data) {
          return storedData.indexOf(element);
        }
        // return true;
        return '';
      },
    );
    final delIndex = filterNumbers(index.toList());
    try {
      await box.deleteAt(delIndex[0].toInt()).then((value) {
        Navigator.of(context).pop();
        if (data.isNotEmpty) {
          context.showSnackBar('Deleted !');
        }
      });
    } catch (e) {
      context.showSnackBar('NOT FOUND !');
    }
  }
}
