import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/extension/extension.dart';
import 'package:notes/settings/bottomButton.dart';

class NotePageAdd extends StatefulWidget {
  NotePageAdd({super.key});

  @override
  State<NotePageAdd> createState() => _NotePageAddState();
}

class _NotePageAddState extends State<NotePageAdd> {
  final List _icons = [
    {'icon': 'camera.svg', 'text': 'Take Photo'},
    {'icon': 'images.svg', 'text': 'Add Images'},
    {'icon': 'mic.svg', 'text': 'Voice to text'},
    {'icon': 'tick-square.svg', 'text': 'Tick Boxes'}
  ];

  Future<void> pickImage(BuildContext context) async {
    HapticFeedback.vibrate();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      // final tempImage = File(image.path);
      // this.image = tempImage;
      print(image.path);
    } on PlatformException {
      context.showSnackBar('Error Occurred !');
    }
    ;
  }

  Future<void> cameraImage(BuildContext context) async {
    HapticFeedback.vibrate();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;
    } on PlatformException {
      context.showSnackBar('Error !');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      children: [
        ..._icons.map((Element) => MyButton(
              icon: 'Assets/Icons/${Element['icon']}',
              text: Element['text'],
              func: () {
                if (Element['icon'].toString() == 'images.svg') {
                  Boxes.pickAndSaveImage();
                } else if (Element['icon'].toString() == 'camera.svg') {
                  cameraImage(context);
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
