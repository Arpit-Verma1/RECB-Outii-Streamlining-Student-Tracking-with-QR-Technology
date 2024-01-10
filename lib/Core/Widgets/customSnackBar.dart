import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showsnackbar(String tittle_message, String snack_message, Color color,
    BuildContext context) {
  Flushbar(
    title: tittle_message,
    message: snack_message,
    backgroundColor: color,
    icon: Icon(
      color == Colors.green ? Icons.check_circle : Icons.clear_outlined,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
  ).show(context);
}
