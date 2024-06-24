import 'package:flutter/material.dart';

const Color mainColor = Color(0xFFF4A743);
const Color secondaryColor = Color.fromARGB(255, 83, 10, 240);
const Color accentColor = Color(0xFF656265);

const Color textColor = Color(0xFF141314);
const Color textLightColor = Color(0xFF656265);

const Color whiteClr = Color(0xFFFFFFFF);
const Color yellowClr = Color(0xFFF3BD34);
const Color redClr = Color(0xFFFF0000);
const Color grayColor = Color(0xFF656265);
const Color grayColorL2 = Color.fromARGB(255, 178, 176, 178);
const Color titleColor = Color(0xFF70918A);


const Color elevatedButtonBackgroundColor = mainColor;
const Color inputDecorationFocusBorderColor = mainColor;
const Color inputDecorationEnableBorderColor = Color(0xFFF3F3F3);
const Color inputFillColor = Color(0xFFFBFBFB);

Map<int, Color> color = {
  50: const Color.fromRGBO(252, 132, 41, .1),
  100: const Color.fromRGBO(252, 132, 41, .2),
  200: const Color.fromRGBO(252, 132, 41, .3),
  300: const Color.fromRGBO(252, 132, 41, .4),
  400: const Color.fromRGBO(252, 132, 41, .5),
  500: const Color.fromRGBO(252, 132, 41, .6),
  600: const Color.fromRGBO(252, 132, 41, .7),
  700: const Color.fromRGBO(252, 132, 41, .8),
  800: const Color.fromRGBO(252, 132, 41, .9),
  900: const Color.fromRGBO(252, 132, 41, 1),
};
MaterialColor swatchColor = MaterialColor(mainColor.value, color);
