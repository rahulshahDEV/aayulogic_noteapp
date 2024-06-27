import 'package:flutter/material.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:notes/themes/themes.dart';
import 'package:provider/provider.dart';

AlertDialog MyDialog(BuildContext context) {
  final bool isSwitched = context.watch<Themeprovider>().isSwitched;
  return AlertDialog(
    backgroundColor: isSwitched ? Pallette.blue : Pallette.sblack,
    title: Text(
      'SUCCESS',
      style: textStyle,
    ),
    content: Text(
      '* Your Note Has Been Saved Succesfully !',
      style: textStyle,
    ),
    actions: [
      ElevatedButton.icon(
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Color(Pallette.hexColour('#880808')))),
        onPressed: () {
          Navigator.of(context).popUntil(
            (route) => route.isFirst,
          );
        },
        label: Text(
          'CLOSE',
          style: textStyle,
        ),
        icon: Icon(
          Icons.cancel,
          color: Pallette.white,
        ),
      )
    ],
  );
}
