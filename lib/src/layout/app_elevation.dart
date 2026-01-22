import 'package:flutter/material.dart';

class AppElevation {
  const AppElevation._();

  static List<BoxShadow> get card => [
    BoxShadow(
      color: Colors.black.withAlpha(13), // ~0.05
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get cardHover => [
    BoxShadow(
      color: Colors.black.withAlpha(25), // ~0.1
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> get filterTab => [
    BoxShadow(
      color: Colors.black.withAlpha(10),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
  ];
}
