import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Component/constant.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:rive/rive.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  final user = FirebaseAuth.instance.currentUser;
  late DatabaseReference _dbref;
  String databasejson = "";
  bool show1 = false;
  _readdb1() {
    String t = "";
    _dbref.child('User').once().then((DatabaseEvent databaseEvent) {
      setState(() {
        databasejson = databaseEvent.snapshot.value.toString();
      });
    });
  }

  @override
  void initState() {
    _dbref = FirebaseDatabase.instance.ref();
    _readdb1();
    _readdb1();
    if (databasejson.contains("${user!.email!}"))
      setState(() {
        show1 = !show1;
      });
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, RouteName.sample,
          arguments: {"show": show1});
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
              decoration: boxDecoration,
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
                  Text(
                    "Rajkiya Engineering\nCollege ,Bijnor Outii",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lobster(
                        wordSpacing: 3,
                        fontSize: 25,
                        color: Colors.white,
                        letterSpacing: 2),
                  ),
                  Progressindicator()
                ],
              ))),
    );
  }
}
