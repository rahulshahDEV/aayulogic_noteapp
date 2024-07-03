import 'dart:io';

import 'package:flutter/foundation.dart';
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
import 'package:provider/provider.dart';

// var obj = HiveModal();

class AddNote extends StatefulWidget {
  const AddNote(
      {super.key,
      required this.existingTitle,
      required this.imagePath,
      required this.existingNote,
      required this.data});

  final String imagePath;
  final String existingTitle;
  final String existingNote;
  final data;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final List _icons = ['undo.svg', 'redo.svg', 'tick-square.svg'];

  final FocusNode f1 = FocusNode();
  final FocusNode f2 = FocusNode();
  final TextEditingController title = TextEditingController();
  final TextEditingController note = TextEditingController();

  // String _lastWords = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<Notesprovider>(context, listen: false).disposeColour();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    disposeAddNoteField();
  }

  void disposeAddNoteField() {
    title.clear();
    note.clear();
  }

  Widget loadImage() {
    return Image.file(File(widget.imagePath));
  }

  @override
  Widget build(BuildContext context) {
    bool isSwitched = context.watch<Themeprovider>().isSwitched;
    String _lastWords = context.watch<Notesprovider>().lastWords;

    title.text =
        widget.existingTitle.isNotEmpty ? widget.existingTitle : title.text;
    note.text = widget.existingNote.isNotEmpty
        ? _lastWords.isNotEmpty && !widget.existingNote.contains(_lastWords)
            ? widget.existingNote + _lastWords
            : widget.existingNote
        : _lastWords.isNotEmpty && !note.text.contains(_lastWords)
            ? note.text + _lastWords
            : note.text;
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
                  // print(_lastWords + 'djfhkj');
                  if (Element.toString() == 'tick-square.svg') {
                    if (widget.existingNote.isEmpty &&
                        widget.existingTitle.isEmpty) {
                      Boxes.postData(
                          title.text, widget.imagePath, note.text, context);
                    } else {
                      Boxes.updateData(
                          widget.data, title.text, note.text, context);
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
                if (widget.imagePath.isNotEmpty) loadImage(),
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
