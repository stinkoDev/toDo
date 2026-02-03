import 'package:flutter/material.dart';

const Color myTeal = Color(0xFF0d7669);

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: myTeal,
      brightness: Brightness.light,
    ),
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: myTeal,
      brightness: Brightness.dark,
    ),
  );
}
