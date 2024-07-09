import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static final TextStyle heading1 = GoogleFonts.catamaran(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: .5,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
  );

  static final TextStyle title = GoogleFonts.catamaran(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: .5,
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
  );

  static final TextStyle medium = GoogleFonts.notoSans(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: .5,
      fontWeight: FontWeight.w400,
    ),
  );

  static final TextStyle small = GoogleFonts.notoSans(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: .5,
      fontSize: 12,
      fontWeight: FontWeight.normal,
    ),
  );
}
