import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outii/Admin/View/Widget/QRScan.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Widget/QR_Result.dart';

class qrScan extends StatelessWidget {
  qrScan({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser;

  var status = Permission.sms.request().isGranted;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            color: Color.fromARGB(255, 255, 221, 210),
            padding: EdgeInsets.all(10),
            child: QRCameraScan(),
          ),
        ),
        qrScanResult(),
      ],
    );
  }
}
