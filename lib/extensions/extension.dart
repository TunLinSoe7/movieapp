import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext {
  void navigateToOtherScreen(Widget screen) {
    Navigator.of(this).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
