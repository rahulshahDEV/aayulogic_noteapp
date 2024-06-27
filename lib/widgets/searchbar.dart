import 'package:flutter/material.dart';
import 'package:notes/Pages/homescreen.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/settings/iconbutton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:notes/widgets/drawer.dart';
import 'package:provider/provider.dart';

OutlineInputBorder style = OutlineInputBorder(
    borderSide: const BorderSide(style: BorderStyle.none),
    borderRadius: BorderRadius.circular(20));

void showDrawer() {
  drawerController.showDrawer();
}

Widget searchBar(BuildContext context) {
  bool isSwitched = context.watch<Themeprovider>().isSwitched;
  bool isgridExtended = context.watch<Notesprovider>().gridExtend;
  return Container(
    decoration: BoxDecoration(
        color: isSwitched ? Pallette.blue : Pallette.sblack,
        borderRadius: BorderRadius.circular(20)),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: TextField(
        style: TextStyle(color: Pallette.white),
        decoration: InputDecoration(
          // border: InputBorder.none,
          hintText: 'Search Your Note',
          hintStyle: TextStyle(color: Pallette.white, letterSpacing: 1.5),
          suffixIcon: Consumer(
            builder: (context, value, child) => MyIconButton(
              icon: isgridExtended
                  ? 'Assets/Icons/grid1.svg'
                  : 'Assets/Icons/grid2.svg',
              height: 25,
              width: 25,
              Colour: Pallette.white,
              onPress: () {
                context.read<Notesprovider>().extendGrid();
              },
            ),
          ),
          prefixIcon: MyIconButton(
            icon: 'Assets/Icons/menu.svg',
            Colour: Pallette.white,
            onPress: () {
              showDrawer();
            },
          ),
          enabledBorder: style,
          focusedBorder: style,
        )),
  );
}
