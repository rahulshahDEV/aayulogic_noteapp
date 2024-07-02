import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/themes/pallette.dart';
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

  // String get getLastWords => _lastWords;

  Color boxcolour = Pallette.sblack;

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

  void updateIndex(int index, Color activeColour) {
    activeColorIndex[0] = index;
    if (activeColour == Color(0xffffffff)) {
      boxcolour = Pallette.sblack;
    } else if (activeColour == Color(0xff0e121b)) {
      boxcolour = Pallette.bottomblack;
    } else {
      boxcolour = activeColour;
    }
    print(activeColour);

    notifyListeners();
  }
}
