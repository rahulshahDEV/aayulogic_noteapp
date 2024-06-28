import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/Provider/notesprovider.dart';

import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/settings/buttonFucntionalities.dart';
import 'package:notes/settings/iconbutton.dart';
import 'package:notes/settings/textfieldnote.dart';
import 'package:notes/themes/pallette.dart';
import 'package:notes/themes/themes.dart';
import 'package:provider/provider.dart';

// var obj = HiveModal();

class AddNote extends StatelessWidget {
  AddNote(
      {super.key,
      required this.existingTitle,
      required this.imagePath,
      required this.existingNote,
      required this.data});

  final List _icons = ['undo.svg', 'redo.svg', 'tick-square.svg'];

  final FocusNode f1 = FocusNode();
  final String imagePath;

  final FocusNode f2 = FocusNode();

  final TextEditingController title = TextEditingController();

  final TextEditingController note = TextEditingController();

  final String existingTitle;
  final String existingNote;
  final data;

  void disposeAddNoteField() {
    title.clear();
    note.clear();
  }

  Widget loadImage() {
    return Image.file(File(imagePath));
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched = context.watch<Themeprovider>().isSwitched;
    // String path = context.watch<Notesprovider>().imagePath;

    title.text = existingTitle.isNotEmpty ? existingTitle : title.text;
    note.text = existingNote.isNotEmpty ? existingNote : note.text;
    return Scaffold(
        appBar: AppBar(
          leading: MyIconButton(
            height: 22,
            width: 22,
            icon: 'Assets/Icons/back.svg',
            Colour: isSwitched ? Pallette.blue : Pallette.white,
            onPress: () => Navigator.pop(context),
          ),
          actions: [
            ..._icons.map((Element) => MyIconButton(
                height: 25,
                width: 25,
                icon: 'Assets/Icons/${Element}',
                Colour: isSwitched ? Pallette.blue : Pallette.white,
                onPress: () {
                  if (Element.toString() == 'tick-square.svg') {
                    if (existingNote.isEmpty && existingTitle.isEmpty) {
                      Boxes.postData(title.text, imagePath, note.text, context);
                    } else {
                      Boxes.updateData(data, title.text, note.text);
                      Navigator.pop(context);
                    }

                    // disposeAddNoteField();
                  }
                }))
          ],
        ),
        body: GestureDetector(
          // splashColor: Pallette.black,
          onTap: () {
            FocusScope.of(context).requestFocus(f2);
          },
          child: Container(
            height: double.infinity,
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
            child: ListView(
              children: [
                if (imagePath.isNotEmpty) loadImage(),
                TextFieldNote(
                  myController: title,
                  myFocusNode: f1,
                  text: 'Title',
                  fontSize: 25,
                  autoFocus: true,
                  changeFocus: () {
                    FocusScope.of(context).requestFocus(f2);
                  },
                ),
                TextFieldNote(
                  myController: note,
                  myFocusNode: f2,
                  text: 'Your Note..',
                  fontSize: 15,
                  changeFocus: () {
                    note.text += '\n';
                    note.selection = TextSelection.fromPosition(
                      TextPosition(offset: note.text.length),
                    ); //
                    f2.requestFocus();
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: BottomFunctionalites(
            copyNote: note.text,
          ),
        ));
  }
}
