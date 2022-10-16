import 'package:flutter/material.dart';
import 'Utils.dart';
import 'login.dart';
import 'Signup.dart';
import 'main.dart';
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key, required this.islogin}) : super(key: key);
  final bool islogin;
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin=true;
  @override
  Widget build(BuildContext context)=>isLogin?Login(onclickedsignup: toggle):
  SignupWidget( onclickedsignin: toggle,);
  void toggle()=>setState(()=>isLogin=!isLogin);
}


