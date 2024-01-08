import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:outii/Authentication/View/Widgets/authButton.dart';
import 'package:outii/Authentication/View/Widgets/authHeader.dart';
import 'package:outii/Authentication/View/Widgets/authTextFeild.dart';
import 'package:outii/Authentication/View/Widgets/authToggleButton.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:provider/provider.dart';
import '../../../Utils/Constant.dart';
import '../../ViewModel/authViewModel.dart';

class Login extends StatefulWidget {
  final VoidCallback onclickedsignup;

  const Login({Key? key, required this.onclickedsignup}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  AuthenticationProvider authentication = AuthenticationProvider();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  bool isLogin = true;
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
        child: Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            margin: EdgeInsets.only(top: 10),
            height: size.height * 0.92,
            width: size.width * 0.9,
            clipBehavior: Clip.none,
            decoration: auth_boxDecoration,
            child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
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
                        function: () => authentication.Signin(
                              context,
                              emailcontroller.text.trim(),
                              passwordcontroller.text.trim(),
                            ),
                        buttonName: "Login"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.forgot_passwd);
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    authToggleButton(
                      onclickedsignup: widget.onclickedsignup,
                      firstText: 'Not have an account? ',
                      secondText: 'Sign Up',
                    ),
                  ],
                ),
              )
            ])),
      ),
    );
  }
}
