import 'package:flutter/material.dart';

import 'login.dart';
import 'signUp.dart';

class AuthTogglePage extends StatefulWidget {
  const AuthTogglePage({Key? key, required this.islogin}) : super(key: key);
  final bool islogin;

  @override
  State<AuthTogglePage> createState() => _AuthTogglePageState();
}

class _AuthTogglePageState extends State<AuthTogglePage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? Login(onclickedsignup: toggle)
      : SignUpPage(
          onclickedsignin: toggle,
        );

  void toggle() => setState(() => isLogin = !isLogin);
}
