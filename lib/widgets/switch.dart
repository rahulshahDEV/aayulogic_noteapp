import 'package:flutter/material.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/themes/pallette.dart';
import 'package:provider/provider.dart';

Widget mySwitch(BuildContext context) {
  bool value = context.watch<Themeprovider>().isSwitched;
  return Switch(
    activeColor: Pallette.white,
    activeTrackColor: Pallette.blue,
    inactiveTrackColor: Pallette.sblack,
    inactiveThumbColor: Pallette.white,
    inactiveThumbImage: const AssetImage('Assets/Icons/moon.png'),
    activeThumbImage: const AssetImage('Assets/Icons/sun.png'),
    value: value,
    onChanged: (value) {
      context.read<Themeprovider>().toggleTheme();
    },
  );
}
