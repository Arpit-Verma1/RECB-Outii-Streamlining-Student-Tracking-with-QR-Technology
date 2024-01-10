import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Authentication/View/Widgets/authButton.dart';
import 'package:outii/Authentication/View/Widgets/authHeader.dart';
import 'package:outii/Utils/constant.dart';
import 'package:provider/provider.dart';
import 'splashScreen.dart';
import '../../ViewModel/authViewModel.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  @override
  void initState() {
    // TODO: implement initState
    context.read<AuthenticationProvider>().checkemailverified();
    if (context.read<AuthenticationProvider>().isverify == false) {
      context.read<AuthenticationProvider>().sendverification(context);
      context.read<AuthenticationProvider>().Timerfuc();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return context.watch<AuthenticationProvider>().isverify == true
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
                            function: () {
                              if (context
                                      .watch<AuthenticationProvider>()
                                      .resendMail ==
                                  true)
                                context
                                    .read<AuthenticationProvider>()
                                    .sendverification(context);
                            },
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
