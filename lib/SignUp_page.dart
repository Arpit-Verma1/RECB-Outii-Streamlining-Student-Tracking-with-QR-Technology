import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/constant.dart';
import 'package:rive/rive.dart';
import 'Utils.dart';
import 'main.dart';

class SignupWidget extends StatefulWidget {
  final Function() onclickedsignin;

  const SignupWidget({Key? key, required this.onclickedsignin})
      : super(key: key);

  @override
  State<SignupWidget> createState() => _SignupWidgetState();
}

class _SignupWidgetState extends State<SignupWidget> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool pass = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 18, bottom: 12, left: 12, right: 12),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                  height: MediaQuery.of(context).size.height * 0.92,
                  width: MediaQuery.of(context).size.width * 0.9,
                  clipBehavior: Clip.none,
                  decoration: boxDecoration,
                  child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              Container(
                                width: size.width * 0.7,
                                height: size.height * 0.3,
                                child: RiveAnimation.asset(
                                  'assets/recb_outii.riv',
                                ),
                              ),
                              TextFormField(
                                validator: (email) {
                                  if (email!.contains("recb.ac.in")) {
                                    return null;
                                  } else {
                                    return "Enter Your College Official id";
                                  }
                                },
                                controller: emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey,
                                  enabledBorder: textfieldborder,
                                  focusedBorder: textfieldborder,
                                  prefixIcon: Icon(Icons.email_outlined,
                                      color: Colors.deepPurpleAccent),
                                  hintText: 'Email',
                                  border: InputBorder.none,
                                ),
                              ),
                              TextFormField(
                                controller: passwordcontroller,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey,
                                  enabledBorder: textfieldborder,
                                  focusedBorder: textfieldborder,
                                  prefixIcon: Icon(Icons.lock,
                                      color: Colors.deepPurpleAccent),
                                  hintText: "Password",
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        pass = !pass;
                                      });
                                    },
                                    icon: Icon(
                                        pass
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility,
                                        color: Colors.deepPurpleAccent),
                                  ),
                                ),
                                obscureText: true,
                              ),
                              SizedBox(
                                width: size.width * 0.6,
                                height: size.height * 0.07,
                                child: ElevatedButton(
                                  style: buttonstyle.copyWith(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ))),
                                  onPressed: () => SignUp(),
                                  child: Text("SignUp",
                                      style: TextStyle(
                                        fontSize: 28,
                                      )),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = widget.onclickedsignin,
                                    style: GoogleFonts.roboto(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    text: 'Have an account? ',
                                    children: [
                                      TextSpan(
                                        text: 'Sign In',
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: Colors.purpleAccent,
                                        ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        )
                      ])),
            ],
          ),
        ),
      ),
    );
  }

  Future SignUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
