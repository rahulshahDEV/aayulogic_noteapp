import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/settings/bottomButton.dart';
import 'package:notes/themes/pallette.dart';
import 'package:notes/widgets/notepageadd.dart';
import 'package:notes/widgets/notepagemenu.dart';
import 'package:provider/provider.dart';

class BottomFunctionalites extends StatefulWidget {
  const BottomFunctionalites({super.key, required this.copyNote});
  static DateTime now = DateTime.now();
  final String copyNote;

  @override
  State<BottomFunctionalites> createState() => _BottomFunctionalitesState();
}

class _BottomFunctionalitesState extends State<BottomFunctionalites> {
  String formattedDate =
      DateFormat('EEE H:mm').format(BottomFunctionalites.now);

  @override
  Widget build(BuildContext context) {
    Notesprovider note = context.watch<Notesprovider>();

    bool isSwitched = context.watch<Themeprovider>().isSwitched;

    double height() {
      if (note.enableMenu) {
        return 280;
      } else if (note.enableAddMenu) {
        return 220;
      }
      return 80;
    }

    int length() {
      if (widget.copyNote.length != 0) {
        return widget.copyNote.length;
      }
      return 4096;
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (note.enableMenu) {
          context.read<Notesprovider>().enableMenus();
        } else if (note.enableAddMenu) {
          context.read<Notesprovider>().enableAddMenus();
        }

        // }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        height: height(),
        decoration: BoxDecoration(
            color:
                isSwitched ? Pallette.blue.withOpacity(0.8) : Pallette.sblack,
            borderRadius: BorderRadius.circular(0).copyWith(
                topLeft: const Radius.circular(20),
                topRight: const Radius.circular(20))),
        child: Column(
          children: [
            if (note.enableMenu) ...{
              NotePageMenu(
                copyNote: widget.copyNote,
              ),
            } else if (note.enableAddMenu) ...{
              NotePageAdd()
            },
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyButton(
                  height: 25,
                  width: 25,
                  icon: 'Assets/Icons/add-circle.svg',
                  text: '',
                  func: () {
                    context.read<Notesprovider>().enableAddMenus();
                  },
                ),
                Text(
                  '$formattedDate | ${length()} Character',
                  style: TextStyle(color: Colors.white),
                ),
                MyButton(
                  height: 25,
                  width: 25,
                  icon: 'Assets/Icons/threedot.svg',
                  text: '',
                  func: () {
                    context.read<Notesprovider>().enableMenus();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
