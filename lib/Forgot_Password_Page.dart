import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Component/constant.dart';
import 'Utils.dart';

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
        body: Center(
          child: Container(
              height: size.height * 0.3,
              width: size.width * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('To reset your password\n enter your Email Id ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cookie(
                          wordSpacing: 3,
                          fontSize: 30,
                          color: Colors.white,
                          letterSpacing: 2)),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey,
                      enabledBorder: textfieldborder,
                      focusedBorder: textfieldborder,
                      prefixIcon: Icon(Icons.email_outlined,
                          color: Colors.deepPurpleAccent),
                      hintText: 'Email ID',
                      border: InputBorder.none,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.06,
                    child: ElevatedButton(
                      style: buttonstyle,
                      onPressed: () => Resetpassword(),
                      child: Text("Reset Password",
                          style: TextStyle(
                            fontSize: 25,
                          )),
                    ),
                  ),
                ],
              )),
        ));
  }

  Future Resetpassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: Progressindicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password reset email sent');
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
      Navigator.of(context).pop();
    }
  }
}
