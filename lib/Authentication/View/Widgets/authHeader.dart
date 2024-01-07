import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Text(
          "Rajkiya Engineering \nCollege, Bijnor",
          textAlign: TextAlign.center,
          style: GoogleFonts.lobster(
              wordSpacing: 2,
              fontSize: 30,
              color: Colors.white,
              letterSpacing: 2),
        ),
        Container(
          height: size.height * 0.3,
          child: RiveAnimation.asset(
            'assets/recb_outii.riv',
          ),
        ),
      ],
    );
  }
}
