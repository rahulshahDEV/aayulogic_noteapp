import 'package:flutter/material.dart';
import 'package:notes/Provider/themeprovider.dart';
import 'package:notes/themes/pallette.dart';
import 'package:notes/themes/themes.dart';
import 'package:notes/widgets/switch.dart';
import 'package:provider/provider.dart';

String? deviceName;

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSwitched = context.watch<Themeprovider>().isSwitched;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0)
          .copyWith(left: 10, top: 60),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
          .copyWith(top: 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: isSwitched ? Pallette.black : Pallette.sblack)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
                'https://blogger.googleusercontent.com/img/a/AVvXsEgcpcGv6qdclLoPDIVpr5agLwpxENM0Xpv-VdWI9AKwPa-zLs3Fp-cxEcETAgj2gDiP6j6ctQikm4IhXdBPgYxI6n55GiZjJ5G_qdjUyH-PkoGysvBhk0W1dvzKwI_f7_JflaDBNol1LwuU8gkIiLbON_qZ3kUqPsEAlgihybJ3vC77KllS8juZrbySxA'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              deviceName.toString().toUpperCase(),
              style: TextStyle(
                  fontSize: 15,
                  color: isSwitched ? Pallette.black : Pallette.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sync With',
                style: textStyle,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 60),
                clipBehavior: Clip.hardEdge,
                height: 20,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image.asset('Assets/Images/google.jpeg'),
              ),
              Switch(
                activeTrackColor: Pallette.blue,
                value: true,
                onChanged: (value) {},
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                isSwitched ? 'Light Mode' : 'Dark Mode',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSwitched ? Pallette.black : Pallette.sblack),
              ),
              mySwitch(context)
            ],
          )
        ],
      ),
    );
  }
}
