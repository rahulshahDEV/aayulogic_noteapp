import 'package:flutter/material.dart';
import 'package:notes/themes/pallette.dart';

extension Extension on BuildContext {
  void showSnackBar(String message, {int myduration = 360}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        backgroundColor: Pallette.black,
        duration: Duration(milliseconds: myduration),
        content: Center(
            child: Text(
          message,
          style: const TextStyle(fontSize: 20),
        ))));
  }
}
