import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class authToggleButton extends StatelessWidget {
  final VoidCallback onclickedsignup;
  final String firstText;
  final String secondText;

  const authToggleButton(
      {super.key,
      required this.onclickedsignup,
      required this.firstText,
      required this.secondText});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          text: firstText,
          children: [
            TextSpan(
              recognizer: TapGestureRecognizer()..onTap = onclickedsignup,
              text: secondText,
              style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 121, 91, 245),
                  fontWeight: FontWeight.bold),
            )
          ]),
    );
  }
}
