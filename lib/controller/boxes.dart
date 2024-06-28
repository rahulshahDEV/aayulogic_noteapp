import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/Model/notesmodel.dart';
import 'package:notes/extension/extension.dart';

import 'package:notes/widgets/mydialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Boxes {
  static Box<NoteModal> getData() => Hive.box<NoteModal>('notes');

  static var box = Boxes.getData();

  static void shareText(String sharetext) async {
    try {
      await Share.share(sharetext);
    } catch (e) {
      print(e);
    }
  }

  static Future<void> pickAndSaveImage(
      String data, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImage =
          await File(pickedFile.path).copy('${appDir.path}/$fileName');
      print(savedImage.path);

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
      try {
        final int imageIndex = filterNumbers(index.toList())[0].toInt();
        final datas = box.getAt(imageIndex);

        final dataa = NoteModal(
            imagePath: savedImage.path,
            title: datas!.title,
            content: datas.content,
            // activeBoxColour: Pallette.sblack,
            created: DateTime.now().toString(),
            updated: DateTime.now().toString());

        await box.putAt(imageIndex, dataa);
      } on RangeError {
        context.showSnackBar('Save Note To Add Image', myduration: 1000);
      } catch (e) {
        context.showSnackBar(e.toString());
      }
      //  imageIndex = imageIndex[0].toInt();
    }
  }

  static Future<void> postData(
      String title, imagePath, note, BuildContext context) async {
    // final Color activeColour = context.watch<Notesprovider>().boxcolour;

    if (note.toString().isNotEmpty) {
      final data = NoteModal(
          title: title,
          content: note,
          imagePath: imagePath.toString().isNotEmpty ? imagePath : '',
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
          imagePath: data.imagePath,
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
      context.showSnackBar('Note Not Saved !');
    }
  }
}
