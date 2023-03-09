import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/constant.dart';
import 'Splash_Screen.dart';
import 'Utils.dart';

class Verifyemail extends StatefulWidget {
  const Verifyemail({Key? key}) : super(key: key);

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {
  bool isverify = false;
  bool resendemail = false;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    isverify = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isverify) {
      sendverification();
      timer = Timer.periodic(Duration(seconds: 3), (_) => checkemailverified());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkemailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isverify = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isverify) timer?.cancel();
  }

  Future sendverification() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => resendemail = false);
      await Future.delayed(Duration(seconds: 4));
      setState(() => resendemail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isverify
        ? splash()
        : Container(
            width: size.width,
            color: Colors.black,
            child: Column(children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: 18, bottom: 12, left: 12, right: 12)),
              Container(
                  height: size.height * 0.92,
                  width: size.width * 0.9,
                  decoration: boxDecoration,
                  child: Column(
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
                      SizedBox(
                        height: size.height * 0.28,
                      ),
                      Text(
                        "An email verification link \nhas been sent to your email.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cookie(
                            fontSize: 30, color: Colors.white, wordSpacing: 2),
                      ),
                      ElevatedButton(
                        style: buttonstyle,
                        onPressed: () => sendverification(),
                        child: Text(
                          "Resend Verification Email",
                        ),
                      ),
                      ElevatedButton(
                        style: buttonstyle,
                        onPressed: () => FirebaseAuth.instance.signOut(),
                        child: Text(
                          "Cancel Verification",
                        ),
                      ),
                    ],
                  ))
            ]));
  }
}
