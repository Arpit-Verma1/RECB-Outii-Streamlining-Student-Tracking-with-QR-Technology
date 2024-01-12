import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../Core/Widgets/customSnackBar.dart';
import '../../Core/Widgets/progressIndicaor.dart';
import '../../Routes/routes_name.dart';
import '../../Utils/Shared_Preferences.dart';
import '../../main.dart';

class AuthenticationProvider with ChangeNotifier {
  bool isVerify = false;
  Timer? timer;
  bool resendMail = false;
  bool isAdminLogin = false;
  bool get isverify => isVerify;
  bool get resendmail => resendMail;
  bool get isadminlogin => isAdminLogin;

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
      errorSnackbar("Error Occured", e.toString(), context);
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
      successSnackbar("Done", 'Password reset email sent', context);
      Future.delayed(Duration(seconds: 3), () {
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      errorSnackbar("Error Occured", e.toString(), context);
      Navigator.of(context).pop();
    }
  }

  Future SignUp(BuildContext context, String Email, String Password) async {
    if (!Email.contains("@recb.ac.in")) {
      errorSnackbar(
          "Error Occured", "Please use your college email id", context);
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
      errorSnackbar("Error Occured", e.toString(), context);
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
      errorSnackbar("Error Occured", e.toString(), context);
    }
    notifyListeners();
  }

  Future checkemailverified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    isVerify = FirebaseAuth.instance.currentUser!.emailVerified;
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    await UserSimplePreferences.clear();
    FirebaseAuth.instance.signOut().then((value) =>
        Navigator.pushReplacementNamed(context, RouteName.My_HomePage));
    FirebaseAuth.instance.signOut();
  }

  void Timerfuc() {
    timer = Timer.periodic(Duration(seconds: 3), (_) {
      checkemailverified();
      if (isverify == true) timer?.cancel();
    });
  }

  void isAdmin() {
    final user = FirebaseAuth.instance.currentUser;
    DatabaseReference _dbref = FirebaseDatabase.instance.ref();
    _dbref.child('Admin').once().then((DatabaseEvent databaseEvent) {
      if (databaseEvent.snapshot.value.toString().contains("${user!.email!}")) {
        isAdminLogin = true;
      }
      notifyListeners();
    });
  }
}
