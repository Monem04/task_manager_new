import 'package:flutter/material.dart';

showSnackBarMessage(
  BuildContext context,
  String message, {
  required MaterialColor color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
