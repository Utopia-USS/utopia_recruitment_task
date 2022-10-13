import 'package:flutter/material.dart';

class CustomTheme {
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color greyishBlue = Color.fromRGBO(241, 245, 248, 1);
  static const Color semiGray = Color.fromRGBO(200, 199, 204, 1);
  static const Color grey = Colors.grey;
  static const Color darkGray = Color.fromRGBO(114, 114, 119, 1);
  static const Color darkestGrey = Color.fromRGBO(34, 34, 34, 1);
  static const Color black = Color.fromRGBO(30, 32, 38, 1);
  static const Color red = Color.fromARGB(255, 188, 80, 67);
  static const Color lightBlue = Color.fromRGBO(119, 180, 190, 1);
  static const Color semiBlue = Color.fromRGBO(140, 167, 201, 1);
  static const Color darkBlue = Color.fromRGBO(62, 84, 124, 1);

  static const mainRadius = BorderRadius.all(Radius.circular(8.0));
  static const pagePadding = EdgeInsets.all(20.0);
  static const contentPadding = EdgeInsets.all(12.0);

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: greyishBlue,
    appBarTheme: AppBarTheme(
      backgroundColor: darkBlue,
      foregroundColor: white,
      elevation: 0.0,
      centerTitle: true,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: pagePadding,
      filled: true,
      fillColor: white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: semiGray),
        borderRadius: mainRadius,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: semiGray),
        borderRadius: mainRadius,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: darkBlue),
        borderRadius: mainRadius,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: semiGray),
        borderRadius: mainRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: red),
        borderRadius: mainRadius,
      ),
      errorStyle: TextStyle(
        color: red,
      ),
      errorMaxLines: 2,
      labelStyle: TextStyle(color: darkGray),
      hintStyle: TextStyle(color: darkGray),
    ),
    iconTheme: const IconThemeData(
      color: darkBlue,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: darkBlue,
      iconSize: 48.0,
    ),
  );

  static BoxShadow shadow = BoxShadow(
    color: Colors.black.withAlpha(50),
    spreadRadius: .5,
    blurRadius: 1,
    offset: Offset(0, 1),
  );

  static LinearGradient pageGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      darkBlue,
      semiBlue,
    ],
  );
}