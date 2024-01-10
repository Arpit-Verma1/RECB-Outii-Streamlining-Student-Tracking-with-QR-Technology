import 'dart:async';
import 'package:flutter/material.dart';
import 'package:outii/Authentication/View/Widgets/authHeader.dart';
import 'package:outii/Utils/constant.dart';
import 'package:outii/routes/routes_name.dart';
import 'package:provider/provider.dart';
import '../../../Core/Widgets/progressIndicaor.dart';
import '../../ViewModel/authViewModel.dart';

class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  late bool User_UI = false;

  void initState() {
    super.initState();
    context.read<AuthenticationProvider>().isAdmin();
    Future.delayed(Duration(seconds: 1), () {
      Timer(Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(
          context,
          RouteName.sample,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: size.height * 0.7,
              width: size.width * 0.9,
              decoration: auth_boxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Header(),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Recb_Outii\nJust',
                      style: bigLobster,
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Scan',
                            style:
                                bigLobster.copyWith(color: Colors.cyanAccent)),
                        TextSpan(text: ' and'),
                        TextSpan(
                            text: ' Go',
                            style:
                                bigLobster.copyWith(color: Colors.cyanAccent)),
                      ],
                    ),
                  ),
                  Progressindicator()
                ],
              ))),
    );
  }
}
