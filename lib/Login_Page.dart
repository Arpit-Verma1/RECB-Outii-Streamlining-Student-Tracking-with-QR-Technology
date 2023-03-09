import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/constant.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:rive/rive.dart';
import 'Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';

class Login extends StatefulWidget {
  final VoidCallback onclickedsignup;
  const Login({Key? key, required this.onclickedsignup}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: animationDuration);
    super.initState();
  }

  late AnimationController _animationController;
  final formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool isLogin = true;
  bool pass = true;
  @override
  late Animation<double> containerSize;
  Duration animationDuration = Duration(milliseconds: 270);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultRegisterSize = size.height - (size.height * 0.1);
    containerSize = Tween(begin: size.height * 0.1, end: defaultRegisterSize)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    return Form(
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
                child:
                    CustomScrollView(scrollDirection: Axis.vertical, slivers: [
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
                          height: size.height * 0.3,
                          child: RiveAnimation.asset(
                            'assets/recb_outii.riv',
                          ),
                        ),
                        TextField(
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
                        SizedBox(
                          width: size.width * 0.8,
                          child: TextField(
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
                            obscureText: pass,
                          ),
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
                            onPressed: () => Signin(),
                            child: Text("LogIn",
                                style: TextStyle(
                                  fontSize: 28,
                                )),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteName.forgot_passwd);
                          },
                          child: Text(
                            'Forgot Password',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onclickedsignup,
                              style: GoogleFonts.roboto(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              text: 'Not have an account? ',
                              children: [
                                TextSpan(
                                  text: 'Sign up',
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
                ]))
          ],
        ),
      ),
    ));
  }

  Widget buildRegisterContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: containerSize.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100),
            topRight: Radius.circular(100),
          ),
          color: Colors.grey,
        ),
        alignment: AlignmentDirectional.center,
        child: GestureDetector(
            onTap: () {
              _animationController.forward();
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: isLogin
                ? Text(
                    'Dont have an account?Sign up',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontSize: 18,
                    ),
                  )
                : null),
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

  Future Signin() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
