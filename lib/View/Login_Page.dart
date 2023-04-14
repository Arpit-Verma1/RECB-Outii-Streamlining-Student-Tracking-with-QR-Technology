import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Component/constant.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:rive/rive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../main.dart';

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
        color: Colors.black,
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            margin: EdgeInsets.only(top: 10),
            height:size.height * 0.92,
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
                        enabledBorder: Textfieldborder,
                        focusedBorder: Textfieldborder,
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Color.fromARGB(255, 121, 91, 245),),
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: passwordcontroller,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        enabledBorder: Textfieldborder,
                        focusedBorder: Textfieldborder,
                        prefixIcon: Icon(Icons.lock,
                            color: Color.fromARGB(255, 121, 91, 245),),
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
                              color: Color.fromARGB(255, 121, 91, 245),),
                        ),
                      ),
                      obscureText: pass,
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
                        onPressed: () => Signin(context),
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
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onclickedsignup,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          text: 'Not have an account? ',
                          children: [
                            TextSpan(
                              text: 'Sign up',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 121, 91, 245),
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ]),
                    ),
                  ],
                ),
              )
            ])),
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
                      color: Color.fromARGB(255, 121, 91, 245),
                      fontSize: 18,
                    ),
                  )
                : null),
      ),
    );
  }
  Future Signin(BuildContext context) async {
    bool directlogin=false;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: Progressindicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim());
    } on FirebaseAuthException catch (e) {
      directlogin=true;
      print(e);
      showsnackbar("Error Occured",e.toString(),Colors.red,context);
    }
    Future.delayed(Duration(seconds: directlogin?3:0), () {
      navigatorKey.currentState!.popUntil((route)  => route.isFirst);

    });

  }
}
