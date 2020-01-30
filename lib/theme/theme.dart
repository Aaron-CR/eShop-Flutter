import 'package:eshop/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// TODO: Reorganize and refactor Theme
// TODO: add final to all fields

TextTheme textTheme = TextTheme(
  display4: GoogleFonts.openSans(
    fontSize: 98,
  ),
  display3: GoogleFonts.openSans(
    fontSize: 61,
  ),
  display2: GoogleFonts.openSans(
    fontSize: 49,
  ),
  display1: GoogleFonts.openSans(
    fontSize: 35,
  ),
  headline: GoogleFonts.openSans(
    fontSize: 24,
  ),
  title: GoogleFonts.openSans(
    fontSize: 20,
  ),
  subhead: GoogleFonts.openSans(
    fontSize: 16,
  ),
  body2: GoogleFonts.openSans(
    fontSize: 17,
  ),
  body1: GoogleFonts.openSans(
    fontSize: 15,
  ),
  caption: GoogleFonts.openSans(
    fontSize: 13,
  ),
  button: GoogleFonts.openSans(
    fontSize: 15,
  ),
  subtitle: GoogleFonts.openSans(
    fontSize: 14,
  ),
  overline: GoogleFonts.openSans(
    fontSize: 11,
  ),
).apply(
  bodyColor: Colors.black54,
  displayColor: Colors.black54,
);

ColorScheme colorScheme = ColorScheme(
  primary: const Color(0xFFE84444),
  primaryVariant: const Color(0xFFAF001C),
  secondary: const Color(0xFFFFCA28),
  secondaryVariant: const Color(0xFFC79A00),
  surface: Colors.white,
  background: Colors.grey[200],
  error: Colors.red,
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);

ThemeData themeData = ThemeData(
  colorScheme: colorScheme,
  primaryColor: colorScheme.primary,
  primarySwatch: Colors.red,
  backgroundColor: colorScheme.background,
  scaffoldBackgroundColor: colorScheme.background,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    textTheme: textTheme.apply(bodyColor: Colors.white),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: colorScheme.primary,
  ),
  buttonColor: colorScheme.primary,
  buttonTheme: ButtonThemeData(
    height: 50.0,
    padding: EdgeInsets.symmetric(horizontal: 42.0, vertical: 8.0),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
  textTheme: textTheme,
  primaryTextTheme: textTheme,
  accentTextTheme: textTheme,
);
