import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/Model/notesmodel.dart';

import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/controller/boxes.dart';
import 'package:notes/themes/pallette.dart';
import 'package:notes/widgets/bottomnavigation.dart';
import 'package:notes/widgets/drawer.dart';
import 'package:notes/widgets/floatingActionBTN.dart';
import 'package:notes/widgets/noteview.dart';

import 'package:notes/widgets/searchbar.dart';
import 'package:notes/widgets/switch.dart';
import 'package:provider/provider.dart';

final drawerController = AdvancedDrawerController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool gridExtend = context.watch<Notesprovider>().gridExtend;
    final bool isSwitched = context.watch<Themeprovider>().isSwitched;

    return AdvancedDrawer(
      backdropColor: isSwitched ? Pallette.white : Pallette.black,
      controller: drawerController,
      drawer: MyDrawer(),
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const FloatingBTN(),
          appBar: AppBar(
            title: const Text(
              'Notes',
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            actions: [mySwitch(context)],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                searchBar(context),
                const SizedBox(
                  height: 20,
                ),
                ValueListenableBuilder<Box<NoteModal>>(
                    valueListenable: Boxes.getData().listenable(),
                    builder: (context, box, child) {
                      var data = box.values.toList().reversed.toList();

                      return Flexible(
                        child: MasonryGridView.builder(
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: gridExtend ? 1 : 2),
                          itemCount: box.length,
                          itemBuilder: (context, index) => Noteview(
                            index: index,
                            mydata: data[index],
                            content: data[index].content,
                            title: data[index].title,
                            createdAt: data[index].created,
                            updatedAt: DateTime.now().toString(),
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: bottomNavigationBar(context),
          )),
    );
  }
}
