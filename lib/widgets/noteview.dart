import 'dart:io';

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
      required this.imagePath,
      required this.createdAt,
      required this.boxColour,
      required this.updatedAt});

  final String boxColour;
  final int index;
  final String title; // Title of the note
  final String content; // Content of the note
  final String createdAt; // Timestamp when the note was created (optional)
  final String updatedAt;
  final mydata;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final bool isSwitched = context.watch<Themeprovider>().isSwitched;
    // final Color activeColour = context.watch<Notesprovider>().boxcolour;
    // final List activeIndex = context.watch<Notesprovider>().activeColorIndex;

    // final Color myColour = ;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8)
          .copyWith(right: 0),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          .copyWith(right: 0),
      // height: 200,

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(Pallette.hexColour(boxColour))),

      child: InkWell(
        onTap: () {
          // if(context.watch<Notesprovider>().activeColorIndex != 2){
          //   context.read<Notesprovider>().updateIndex(2);
          // }

          // print(boxColour);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddNote(
              imagePath: imagePath,
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
              if (imagePath.isNotEmpty) Image.file(File(imagePath)),
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
                popOver(context, mydata, isSwitched, content);
              })
        ]),
      ),

      // height: 100,
    );
  }
}
