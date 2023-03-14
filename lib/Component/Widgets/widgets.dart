import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Progressindicator extends StatelessWidget {
  const Progressindicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
        size: 50,
        itemBuilder: (context, index) {
          final colors = [Colors.orange, Colors.cyanAccent];
          final color = colors[index % colors.length];
          return DecoratedBox(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(5, 5),
                    color: Colors.redAccent)
              ]));
        });
  }
}

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

class Confetti extends StatelessWidget {
  Confetti({Key? key, required this.angle, this.confetticontroller})
      : super(key: key);
  final double angle;
  final confetticontroller;
  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
        confettiController: confetticontroller,
        shouldLoop: true,
        emissionFrequency: 0.08,
        gravity: 0.3,
        blastDirection: angle,
        createParticlePath: (size) {
          final path = Path();
          path.addPolygon([
            Offset(20, 5),
            Offset(8, 39.6),
            Offset(38, 15.6),
            Offset(2, 15.6),
            Offset(32, 39.6),
          ], true);
          return path;
        });
  }
}
