import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key? key, required this.buttoncolor, required this.text})
      : super(key: key);

  Color buttoncolor = Colors.blueAccent;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: buttoncolor),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: Colors.white,
          )),
    );
  }
}
