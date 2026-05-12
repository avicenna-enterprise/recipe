import 'package:flutter/material.dart';

class AppNavigator {
  // Push a new screen (back button works)
  static void push(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Replace current screen (back button won't go back)
  static void replace(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  // Go to screen and clear all previous screens from stack
  static void pushAndRemoveAll(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  // Go back to previous screen
  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
