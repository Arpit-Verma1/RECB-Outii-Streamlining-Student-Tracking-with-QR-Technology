import 'package:flutter/material.dart';
import 'package:outii/Utils/constant.dart';

class authButton extends StatelessWidget {
  final VoidCallback function;
  final String buttonName;
  final double fontSize;

  const authButton(
      {super.key,
      required this.function,
      required this.buttonName,
      this.fontSize=25});

  @override
  Widget build(BuildContext context) {
    print(buttonName);
    print(fontSize);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        height: size.height * 0.06,
        width: size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: purple,
        ),
        child: Center(
          child: Text("$buttonName",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSize,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
