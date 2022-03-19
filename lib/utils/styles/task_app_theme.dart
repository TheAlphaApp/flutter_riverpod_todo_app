import 'package:flutter/material.dart';

class TaskAppTheme {
  // 1
  static TextTheme lightTextTheme = const TextTheme(
    button: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyText1: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyText2: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.black),
    headline1: TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.black),
    headline2: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.black),
  );

  // 2
  static TextTheme darkTextTheme = const TextTheme(
    button: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText1: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.white),
    bodyText2: TextStyle(
        fontSize: 16.0, fontWeight: FontWeight.w400, color: Colors.white),
    headline1: TextStyle(
        fontSize: 40.0, fontWeight: FontWeight.w500, color: Colors.white),
    headline2: TextStyle(
        fontSize: 32.0, fontWeight: FontWeight.w400, color: Colors.white),
  );

  // 3
  static light() {
    return ThemeData(
      textTheme: lightTextTheme,
      fontFamily: 'Rubik',
      textSelectionTheme:
          const TextSelectionThemeData(selectionColor: Colors.green),
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.white,
        secondary: Colors.black87,
        brightness: Brightness.light,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.black87),
        overlayColor: MaterialStateProperty.all(
          Colors.black54,
        ),
      )),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 64,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.black45),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
            color: Colors.black87,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // 4
  static dark() {
    return ThemeData(
      textTheme: darkTextTheme,
      fontFamily: 'Rubik',
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.grey[900],
        secondary: Colors.white,
        brightness: Brightness.dark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 64,
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(
          Colors.white54,
        ),
      )),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: Colors.white54),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 2.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            width: 1.0,
            color: Colors.white54,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
