import 'package:flutter/material.dart';
import 'package:notes/Pages/addnote.dart';
import 'package:notes/themes/pallette.dart';

class FloatingBTN extends StatelessWidget {
  const FloatingBTN({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 40),
      height: 65,
      width: 65,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Pallette.black]),
          // color: Pallette.black,
          borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.all(5),
      child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: Pallette.blue,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddNote(
                imagePath: '',
                data: '',
                existingNote: '',
                existingTitle: '',
              ),
            ));
          },
          child: Icon(
            Icons.add,
            color: Pallette.white,
            size: 30,
          )),
    );
  }
}
