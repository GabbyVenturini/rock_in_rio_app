import 'package:flutter/material.dart';

/// 🎨 Cor principal Rock in Rio
const rockBlueLight = Color(0xFFE51E1E);

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: rockBlueLight,
    primary: rockBlueLight,
  ),
  chipTheme: ChipThemeData(
    backgroundColor: rockBlueLight,
    labelStyle: const TextStyle(color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
  cardTheme: CardThemeData(
    color: Colors.black54,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ),
);
