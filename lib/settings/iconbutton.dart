import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIconButton extends StatelessWidget {
  const MyIconButton(
      {super.key,
      required this.icon,
      this.height = 20,
      this.width = 20,
      required this.Colour,
      required this.onPress});

  final String icon;
  final double height, width;
  final Color Colour;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPress,
        icon: SvgPicture.asset(
          icon,
          height: height,
          width: width,
          colorFilter: ColorFilter.mode(Colour, BlendMode.srcIn),
        ));
  }
}
