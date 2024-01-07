import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Authentication/View/Widgets/authButton.dart';
import 'package:outii/Authentication/View/Widgets/authHeader.dart';
import 'package:outii/Authentication/View/Widgets/authTextFeild.dart';
import 'package:outii/Component/Widgets/widgets.dart';

import 'package:outii/Utils/constant.dart';
import '../../ViewModel/authViewModel.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Header(),
                  Text('Enter Your Email Id\nTo Reset Password ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cookie(
                          wordSpacing: 3,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white,
                          letterSpacing: 2)),
                  authTextFeild(
                      textEditingController: emailController,
                      hintText: "Email",
                      prefixIcon: Icons.email,
                      isPassword: false),
                  authButton(
                    function: () =>
                        Resetpassword(context, emailController.text.trim()),
                    buttonName: "Reset Password",
                  ),
                  SizedBox(
                    height: size.height * 0.15,
                  )
                ],
              )),
        ));
  }
}
