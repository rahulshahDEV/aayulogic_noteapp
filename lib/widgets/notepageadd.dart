import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  final SpeechToText _speechToText = SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void disposeLastwords() {
    lastWords = '';
  }

  Future<void> startListening(BuildContext context) async {
    try {
      await _speechToText.listen(
        onResult: (r) => onSpeechResult(r, context),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void onSpeechResult(
      SpeechRecognitionResult result, BuildContext context) async {
    lastWords = result.recognizedWords;

    if (_speechToText.isNotListening) {
      context.read<Notesprovider>().setLastWords(lastWords);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isVoiceEnabled = context.watch<Notesprovider>().voiceIsenabled;
    // bool voiceListening = context.watch<Notesprovider>().isListening;

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
          Stack(children: [
            Center(
              child: !_speechToText.isListening
                  ? Icon(
                      size: 100,
                      Icons.mic_off,
                      color: Pallette.white,
                    )
                  : Lottie.asset(
                      height: 100,
                      width: 100,
                      'Assets/Icons/listen1.json',
                    ),
            ),
            _speechToText.isListening
                ? IconButton(
                    onPressed: () {
                      context
                          .read<Notesprovider>()
                          .voiceListening(_speechToText.isListening);
                      stopListening();
                    },
                    icon: const Icon(
                      Icons.square,
                      color: Colors.red,
                    ))
                : IconButton(
                    onPressed: () async {
                      context
                          .read<Notesprovider>()
                          .voiceListening(_speechToText.isListening);

                      await startListening(context);

                      // print(res.toString() + 'nini mini mango');

                      // context.read<Notesprovider>().setLastWords('');
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: Pallette.blue,
                      size: 30,
                    )),
          ])
        ]
      ],
    ));
  }
}
