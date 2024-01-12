import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color purple = Color.fromARGB(255, 121, 91, 245);
Color lightPeach = Color.fromARGB(255, 255, 221, 210);
Color silverGrey = Color.fromARGB(255, 233, 230, 230);
Color errorRed = Color.fromARGB(255, 255, 0, 0);
Color successGreen = Colors.green;
final Uri faceboook_url = Uri.parse('https://www.facebook.com/recbup/');
final Uri twitter_url = Uri.parse('https://twitter.com/recb_up');
final Uri linkedin_url = Uri.parse(
    'https://www.linkedin.com/company/rajkiya-engineering-college-bijnor/');
final Uri instagram_url = Uri.parse('https://www.instagram.com/recbup/');
TextStyle regLobster =
    TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Lobster');
TextStyle bigLobster = TextStyle(
    wordSpacing: 2,
    fontSize: 30,
    color: Colors.white,
    letterSpacing: 2,
    fontFamily: 'Lobster');
TextStyle boldText = TextStyle(fontWeight: FontWeight.bold);

ButtonStyle buttonstyle = ButtonStyle(
  backgroundColor: MaterialStatePropertyAll(
    purple,
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
