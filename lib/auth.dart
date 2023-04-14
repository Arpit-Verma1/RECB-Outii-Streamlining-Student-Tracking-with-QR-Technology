import 'package:flutter/material.dart';
import 'View/Login_Page.dart';
import 'View/SignUp_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.islogin}) : super(key: key);
  final bool islogin;
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onclickedsignup: toggle)
      : SignupWidget(
          onclickedsignin: toggle,
        );
  void toggle() => setState(() => isLogin = !isLogin);
}
