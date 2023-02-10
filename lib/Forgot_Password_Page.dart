import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login_Page.dart';

import 'Utils.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Color shadowcolor1 = Colors.blue;
  final formKey = GlobalKey<FormState>();
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
        body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Container(
                  color: Colors.black,
                  height: size.height,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30, right: 20),
                        child: Text(
                          'To reset your password ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              shadows: [
                                Shadow(
                                  color: shadowcolor1,
                                  blurRadius: 3,
                                ),
                                Shadow(
                                  color: shadowcolor1,
                                  blurRadius: 6,
                                ),
                                Shadow(
                                  color: shadowcolor1,
                                  blurRadius: 9,
                                ),
                              ],
                              fontFamily: 'Pacifico',
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 0,
                        ),
                        child: Text(
                          'enter your email id',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              shadows: [
                                Shadow(
                                  color: shadowcolor1,
                                  blurRadius: 3,
                                ),
                                Shadow(
                                  color: shadowcolor1,
                                  blurRadius: 6,
                                ),
                                Shadow(
                                  color: shadowcolor1,
                                  blurRadius: 9,
                                ),
                              ],
                              fontFamily: 'Pacifico',
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: size.width * 0.8,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white38,
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: 3.0, //extend the shadow
                              offset: Offset(
                                0.0, // Move to right 10  horizontally
                                2, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email_outlined,
                                color: Colors.deepPurpleAccent),
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Resetpassword();
                        },
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: size.width * 0.8,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purpleAccent.shade200,
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 3.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  3, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          child: Text("Reset Password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 2,
                                fontSize: 28,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            )));
  }

  Future Resetpassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
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
