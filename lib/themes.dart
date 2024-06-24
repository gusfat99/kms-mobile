import 'package:flutter/material.dart';

import 'colors.dart';

double boderRadiusDefault = 14;

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: swatchColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        backgroundColor: elevatedButtonBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(boderRadiusDefault),
          side: BorderSide.none,
        ),
        elevation: 0,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: inputFillColor,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(boderRadiusDefault),
        borderSide: const BorderSide(color: inputDecorationEnableBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(boderRadiusDefault),
        borderSide: const BorderSide(color: inputDecorationEnableBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(boderRadiusDefault),
        borderSide: const BorderSide(color: inputDecorationFocusBorderColor),
      ),
    ),
  );
}
