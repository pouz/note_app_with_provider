import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static Color bgColor = const Color(0xffe2e2fe);
  static Color mainColor = const Color(0xff000633);
  static Color accentColor = const Color(0xff0065ff);

  // setting the Cards different Color

  static List<Color> cardsColor = [
    Colors.white,
    Colors.red.shade100,
    Colors.pink.shade100,
    Colors.orange.shade100,
    Colors.yellow.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.blueGrey.shade100,
  ];

  // Setting the text style

  static TextStyle mainTitle = GoogleFonts.roboto(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mainContent = GoogleFonts.nunito(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );

  static TextStyle dateTitle = GoogleFonts.roboto(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
  );

  static TextStyle mainDesc = GoogleFonts.roboto(
    color: Colors.white,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle mainWarn = GoogleFonts.nunito(
    color: Colors.white,
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
  );
}
