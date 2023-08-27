import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String? validator(String? value) {
  if (value!.isEmpty) {
    return 'Please enter valid value';
  } else {
    return null;
  }
}
TextStyle textTheme({
  double fontSize = 16.0,
  Color color = Colors.white,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return GoogleFonts.eduNswActFoundation(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,

  );
}
