import 'package:flutter/material.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:provider/provider.dart';

class ColourPalltte extends StatelessWidget {
  ColourPalltte(
      {super.key,
      required this.func,
      required this.index,
      required this.mycolour});
  Color mycolour;
  VoidCallback func;
  int index;

  @override
  Widget build(BuildContext context) {
    final List activeIndex = context.watch<Notesprovider>().activeColorIndex;

    return InkWell(
      onTap: func,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: mycolour,
        child: activeIndex.contains(index)
            ? Icon(Icons.check, color: Colors.grey.shade400)
            : const Text(''),
      ),
    );
  }
}
