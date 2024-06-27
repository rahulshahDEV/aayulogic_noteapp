import 'package:flutter/material.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/themes/pallette.dart';
import 'package:provider/provider.dart';

class TextFieldNote extends StatelessWidget {
  const TextFieldNote(
      {super.key,
      required this.text,
      required this.myController,
      required this.myFocusNode,
      required this.changeFocus,
      required this.fontSize,
      this.autoFocus = false});

  final text;
  final double fontSize;
  final bool autoFocus;
  final FocusNode myFocusNode;
  final VoidCallback changeFocus;
  final TextEditingController myController;

  @override
  Widget build(BuildContext mycontext) {
    bool isSwitched = mycontext.watch<Themeprovider>().isSwitched;
    return TextFormField(
      controller: myController,
      onFieldSubmitted: (value) {
        changeFocus();
      },
      textInputAction: TextInputAction.done,
      autofocus: autoFocus,
      focusNode: myFocusNode,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      cursorColor: Pallette.blue,
      style: TextStyle(
          color: isSwitched ? Pallette.blue : Pallette.white,
          fontSize: fontSize),
      decoration: InputDecoration.collapsed(
          hintText: text,
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSwitched
                  ? Pallette.blue.withOpacity(0.3)
                  : Pallette.white.withOpacity(0.3),
              letterSpacing: 2,
              fontSize: fontSize)),
    );
  }
}
