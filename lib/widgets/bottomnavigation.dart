import 'package:flutter/material.dart';
import 'package:notes/Pages/addnote.dart';
import 'package:notes/Provider/themeprovider.dart';

import 'package:notes/settings/iconbutton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:provider/provider.dart';

Widget bottomNavigationBar(BuildContext context) {
  bool isSwitched = context.watch<Themeprovider>().isSwitched;
  final List _icons = [
    'tick-square.svg',
    'mic.svg',
    'camera.svg',
    'setting.svg'
  ];
  return Stack(clipBehavior: Clip.none, children: [
    Container(
      height: 60,
      decoration: BoxDecoration(
          color: isSwitched ? Pallette.blue : Pallette.sblack,
          borderRadius: BorderRadius.circular(0).copyWith(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  // ...['a','b'].map((e)=> MyIconButton(icon:e , Colour: Colour, onPress: onPress))
                  ..._icons.map((element) => MyIconButton(
                      height: 25,
                      width: 25,
                      icon: 'Assets/Icons/${element}',
                      Colour: Pallette.white,
                      onPress: () {}))
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  ]);
}
