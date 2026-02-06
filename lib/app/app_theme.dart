import 'package:flutter/material.dart';

const Color myTeal = Color(0xFF0d7669);
const Color myPurple = Color(0xFFb200ff);

class PriorityColors extends ThemeExtension<PriorityColors> {
  final Color high; // Danger red
  final Color medium; // Warning orange
  final Color normal; // Success teal

  const PriorityColors({
    required this.high,
    required this.medium,
    required this.normal,
  });

  @override
  ThemeExtension<PriorityColors> copyWith({
    Color? high,
    Color? medium,
    Color? normal,
  }) {
    return PriorityColors(
      high: high ?? this.high,
      medium: medium ?? this.medium,
      normal: normal ?? this.normal,
    );
  }

  @override
  ThemeExtension<PriorityColors> lerp(
    ThemeExtension<PriorityColors>? other,
    double t,
  ) {
    if (other is! PriorityColors) return this;
    return PriorityColors(
      high: Color.lerp(high, other.high, t)!,
      medium: Color.lerp(medium, other.medium, t)!,
      normal: Color.lerp(normal, other.normal, t)!,
    );
  }
}

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: myPurple,
      brightness: Brightness.light,
    ),
    extensions: [
      PriorityColors(
        high: Colors.red.shade600,
        medium: Colors.orange.shade600,
        normal: myTeal,
      ),
    ],
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: myPurple,
      brightness: Brightness.dark,
    ),
    extensions: [
      PriorityColors(
        high: Colors.red.shade400,
        medium: Colors.orange.shade400,
        normal: myTeal,
      ),
    ],
  );
}
