import 'package:flutter/material.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:popover/popover.dart';

Future popOver(BuildContext context, var mydata, bool isSwitched) {
  return showPopover(
      backgroundColor: isSwitched ? Pallette.blue : Pallette.sblack,
      width: 160,
      height: 90,
      context: context,
      bodyBuilder: (context) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                MyButton(
                    icon: 'Assets/Icons/delete.svg',
                    text: 'Delete Note',
                    func: () {
                      Boxes.delete(mydata);
                      Navigator.pop(context);
                    }),
                const Spacer(),
                MyButton(
                    icon: 'Assets/Icons/share.svg',
                    text: 'Share Note',
                    func: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
      direction: PopoverDirection.bottom);
}
