import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/extension/extension.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:provider/provider.dart';

class NotePageAdd extends StatefulWidget {
  NotePageAdd({super.key, required this.copyNote});

  @override
  State<NotePageAdd> createState() => _NotePageAddState();
  final String copyNote;
}

class _NotePageAddState extends State<NotePageAdd> {
  final List _icons = [
    {'icon': 'images.svg', 'text': 'Add Images'},
    {'icon': 'mic.svg', 'text': 'Voice to text'},
    {'icon': 'tick-square.svg', 'text': 'Tick Boxes'}
  ];

  @override
  Widget build(BuildContext context) {
    bool isVoiceEnabled = context.watch<Notesprovider>().voiceIsenabled;
    return Flexible(
        child: Column(
      children: [
        if (!isVoiceEnabled) ...[
          ..._icons.map((Element) => MyButton(
                icon: 'Assets/Icons/${Element['icon']}',
                text: Element['text'],
                func: () {
                  if (Element['icon'].toString() == 'images.svg') {
                    Boxes.pickAndSaveImage(widget.copyNote, context);
                  } else if (Element['icon'].toString() == 'mic.svg') {
                    context.read<Notesprovider>().enableVoice();
                  }
                },
              )),
          const SizedBox(
            height: 10,
          ),
        ] else ...[
          Center(
            child: Icon(
              Icons.mic,
              size: 100,
              color: Pallette.white,
            ),
          )
        ]
      ],
    ));
  }
}
