import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Authentication/View/Widgets/authButton.dart';
import 'package:outii/Authentication/View/Widgets/authHeader.dart';
import 'package:outii/Component/Widgets/widgets.dart';

import 'package:rive/rive.dart';

import '../../../Utils/constant.dart ';
import '../../../main.dart';
import '../../ViewModel/authViewModel.dart';
import '../Widgets/authTextFeild.dart';
import '../Widgets/authToggleButton.dart';

class SignUp extends StatefulWidget {
  final Function() onclickedsignin;

  const SignUp({Key? key, required this.onclickedsignin})
      : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool pass = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 18, bottom: 12, left: 12, right: 12),
        width: size.width,
        height: size.height,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                height: size.height * 0.92,
                width: size.width * 0.9,
                clipBehavior: Clip.none,
                decoration: auth_boxDecoration,
                child:
                    CustomScrollView(scrollDirection: Axis.vertical, slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Header(),
                        authTextFeild(
                            textEditingController: emailcontroller,
                            hintText: "Email",
                            prefixIcon: Icons.email,
                            isPassword: false),
                        authTextFeild(
                            textEditingController: passwordcontroller,
                            hintText: "Password",
                            prefixIcon: Icons.lock,
                            isPassword: true),
                        authButton(
                            function: () => SignUp(
                                context,
                                emailcontroller.text.trim(),
                                passwordcontroller.text.trim()),
                            buttonName: "Sign Up"),
                        authToggleButton(
                          onclickedsignup: widget.onclickedsignin,
                          firstText: 'Have an account? ',
                          secondText: 'Sign In',
                        ),
                      ],
                    ),
                  )
                ])),
          ],
        ),
      ),
    );
  }
}
