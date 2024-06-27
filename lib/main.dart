import 'package:device_friendly_name/device_friendly_name.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/Model/notesmodel.dart';
import 'package:notes/Pages/homescreen.dart';
import 'package:notes/Provider/notesprovider.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/widgets/drawer.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(NoteModalAdapter());
  var box = await Hive.openBox<NoteModal>('notes');
  deviceName = await DeviceFriendlyName.getDeviceFriendlyName();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Themeprovider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Notesprovider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      home: const HomeScreen(),
      themeMode: ThemeMode.system,
      theme: Provider.of<Themeprovider>(context).themeData,
    );
  }
}
