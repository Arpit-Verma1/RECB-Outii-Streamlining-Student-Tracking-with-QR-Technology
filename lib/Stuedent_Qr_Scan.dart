import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:outii/google%20auth%20api.dart';

import 'main.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';

class qrscan extends StatefulWidget {
  const qrscan({Key? key}) : super(key: key);

  @override
  State<qrscan> createState() => _qrscanState();
}

class _qrscanState extends State<qrscan> {
  final user = FirebaseAuth.instance.currentUser;
  String Year = "";
  int year =
      int.parse(DateFormat("yyyy").format(DateTime.now()).substring(2, 4));
  String Branch = "";
  String Name = "";
  int k = 0;
  String Rollno = "";
  String email = "";
  String phone = "";
  String Where = "";
  bool sendDirect = false;
  int c = 0, d = 0;
  String message1 = "Your child ";
  String? _message;
  List<String> people = [];
  final qrkey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  DatabaseReference _dbref = FirebaseDatabase.instance.ref();

  Barcode? barcode;
  TextEditingController Controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  List<String> people1 = ['kingarpit268@gmail.com'];
  List<String> people2 = ['kingarpitverma@gmail.com'];
  List<String> people3 = ['arpitverma0249@gmail.com'];
  List<String> people4 = ['arpitverma0249@gmail.com'];
  List<String> people5 = ['arpitverma0249@gmail.com'];
  Color shadowcolor1 = Colors.white;
  Color shadowcolor2 = Colors.blueAccent;
  var status = Permission.sms.request().isGranted;

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.ref();
  }

  Future<void> _sendSMS(List<String> recipients) async {
    try {
      String _result = await sendSMS(
        message: message1,
        recipients: recipients,
        sendDirect: true,
      );
      setState(() => _message = _result);
    } catch (error) {
      setState(() => _message = error.toString());
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Rajkiya Engineering College Bijnor",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              // shadows: [
              //   Shadow(
              //     color: shadowcolor2,
              //     // blurRadius: 3,
              //   ),
              //   Shadow(
              //     color: shadowcolor2,
              //     // blurRadius: 6,
              //   ),
              //   Shadow(
              //     color: shadowcolor2,
              //     // blurRadius: 9,
              //   ),
              // ],
              fontFamily: 'Hind',
              color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.65,
            child: Center(
              child: buildQview(context),
            ),
          ),
          buildresult(),
        ],
      ),
    );
  }

  Widget buildresult() => Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.12,
      child: Column(
        children: [
          Row(children: [
            Text(
              "Name:- ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(barcode == null
                ? '--'
                : '${barcode!.code}'
                    .substring(0, '${barcode!.code}'.indexOf("."))
                    .toUpperCase()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text("Branch:- ", style: TextStyle(fontWeight: FontWeight.w500)),
            Text(barcode == null
                ? '--'
                : '${barcode!.code}'
                    .substring('${barcode!.code}'.indexOf(".") + 1,
                        '${barcode!.code}'.indexOf(".") + 3)
                    .toUpperCase()),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Text('Phone:- ', style: TextStyle(fontWeight: FontWeight.w500)),
            Text(barcode == null
                ? '--'
                : '${barcode!.code}'.substring(
                    '${barcode!.code}'.indexOf("@") + 11,
                    '${barcode!.code}'.indexOf("@") + 21)),
          ]),
          Row(
            children: [
              Text("Roll No:- ", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(barcode == null
                  ? '--'
                  : '${barcode!.code}'.substring(
                      '${barcode!.code}'.indexOf(".") + 7,
                      '${barcode!.code}'.indexOf(".") + 9)),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text("Year:-", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(barcode == null
                  ? '--'
                  : (int.parse('${barcode!.code}'.substring(
                              '${barcode!.code}'.indexOf(".") + 4,
                              '${barcode!.code}'.indexOf(".") + 6)) ==
                          year
                      ? "1"
                      : (int.parse('${barcode!.code}'.substring(
                                      '${barcode!.code}'.indexOf(".") + 4,
                                      '${barcode!.code}'.indexOf(".") + 6)) +
                                  1 ==
                              year
                          ? "2"
                          : (int.parse('${barcode!.code}'.substring(
                                          '${barcode!.code}'.indexOf(".") + 4,
                                          '${barcode!.code}'.indexOf(".") + 6)) +
                                      2 ==
                                  year
                              ? "3"
                              : "4")))),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Text("Purpose:- ", style: TextStyle(fontWeight: FontWeight.w500)),
              Text(barcode == null
                  ? '--'
                  : '${barcode!.code}'.substring(
                      '${barcode!.code}'.indexOf("@") + 21,
                    ))
            ],
          ),
          //SelectableText(showCursor: true,toolbarOptions: ToolbarOptions(cut: true,copy: true,selectAll: true),
          // barcode!=null?'result: ${barcode!.code}':'Scan the code',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    _createdb();
                  },
                  child: Text("Check In")),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              ElevatedButton(
                  onPressed: () {
                    _createdb1();
                  },
                  child: Text("Check Out")),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
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
                        value: sendDirect,
                        onChanged: (bool newValue) {
                          text();

                          setState(() {
                            email = '${barcode!.code}'.substring(
                                0, '${barcode!.code}'.indexOf(".") + 20);
                            print("new value is $newValue");
                            sendDirect = newValue;
                            print("send direct is ${sendDirect} ");
                            if (sendDirect == true) {
                              people1.add(email);
                              people2.add(email);
                              people3.add(email);
                              people4.add(email);
                            } else {
                              people1.remove(email);
                              people2.remove(email);
                              people3.remove(email);
                              people4.remove(email);
                              email = "";
                            }
                          });
                        })
                  ],
                ),
              )
            ],
          ),
        ],
      ));

  Widget buildQview(BuildContext context) => QRView(
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
      controller.scannedDataStream
          .listen((barcode) => setState(() => this.barcode = barcode));
    });
  }

  void text() {
    setState(() {
      int len = '${barcode!.code}'.length;
      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('${barcode!.code}'![i] == '.' && c == 0) {
          c = i;
        }
      }
    });
  }

  _createdb() async {
    int c = 0, d = 0, e = 0, f = 0;
    String g = "";
    setState(() {
      email =
          '${barcode!.code}'.substring(0, '${barcode!.code}'.indexOf(".") + 20);
      Name = '${barcode!.code}'.substring(0, '${barcode!.code}'.indexOf("."));
      int len = '${barcode!.code}'.length;
      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('${barcode!.code}'![i] == '.' && c == 0) {
          c = i;
        }
      }
      Branch = '${barcode!.code}'.substring(c + 1, d + 2).toUpperCase();
      e = int.parse('${barcode!.code}'[d + 6]) * 10;
      f = e + int.parse('${barcode!.code}'[d + 7]);
      g = '${barcode!.code}'.substring(d + 3, d + 8);
      phone = '${barcode!.code}'.substring(d + 19, d + 29);
      Where = '${barcode!.code}'.substring(
        d + 29,
      );
      message1 =
          "Your child $Name is going to $Where at ${Datein()} -regards hostel warden";
    });
    people.add("$phone");
    if (sendDirect == true) {
      people1.add(email);
      people2.add(email);
      people3.add(email);
      people4.add(email);
    }
    await sendEmail();
    people1.remove(email);
    people2.remove(email);
    people3.remove(email);
    people4.remove(email);
    people1.remove(email);
    people2.remove(email);
    people3.remove(email);
    people4.remove(email);
    _send();
    _dbref.child('Students').child("$Name$g$Branch").update({
      'Name': "$Name$g$Branch",
      'Timein': "${Datein()}",
      'Timeout': "0",
      'Phone': "$phone",
      'Where': "$Where"
    });
    email = "";
  }

  _createdb1() {
    int c = 0, d = 0;
    String g = "";
    setState(() {
      Name = '${barcode!.code}'.substring(0, '${barcode!.code}'.indexOf("."));
      int len = '${barcode!.code}'.length;

      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('${barcode!.code}'![i] == '.' && c == 0) {
          c = i;
        }
      }
      Branch = '${barcode!.code}'.substring(c + 1, d + 2).toUpperCase();

      g = '${barcode!.code}'.substring(d + 3, d + 8);
    });
    _dbref.child('Students').child("$Name$g$Branch").update({
      'Timeout': "${Datein()}",
    });
  }

  String Datein() {
    String dt = DateFormat(
      "dd/MMMM",
    ).format(DateTime.now());
    dt = dt.substring(0, 6);
    String dt1 = DateFormat(
      "hh:mm a",
    ).format(DateTime.now());
    return dt + " " + dt1;
  }

  void _send() {
    if (people.isEmpty) {
      setState(() {
        _message = 'At Least 1 Person or Message Required';
        print("your app not work properly");
      });
    } else {
      _sendSMS(people);
      print("your app work properly");
    }
  }

  Future sendEmail() async {
    final _googlesignin = GoogleSignIn(scopes: ['https://mail.google.com/']);
    var user = await Googleauthapi.signIn();
    if (user == null) {
      user = await _googlesignin.signIn();
    }
    ;
    final email = user?.email;
    final auth = await user?.authentication;
    final token = auth?.accessToken!;

    print("authenticated: $email");
    final smtpServer = gmailSaslXoauth2(email!, token!);

    final message = Message()
      ..from = Address(email)
      ..recipients = barcode == null
          ? people1
          : (int.parse('${barcode!.code}'.substring(
                      '${barcode!.code}'.indexOf(".") + 4,
                      '${barcode!.code}'.indexOf(".") + 6)) ==
                  year
              ? people1
              : (int.parse('${barcode!.code}'.substring(
                              '${barcode!.code}'.indexOf(".") + 4,
                              '${barcode!.code}'.indexOf(".") + 6)) +
                          1 ==
                      year
                  ? people2
                  : (int.parse('${barcode!.code}'.substring(
                                  '${barcode!.code}'.indexOf(".") + 4,
                                  '${barcode!.code}'.indexOf(".") + 6)) +
                              2 ==
                          year
                      ? people3
                      : people4)))
      ..subject = "Regarding Your child "
      ..text = "$message1";
    try {
      await send(message, smtpServer);
      showsnackbar('Sent');
    } on MailerException catch (e) {
      print(e);
    }
  }

  void showsnackbar(String s) {
    final snackbar = SnackBar(content: Text(s));
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }
}
