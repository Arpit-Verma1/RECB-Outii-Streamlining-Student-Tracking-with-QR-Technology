import 'package:flutter/material.dart';

ButtonStyle buttonstyle = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(
    Color.fromARGB(255, 121, 91, 245),
  ),
);

BoxDecoration auth_boxDecoration = BoxDecoration(
  color: Colors.black,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    bottomLeft: Radius.circular(20.0),
    bottomRight: Radius.circular(20.0),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.grey,
      offset: const Offset(
        5.0,
        5.0,
      ),
      blurRadius: 10.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: Colors.grey,
      offset: const Offset(
        -5.0,
        -5.0,
      ),
      blurRadius: 10.0,
      spreadRadius: 1.0,
    ), //BoxShadow
    BoxShadow(
      color: Colors.white,
      offset: const Offset(0.0, 0.0),
      blurRadius: 0.0,
      spreadRadius: 0.0,
    ), //BoxShadow
  ],
);
OutlineInputBorder Textfieldborder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(color: Colors.black, width: 1),
);
