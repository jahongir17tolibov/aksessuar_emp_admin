import 'dart:async';

import 'package:flutter/material.dart';

import 'text_view.dart';

Future<void> showSnackBar(String message, BuildContext context) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextView(
        text: message,
        textColor: Theme.of(context).colorScheme.surface,
        maxLines: 3,
      ),
      backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.9),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondaryContainer,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
