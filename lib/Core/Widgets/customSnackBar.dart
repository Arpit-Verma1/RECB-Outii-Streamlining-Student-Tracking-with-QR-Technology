import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:outii/Utils/constant.dart';

void errorSnackbar(String tittle_message, String error, BuildContext context) {
  Flushbar(
    title: tittle_message,
    message: error,
    backgroundColor: errorRed,
    icon: Icon(
      Icons.clear_outlined,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
  ).show(context);
}

void successSnackbar(
    String tittle_message, String snack_message, BuildContext context) {
  Flushbar(
    title: tittle_message,
    message: snack_message,
    backgroundColor: successGreen,
    icon: Icon(
      Icons.check_circle,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.TOP,
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
  ).show(context);
}
