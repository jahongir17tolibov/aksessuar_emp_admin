import 'package:flutter/material.dart';

import 'colors.dart';

ThemeData appLightTheme = ThemeData(
  colorScheme: lightColorScheme,
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: lightColorScheme.background,
);

ThemeData appDarkTheme = ThemeData(
  colorScheme: darkColorScheme,
  useMaterial3: true,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  scaffoldBackgroundColor: darkColorScheme.background,
);
