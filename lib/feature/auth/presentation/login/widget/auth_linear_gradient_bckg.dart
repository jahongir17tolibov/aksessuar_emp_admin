import 'package:flutter/material.dart';

const List<double> _stops = [0.2, 0.4, 0.6, 0.8];

LinearGradient linearGradientBckg(BuildContext context) {
  List<Color> colors = [
    Theme.of(context).colorScheme.primary,
    Theme.of(context).colorScheme.primaryContainer,
    Theme.of(context).colorScheme.tertiaryContainer,
    Theme.of(context).colorScheme.tertiary,
  ];
  return LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: colors,
    stops: _stops,
  );
}
