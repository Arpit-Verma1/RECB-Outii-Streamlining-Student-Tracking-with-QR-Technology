import 'package:flutter/material.dart';
import '../../../Students/View/Screens/User_Data.dart';

class StudentListTile extends StatelessWidget {
  final String text1;
  final String text2;

  const StudentListTile({super.key, required this.text1, required this.text2});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      leading: Text(
        text1,
        style: textStyle.copyWith(color: Colors.black),
      ),
      title: Text(
        text2,
        style: textStyle.copyWith(color: Colors.black),
      ),
      dense: true,
    );
  }
}
