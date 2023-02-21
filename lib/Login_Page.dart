import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:video_player/video_player.dart';
import 'Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'Forgot_Password_Page.dart';
import 'main.dart';

class Login extends StatefulWidget {
  final VoidCallback onclickedsignup;
  const Login({Key? key, required this.onclickedsignup}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'assets/final4.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    // Once the video has been loaded we play the video and set looping to true.
    _controller.setVolume(0.0);
    _controller.play();
    _controller.setLooping(true);
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
    _controller.dispose();
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
    Color shadowcolor1 = Colors.red;
    Color shadowcolor = Colors.purpleAccent.shade700;
    Size size = MediaQuery.of(context).size;
    double defaultRegisterSize = size.height - (size.height * 0.1);
    containerSize = Tween(begin: size.height * 0.1, end: defaultRegisterSize)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
    return Form(
        child: SingleChildScrollView(
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            Padding(
                padding:
                    EdgeInsets.only(top: 18, bottom: 12, left: 12, right: 12)),
            SingleChildScrollView(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.92,
                    width: MediaQuery.of(context).size.width * 0.9,
                    clipBehavior: Clip.none,
                    decoration: BoxDecoration(
                      color: Colors.black,

                      //Border.all

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ),
                        BoxShadow(
                          color: Colors.grey,
                          offset: const Offset(
                            -5.0,
                            -5.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: const Offset(0.0, 0.0),
                          blurRadius: 0.0,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Text(
                              "Rajkiya Engineering",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
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
                                  fontFamily: 'MsMadi',
                                  color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "College Bijnor",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
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
                                  fontFamily: 'MsMadi',
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Center(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Container(
                                    width: size.width * 0.7,
                                    height: size.height * 0.3,
                                    child: FutureBuilder(
                                      future: _initializeVideoPlayerFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return AspectRatio(
                                            aspectRatio:
                                                _controller.value.aspectRatio *
                                                    0.8,
                                            child: VideoPlayer(_controller),
                                          );
                                        } else {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  ))),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          Container(
                            width: size.width * 0.8,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
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
                              controller: emailcontroller,
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
                          Container(
                            width: size.width * 0.8,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white38,
                                  blurRadius: 5.0, // soften the shadow
                                  spreadRadius: 3.0, //extend the shadow
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    2.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextFormField(
                              controller: passwordcontroller,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock,
                                    color: Colors.deepPurpleAccent),
                                hintText: "Password",
                                border: InputBorder.none,
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
                          InkWell(
                            onTap: () {
                              Signin();
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 0),
                              child: Text("Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    height: 2,
                                    fontSize: 28,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: shadowcolor,
                                      blurRadius: 3,
                                    ),
                                    Shadow(
                                      color: shadowcolor,
                                      blurRadius: 6,
                                    ),
                                    Shadow(
                                      color: shadowcolor,
                                      blurRadius: 9,
                                    ),
                                  ],
                                  fontSize: 24),
                            ),
                            onTap: () => Navigator.pushNamed(
                                context, RouteName.forgot_passwd),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onclickedsignup,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(
                                      color: Colors.blueAccent.shade700,
                                      blurRadius: 3,
                                    ),
                                    Shadow(
                                      color: Colors.blueAccent.shade700,
                                      blurRadius: 6,
                                    ),
                                    Shadow(
                                      color: Colors.blueAccent.shade700,
                                      blurRadius: 9,
                                    ),
                                  ],
                                ),
                                text: 'No account? ',
                                children: [
                                  TextSpan(
                                    text: 'Sign up',
                                    style: TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                          color: Colors.blueAccent.shade700,
                                          blurRadius: 3,
                                        ),
                                        Shadow(
                                          color: Colors.blueAccent.shade700,
                                          blurRadius: 6,
                                        ),
                                        Shadow(
                                          color: Colors.blueAccent.shade700,
                                          blurRadius: 9,
                                        ),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    )))
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
