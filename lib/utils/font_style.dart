import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFontStyle {
  static styleW400(Color? color, double? fontSize) {
    return GoogleFonts.hankenGrotesk(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w400,
    );
  }

  static styleW500(Color? color, double? fontSize) {
    return GoogleFonts.hankenGrotesk(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
    );
  }

  static styleW600(Color color, double fontSize) {
    return GoogleFonts.hankenGrotesk(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
    );
  }

  static styleW6002(Color color, double fontSize) {
    return GoogleFonts.inter(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
        decorationColor: Colors.white.withValues(alpha: 0.80));
  }

  static styleW6003(Color color, double fontSize) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      // decoration: TextDecoration.underline,
      // decorationColor: Colors.white.withValues(alpha: 0.80),
    );
  }

  static styleW700(Color? color, double? fontSize) {
    return GoogleFonts.hankenGrotesk(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  static styleW7002(Color? color, double? fontSize) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
  }

  static styleW800(Color? color, double? fontSize) {
    return GoogleFonts.hankenGrotesk(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w800,
    );
  }

  static styleW900(Color? color, double? fontSize) {
    return GoogleFonts.hankenGrotesk(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
    );
  }

  static styleW9002(Color? color, double? fontSize) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
    );
  }

  static appBarStyle() {
    return GoogleFonts.hankenGrotesk(
      fontSize: 21,
      letterSpacing: 0.4,
      fontWeight: FontWeight.bold,
    );
  }
}
