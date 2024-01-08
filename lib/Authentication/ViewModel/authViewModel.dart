import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Component/Widgets/widgets.dart';
import '../../main.dart';

class AuthenticationProvider with ChangeNotifier {
  bool isVerify = false;
  Timer? timer;
  bool resendMail = false;

  bool get isverify => isVerify;

  bool get resendmail => resendMail;

  Future Signin(BuildContext context, String Email, String Password) async {
    bool directlogin = false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: Progressindicator()));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);
    } on FirebaseAuthException catch (e) {
      directlogin = true;
      print(e);
      showsnackbar("Error Occured", e.toString(), Colors.red, context);
    }
    Future.delayed(Duration(seconds: directlogin ? 3 : 0), () {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    });
  }

  Future Resetpassword(BuildContext context, String Email) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: Progressindicator()));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: Email);
      showsnackbar("Done", 'Password reset email sent', Colors.green, context);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      showsnackbar("Error Occured", e.toString(), Colors.red, context);
      Navigator.of(context).pop();
    }
  }

  Future SignUp(BuildContext context, String Email, String Password) async {
    if (!Email.contains("@recb.ac.in")) {
      showsnackbar("Error Occured", "Please use your college email id",
          Colors.red, context);
      return;
    }
    bool directlogin = false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: Progressindicator()));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: Password);
    } on FirebaseAuthException catch (e) {
      directlogin = true;
      print(e);
      showsnackbar("Error Occured", e.toString(), Colors.red, context);
    }
    Future.delayed(Duration(seconds: directlogin ? 3 : 0), () {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    });
  }

  Future sendverification(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      resendMail = false;
      await Future.delayed(Duration(seconds: 4));
      resendMail = true;
    } catch (e) {
      showsnackbar("Error Occured", e.toString(), Colors.red, context);
    }
    notifyListeners();
  }

  Future checkemailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    notifyListeners();
  }

  void Timerfuc() {
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      checkemailverified();
      if (isverify == true) timer?.cancel();
    });
  }
}
