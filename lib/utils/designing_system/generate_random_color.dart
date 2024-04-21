import 'dart:math';
import 'dart:ui';

Color generateRandomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(255),
    random.nextInt(255),
    random.nextInt(255),
  );
}
