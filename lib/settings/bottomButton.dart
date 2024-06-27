import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notes/themes/pallette.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.icon,
      this.height = 20,
      this.width = 20,
      required this.text,
      required this.func});
  final String icon;
  final String text;
  final VoidCallback func;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              height: height,
              width: width,
              colorFilter: ColorFilter.mode(Pallette.white, BlendMode.srcIn),
            ),
            SizedBox(
              width: width,
            ),
            Text(
              text,
              style: TextStyle(color: Pallette.white),
            )
          ],
        ),
      ),
    );
  }
}
