import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Component/constant.dart';
import 'package:outii/Database/Server_and%20Functions.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);

class qrscan extends StatefulWidget {
  const qrscan({Key? key}) : super(key: key);

  @override
  State<qrscan> createState() => _qrscanState();
}

class _qrscanState extends State<qrscan> {
  final user = FirebaseAuth.instance.currentUser;
  String Student_Branch = "";
  int Student_current_Year = 0;
  String Student_Name = "";
  String Student_Roll_No = "";
  String Student_parents_mail_id = "";
  String Student_parents_phone_no = "";
  String Student_Going_Place = "";
  bool send_mail_parents = false;
  String mail_message = "";
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
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
            child: QR_Scan(context),
          ),
        ),
        QR_Scan_Result(),
      ],
    );
  }

  Widget QR_Scan(BuildContext context) => QRView(
        key: qrkey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
            cutOutSize: MediaQuery.of(context).size.width * 0.6,
            borderRadius: 10,
            borderLength: 20,
            borderWidth: 10),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() {
      controller.resumeCamera();
      this.controller = controller;
      controller.scannedDataStream.listen((Barcode) => setState(() {
            this.barcode = Barcode;
            Student_Name = '${barcode!.code}'
                .substring(0, '${barcode!.code}'.indexOf("."))
                .toUpperCase();
            Student_Branch = '${barcode!.code}'
                .substring('${barcode!.code}'.indexOf(".") + 1,
                    '${barcode!.code}'.indexOf(".") + 3)
                .toUpperCase();
            Student_Roll_No = '${barcode!.code}'.substring(
                '${barcode!.code}'.indexOf(".") + 7,
                '${barcode!.code}'.indexOf(".") + 9);
            Student_current_Year = Year_and_batch(int.parse(
                '${barcode!.code!.substring('${barcode!.code}'.indexOf(".") + 4, '${barcode!.code}'.indexOf(".") + 6)} '));
            ;
            Student_Going_Place = '${barcode!.code}'.substring(
              '${barcode!.code}'.indexOf("@") + 21,
            );
            Student_parents_phone_no = '${barcode!.code}'.substring(
                '${barcode!.code}'.indexOf("@") + 11,
                '${barcode!.code}'.indexOf("@") + 21);
          }));
    });
  }

  Widget QR_Scan_Result() => Expanded(
    flex: 1,
    child: Container(

        color: Color.fromARGB(255, 255, 221, 210),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                "Name :- " + Student_Name,
                style: textStyle,
              ),
              Text("Branch :- " + Student_Branch, style: textStyle)
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Phone No :- ' + Student_parents_phone_no,
                  style: textStyle,
                ),
                Text(
                  'Roll No :- ' + Student_Roll_No,
                  style: textStyle,
                ),
                Text(
                  "Year :-" + Student_current_Year.toString(),
                  style: textStyle,
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    "Purpose :- " + Student_Going_Place,
                    style: textStyle,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: buttonstyle,
                    onPressed: () async {
                      if (barcode?.code == null)
                        showsnackbar(
                            "Error Occured", "Envalid QR", Colors.red, context);
                      else {
                        await Check_Out(
                            "${Student_Name.toLowerCase()}${barcode?.code?.substring('${barcode?.code}'.indexOf(".") + 4, '${barcode?.code}'.indexOf(".") + 9)}$Student_Branch",
                            send_mail_parents,
                            Student_current_Year,
                            barcode,
                            Student_Name,
                            Student_Going_Place,
                            Student_parents_phone_no,
                            context);
                        showsnackbar("Check Out Successfully",
                            "Mail Sent To Warden", Colors.green, context);
                      }
                    },
                    child: Text("Check Out")),
                ElevatedButton(
                    style:buttonstyle,
                    onPressed: () async {
                      if (barcode?.code == null)
                        showsnackbar(
                            "Error Occured", "Envalid QR", Colors.red, context);
                      else {
                        await Check_In(
                            "${Student_Name.toLowerCase()}${barcode?.code?.substring('${barcode?.code}'.indexOf(".") + 4, '${barcode?.code}'.indexOf(".") + 9)}$Student_Branch");
                        showsnackbar("Check Out Successfully",
                            "Mail Sent To Warden", Colors.green, context);
                      }
                    },
                    child: Text("Check In")),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 121, 91, 245),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        "Parents",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Switch(
                          activeTrackColor: Colors.black,
                          activeColor: Colors.white,
                          value: send_mail_parents,
                          onChanged: (bool newValue) {
                            setState(() {
                              send_mail_parents = newValue;
                            });
                          })
                    ],
                  ),
                )
              ],
            ),
          ],
        )),
  );
}
