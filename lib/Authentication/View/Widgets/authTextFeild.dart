import 'package:flutter/material.dart';

import '../../../Utils/Constant.dart';

class authTextFeild extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;

  const authTextFeild(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.prefixIcon,
      required this.isPassword});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey,
        enabledBorder: Textfieldborder,
        focusedBorder: Textfieldborder,
        prefixIcon: Icon(
          prefixIcon,
          color: Color.fromARGB(255, 121, 91, 245),
        ),
        hintText: hintText,
      ),
      obscureText: isPassword,
    );
  }
}
