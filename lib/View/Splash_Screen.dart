import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:rive/rive.dart';

import '../Utils/Constant.dart';

TextStyle textStyle = GoogleFonts.lobster(
    wordSpacing: 3, fontSize: 30, color: Colors.white, letterSpacing: 2);

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  final user = FirebaseAuth.instance.currentUser;
   DatabaseReference _dbref=FirebaseDatabase.instance.ref();
  late bool User_UI=false;
  void initState() {
    super.initState();
    _readdb();
    Future.delayed(Duration(seconds: 1), () {
      _readdb();
      Timer(Duration(seconds:1 ), () {
        Navigator.pushReplacementNamed(
            context,
            RouteName.sample,
            arguments: {"show": User_UI}
        );
      });
    });

  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: auth_boxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    height: size.height * 0.4,
                    child: RiveAnimation.asset(
                      'assets/recb_outii.riv',
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Recb_Outii\nJust',
                      style: textStyle,
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Scan',
                            style:
                                textStyle.copyWith(color: Colors.cyanAccent)),
                        TextSpan(text: ' and'),
                        TextSpan(
                            text: ' Go',
                            style:
                                textStyle.copyWith(color: Colors.cyanAccent)),
                      ],
                    ),
                  ),
                  Progressindicator()
                ],
              ))),
    );
  }
  _readdb() {
    _dbref.child('User').once().then((DatabaseEvent databaseEvent) {
      setState(() {
        if (databaseEvent.snapshot.value.toString().contains("${user!.email!}")) {
          setState(() {
            User_UI = true;
          });
          setState(() {});
        } else {
          setState(() {
            User_UI= false;
          });
          setState(() {});
        }
      });
    });
  }
}
