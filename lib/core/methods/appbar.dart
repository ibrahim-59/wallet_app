import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 0,
    title: Text(
      "Welcome",
      style: GoogleFonts.lobster(),
    ),
    actions: [
      ValueListenableBuilder(
        valueListenable: Hive.box("darkModeBox").listenable(),
        builder: (context, box, child) {
          var darkMode = box.get("darkMode", defaultValue: false);
          return IconButton(
              onPressed: () {
                box.put("darkMode", !darkMode);
              },
              icon: Icon(
                darkMode
                    ? Icons.brightness_2_outlined
                    : Icons.brightness_5_rounded,
              ));
        },
      )
    ],
  );
}
