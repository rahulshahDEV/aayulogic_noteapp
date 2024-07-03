import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Notesprovider with ChangeNotifier {
  bool gridExtend = false;
  bool enableMenu = false;
  bool enableAddMenu = false;
  bool noteAdded = false;
  bool voiceIsenabled = false;

  SpeechToText speechToText = SpeechToText();
  bool isListening = false;
  String lastWords = '';
  final List colours = [
    '#3B69FA',
    '#FFD666',
    '#494C51',
    '#8E33FF',
    '#77ED8B',
    '#FF5630',
    '#2E323C'
  ];

  // String get getLastWords => _lastWords;

  String boxcolour = '#2E323C';

  List activeColourBOx = [];

  List activeColorIndex = List<int>.filled(1, 2, growable: false);

  void setLastWords(String words) {
    lastWords = words;
    notifyListeners();
  }

  void voiceListening(bool listenme) {
    isListening = listenme;

    if (!isListening) {
      lastWords = '';
    }

    notifyListeners();
  }

  void extendGrid() {
    gridExtend = !gridExtend;
    notifyListeners();
  }

  void enableVoice() {
    voiceIsenabled = !voiceIsenabled;

    notifyListeners();
  }

  void uiUpdate() {
    noteAdded = !noteAdded;
  }

  void enableMenus() {
    enableMenu = !enableMenu;
    if (enableAddMenu) {
      enableAddMenu = false;
    }

    notifyListeners();
  }

  void enableAddMenus() {
    enableAddMenu = !enableAddMenu;

    if (enableMenu) {
      enableMenu = false;
    }
    if (enableAddMenu) {
      voiceIsenabled = false;
    }
    notifyListeners();
  }

  void updateIndex(int index) {
    activeColorIndex[0] = index;
    // if (index != 2) {
    boxcolour = colours[index];
    // } else {
    // boxcolour = colours[2];
    // }
    notifyListeners();
  }

  void disposeColour() {
    boxcolour = '#2E323C';
  }
}
