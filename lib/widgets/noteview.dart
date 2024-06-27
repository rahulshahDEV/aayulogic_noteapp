import 'package:flutter/material.dart';
import 'package:notes/Pages/addnote.dart';
import 'package:notes/Provider/notesprovider.dart';

import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/settings/iconbutton.dart';

import 'package:notes/themes/pallette.dart';
import 'package:notes/widgets/popover.dart';
import 'package:popover/popover.dart';
import 'package:provider/provider.dart';

class Noteview extends StatelessWidget {
  const Noteview(
      {super.key,
      required this.mydata,
      required this.content,
      required this.title,
      required this.index,
      required this.createdAt,
      required this.updatedAt});
  final int index;
  final String title; // Title of the note
  final String content; // Content of the note
  final String createdAt; // Timestamp when the note was created (optional)
  final String updatedAt;
  final mydata;

  @override
  Widget build(BuildContext context) {
    final bool isSwitched = context.watch<Themeprovider>().isSwitched;
    final Color activeColour = context.watch<Notesprovider>().boxcolour;
    final List activeIndex = context.watch<Notesprovider>().activeColorIndex;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8)
          .copyWith(right: 0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          .copyWith(right: 0),
      // height: 200,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSwitched ? Pallette.blue : Pallette.sblack),

      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNote(
              data: mydata,
              existingNote: content,
              existingTitle: title,
            ),
          ));
        },
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Flexible(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                title,
                style: TextStyle(color: Pallette.white, fontSize: 15),
              ),
              Text(
                content,
                style: TextStyle(color: Pallette.white, fontSize: 12),
              )
            ]),
          ),
          MyIconButton(
              icon: 'Assets/Icons/threedot.svg',
              Colour: Pallette.white,
              onPress: () {
                popOver(context, mydata, isSwitched);
              })
        ]),
      ),

      // height: 100,
    );
  }
}
