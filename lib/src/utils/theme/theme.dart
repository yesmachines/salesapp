import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class YAppTheme{
  YAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primarySwatch: const MaterialColor(0XFF9DC33B, <int, Color>{
      50: Color(0x1AF1F8E9),
      100: Color(0x33DCEDC8),
      200: Color(0x4DC5E1A5),
      300: Color(0x66AED581),
      400: Color(0x809CCC65),
      500: Color(0XFF9DC33B),
      600: Color(0x997CB342),
      700: Color(0xB3689F38),
      800: Color(0xCC558B2F),
      900: Color(0xE633691E),
    }),
    textTheme: TextTheme(
        headline1: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 28.0
        ),
      headline2: GoogleFonts.roboto(
        color: Colors.black87,
        fontSize: 24.0
      ),
      bodyText1: GoogleFonts.poppins(
          fontSize: 16.0,
        color: Colors.black54
      ),
      button: GoogleFonts.poppins(
        fontSize: 16.0,
       fontWeight: FontWeight.w500,
       color: Colors.white,
      ),
    ),
    backgroundColor: Colors.white70,
    iconTheme:IconThemeData(
      color: Colors.black87
    )
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      primarySwatch: const MaterialColor(0XFF9DC33B, <int, Color>{
      50: Color(0x1AF1F8E9),
      100: Color(0x33DCEDC8),
      200: Color(0x4DC5E1A5),
      300: Color(0x66AED581),
      400: Color(0x809CCC65),
      500: Color(0XFF9DC33B),
      600: Color(0x997CB342),
      700: Color(0xB3689F38),
      800: Color(0xCC558B2F),
      900: Color(0xE633691E),
    }),
    textTheme: TextTheme(
        headline1: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 28.0
        ),
        headline2: GoogleFonts.roboto(
            color: Colors.white70,
            fontSize: 24.0
        ),
        bodyText1: GoogleFonts.poppins(
            fontSize: 16.0,
            color: Colors.white70
        ),
        bodyText2: GoogleFonts.poppins(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
        ),
        button: GoogleFonts.poppins(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: Colors.white,

        )
    ),
    backgroundColor: Colors.black54,
    iconTheme:IconThemeData(
          color: Colors.white70
      )
  );
}