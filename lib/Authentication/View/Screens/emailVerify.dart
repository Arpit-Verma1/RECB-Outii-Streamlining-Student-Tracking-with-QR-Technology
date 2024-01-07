import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Authentication/View/Widgets/authButton.dart';
import 'package:outii/Authentication/View/Widgets/authHeader.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Utils/constant.dart';
import '../../../View/Splash_Screen.dart';
import '../../ViewModel/authViewModel.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  bool isverify = false;
  bool resendemail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isverify = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isverify) {
      sendverification(context);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isverify
        ? splash()
        : SafeArea(
            child: Container(
                padding:
                    EdgeInsets.only(top: 18, bottom: 12, left: 12, right: 12),
                width: size.width,
                color: Colors.black,
                child: Column(children: [
                  Container(
                      height: size.height * 0.92,
                      width: size.width * 0.9,
                      decoration: auth_boxDecoration,
                      child: Column(
                        children: [
                          Header(),
                          Text(
                            "An email verification link \nhas been sent to your email.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cookie(
                                fontSize: 30,
                                color: Colors.white,
                                wordSpacing: 2),
                          ),
                          authButton(
                            function: () => sendverification(context),
                            buttonName: "Resend Verification Email",
                            fontSize: 15,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          authButton(
                            function: () => FirebaseAuth.instance.signOut(),
                            buttonName: "Cancel Verification",
                            fontSize: 15,
                          ),
                        ],
                      ))
                ])),
          );
  }
}
