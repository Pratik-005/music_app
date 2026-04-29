import 'package:flutter/material.dart';
import 'package:music_app/core/theme/app_pallate.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 2),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallate.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(25),
      focusedBorder: _border(AppPallate.borderColor),
      enabledBorder: _border(AppPallate.gradient2),
    ),
  );
}
