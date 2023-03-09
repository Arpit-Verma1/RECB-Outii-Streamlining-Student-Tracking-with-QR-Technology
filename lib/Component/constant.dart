import 'package:flutter/material.dart';

ButtonStyle buttonstyle = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(Colors.purple),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));

BoxDecoration boxDecoration = BoxDecoration(
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
InputBorder textfieldborder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.transparent),
  borderRadius: BorderRadius.all(Radius.circular(
    10,
  )),
);
