import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:rive/rive.dart';
import 'main.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

List destination_list = ["Market", "Jannat", "Home", "Bank", "Anything Else"];

class Qr_Generate extends StatefulWidget {
  const Qr_Generate({Key? key}) : super(key: key);

  @override
  State<Qr_Generate> createState() => _Qr_GenerateState();
}

class _Qr_GenerateState extends State<Qr_Generate> {
  final user = FirebaseAuth.instance.currentUser;
  bool QR_Show = false;
  bool custom_destinatinaton_check = false;
  String Branch = "";
  String Name = "";
  String User = "";
  DatabaseReference _dbref = FirebaseDatabase.instance.ref();
  String phone = "";
  final phone_controller = TextEditingController();
  final destination_controller = TextEditingController();
  final confetticontroller = ConfettiController();
  @override
  void initState() {
    super.initState();
    QR_Show = UserSimplePreferences.getusername() ?? false;
    User = UserSimplePreferences1.getusername1() ?? "";

    // FlutterWindowManager.addFlags(
    //   FlutterWindowManager.FLAG_SECURE,
    // );
  }

  int selecteditem = -1;
  @override
  void dispose() {
    phone_controller.dispose();
    super.dispose();
  }

  String destination = "";
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 189, 159),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: RiveAnimation.asset(
          'assets/recb_outii.riv',
        ),
        bottom: PreferredSize(
            child: Container(
                height: size.height * 0.07,
                padding: EdgeInsets.all(10),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selecteditem = index;
                            destination = destination_list[index];
                            custom_destinatinaton_check = index == 4
                                ? !custom_destinatinaton_check
                                : false;
                          });
                        },
                        child: Text(destination_list[index]),
                        style: ElevatedButton.styleFrom(
                            primary: selecteditem == index
                                ? Colors.green
                                : Colors.blue),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemCount: 5)),
            preferredSize: Size.fromHeight(40)),
        title: Text(
          "Rajkiya Engineering College Bijnor",
          style: GoogleFonts.cookie(
            wordSpacing: 2,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Form(
          key: formGlobalKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Confetti(
                  angle: pi / 2,
                  confetticontroller: confetticontroller,
                ),
                Confetti(
                  angle: 0,
                  confetticontroller: confetticontroller,
                ),
                Confetti(
                  angle: pi,
                  confetticontroller: confetticontroller,
                ),
                Visibility(
                  visible: QR_Show,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: PrettyQr(
                        image: AssetImage('assets/logo.png'),
                        typeNumber: 4,
                        size: 200,
                        data: User + destination,
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        roundEdges: true,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !QR_Show,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone no can not be empty';
                      } else if (value.length < 10) {
                        return 'no can not be less than 10 digits';
                      } else if (value.length > 10) {
                        return 'no can not be more than 10 digits';
                      } else {
                        return null;
                      }
                    },
                    controller: phone_controller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            setState(() {
                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();

                                User = user!.email! +
                                    phone_controller.text +
                                    destination;
                                _createdb();
                                QR_Show = !QR_Show;
                                confetticontroller.play();
                                Timer(Duration(seconds: 5), () {
                                  setState(() {
                                    confetticontroller.stop();
                                  });
                                });
                              }
                            });

                            await UserSimplePreferences1.setusername1(User);
                            await UserSimplePreferences.setusername(QR_Show);
                          },
                          icon: Icon(Icons.check),
                        ),
                        hintText:
                            "Enter your Mobile no to generate Your QR Code"),
                  ),
                ),
                Visibility(
                  visible: custom_destinatinaton_check,
                  child: TextField(
                    controller: destination_controller,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            setState(() {
                              if (destination_controller.text.length > 20) {
                                final snackbar = SnackBar(
                                    content: Text(
                                        "Enter the text within 40 letter"));
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(snackbar);
                              } else {
                                destination = destination_controller.text;
                              }

                              custom_destinatinaton_check =
                                  !custom_destinatinaton_check;
                            });
                          },
                          icon: Icon(Icons.check),
                        ),
                        hintText: "Enter Place Where You are Going"),
                  ),
                )
              ],
            ),
          )),
    );
  }

  _createdb() {
    int c = 0, d = 0;
    String roll_no_and_year = "";
    setState(() {
      Name = '${User}'.substring(0, '${User}'.indexOf("."));
      int len = '${User}'.length;

      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('${User}'![i] == '.' && c == 0) {
          c = i;
        }
      }
      Branch = '${User}'.substring(c + 1, d + 2).toUpperCase();
      roll_no_and_year = '${User}'.substring(d + 3, d + 8);
      phone = '${User}'.substring(d + 19, d + 29);
    });
    _dbref.child('Students').child("$Name$roll_no_and_year$Branch").update({
      'Name': "$Name$roll_no_and_year$Branch",
      'Timein': "--",
      'Timeout': "--",
      'Phone': "$phone",
      'Where': "--"
    });
  }
}
