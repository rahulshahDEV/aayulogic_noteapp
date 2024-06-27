import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/extension/extension.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/settings/colourpalltte.dart';
import 'package:notes/themes/pallette.dart';
import 'package:provider/provider.dart';

class NotePageMenu extends StatelessWidget {
  NotePageMenu({super.key, required this.copyNote});

  final List _icons = [
    {'icon': 'delete.svg', 'text': 'Delete Note'},
    {'icon': 'copy.svg', 'text': 'Make a copy'},
    {'icon': 'myshare.svg', 'text': 'Share'},
    {'icon': 'label.svg', 'text': 'Labels'}
  ];

  final List colours = [
    Pallette.blue,
    Pallette.yellow,
    Pallette.white,
    Pallette.pink,
    Pallette.green,
    Pallette.orange,
    Pallette.black
  ];
  final String copyNote;

  @override
  Widget build(BuildContext context) {
    Future<void> copy() async {
      HapticFeedback.vibrate();
      final value = ClipboardData(text: copyNote);

      await Clipboard.setData(value)
          .then((value) => context.showSnackBar('Copied !'));
    }

    return Flexible(
        child: Column(
      children: [
        Flexible(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: colours.length,
            itemBuilder: (context, index) => ColourPalltte(
              func: () {
                context
                    .read<Notesprovider>()
                    .updateIndex(index, colours[index]);
              },
              index: index,
              mycolour: colours[index],
            ),
            separatorBuilder: (context, index) => const SizedBox(
              width: 15,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ..._icons.map((Element) => MyButton(
              icon: 'Assets/Icons/${Element['icon']}',
              text: Element['text'],
              func: () {
                if (Element['icon'].toString() == 'copy.svg') {
                  copy();
                } else if (Element['icon'].toString() == 'delete.svg') {
                  HapticFeedback.vibrate();
                  Boxes.deleteByMenu(copyNote, context);
                }
              },
            )),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}
