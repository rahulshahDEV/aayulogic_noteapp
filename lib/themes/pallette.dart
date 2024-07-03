import 'package:flutter/material.dart';

class Pallette {
  static final Color black = Color(hexColour('#0E121B'));
  static final Color white = Color(hexColour('#FFFFFF'));
  static final Color blue = Color(hexColour('#3B69FA'));
  static final Color yellow = Color(hexColour('#FFD666'));
  static final Color pink = Color(hexColour('#8E33FF'));
  static final Color green = Color(hexColour('#77ED8B'));
  static final Color orange = Color(hexColour('#FF5630'));
  static final Color bottomblack = Color(hexColour('#141A21'));
  static final Color sblack = Color(hexColour('#2E323C'));
  static final Color sblue = Color(hexColour('#DB83A9'));

  static int hexColour(String colour) {
    String newColour = '0xff' + colour;
    newColour = newColour.replaceAll('#', '');
    int finalColour = int.parse(newColour);
    // print(finalColour);
    return finalColour;
  }
}
