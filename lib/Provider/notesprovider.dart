import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notes/themes/pallette.dart';

class Notesprovider with ChangeNotifier {
  bool gridExtend = false;
  bool enableMenu = false;
  bool enableAddMenu = false;
  bool noteAdded = false;

  Color boxcolour = Pallette.sblack;

  List activeColourBOx = [];

  List activeColorIndex = List<int>.filled(1, 2, growable: false);

  void extendGrid() {
    gridExtend = !gridExtend;
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