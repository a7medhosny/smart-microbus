import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle bold(double size) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.bold);

  static TextStyle semiBold(double size) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.w600);

  static TextStyle medium(double size, {Color? color}) => GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: color ?? Colors.black,
  );

  static TextStyle regular(double size, {Color? color}) {
    return TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w400,
      color: color ?? Colors.black,
    );
  }

  static TextStyle light(double size) =>
      GoogleFonts.poppins(fontSize: size, fontWeight: FontWeight.w300);
}
