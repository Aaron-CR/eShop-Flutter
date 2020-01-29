import 'package:flutter/material.dart';

// TODO: Reorganize and refacotr Theme

ThemeData themeData() {
  return ThemeData(
    backgroundColor: Colors.grey[200],
    scaffoldBackgroundColor: Colors.grey[200],
    primarySwatch: Colors.red,
    primaryColor: Colors.red[400],
    appBarTheme: AppBarTheme(elevation: 0.0),
    textTheme: TextTheme(
      display4: TextStyle(),
      display3: TextStyle(),
      display2: TextStyle(),
      display1: TextStyle(),
      headline: TextStyle(),
      title: TextStyle(),
      subtitle: TextStyle(),
      subhead: TextStyle(),
      body2: TextStyle(),
      body1: TextStyle(),
      caption: TextStyle(),
      button: TextStyle(),
    ).apply(
      bodyColor: Colors.black54,
      displayColor: Colors.black54,
    ),
  );
}
