import 'package:flutter/material.dart';

class WidgetConstants {
  static showSnackBar(context, msg) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
        ),
      );

  static hideSnackBar(context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
