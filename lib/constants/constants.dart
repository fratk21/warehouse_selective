import 'package:flutter/material.dart';

//colors used in this app
const Color white = Colors.white;
const Color black = Colors.black;
const Color yellow = Color(0xFFFFD54F);
const Color grey_yellow = Color.fromARGB(255, 255, 196, 0);
const Color orange = Color.fromARGB(255, 112, 53, 2);

//default app padding
const double appPadding = 10.0;
double width(BuildContext context) {
  double screenwidth = MediaQuery.of(context).size.width;
  return screenwidth;
}
