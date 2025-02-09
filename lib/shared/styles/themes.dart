import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20.0)),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18.0, color: Colors.black
    ),
    labelSmall: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.black, height: 1.3),
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: defaultColor),
  inputDecorationTheme: const InputDecorationTheme(
    prefixIconColor: Colors.black,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF333739),
  primarySwatch: defaultColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF333739),
        statusBarBrightness: Brightness.light),
    backgroundColor: Color(0xFF333739),
    elevation: 0.0,
    titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Color(0xFF333739),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
        fontWeight: FontWeight.w600, fontSize: 14.0, color: Colors.white, height: 1.3),
  ),
  progressIndicatorTheme:
      const ProgressIndicatorThemeData(color: defaultColor),
  inputDecorationTheme: const InputDecorationTheme(
    prefixIconColor: Colors.white,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
  ),
);
