import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:video_player/video_player.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final user = FirebaseAuth.instance.currentUser;
  bool show = false;
  bool show1 = false;
  String Branch = "";
  String Name = "";
  bool isPlaying = false;
  String s = "";
  DatabaseReference _dbref = FirebaseDatabase.instance.ref();
  int c = 0;
  int d = 0;
  int f = 0;
  int g = 0;
  int e = 0;
  String phone = "";
  final contoller = TextEditingController();
  final contoller1 = TextEditingController();
  final contoller4 = TextEditingController();
  final controller2 = ConfettiController();
  late VideoPlayerController _controller3;
  late Future<void> _initializeVideoPlayerFuture;
  Color shadowcolor2 = Colors.purpleAccent.shade700;
  @override
  void initState() {
    super.initState();
    show = UserSimplePreferences.getusername() ?? false;
    s = UserSimplePreferences1.getusername1() ?? "";
    _controller3 = VideoPlayerController.asset(
      'assets/final4.mp4',
    );
    _initializeVideoPlayerFuture = _controller3.initialize();
    // Once the video has been loaded we play the video and set looping to true.
    _controller3.setVolume(0.0);
    _controller3.play();
    _controller3.setLooping(true);
    //FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE,);
  }

  int bed = -1;
  @override
  void dispose() {
    contoller1.dispose();
    super.dispose();
  }

  String k = "";
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 189, 159),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Container(
          width: size.width * 0.2,
          height: size.width * 0.2,
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller3.value.aspectRatio,
                  child: VideoPlayer(_controller3),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        bottom: PreferredSize(
            child: Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  bed = 0;
                                  k = "Market";
                                  show1 = false;
                                });
                              },
                              child: Text("Market"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      bed == 0 ? Colors.green : Colors.blue),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  bed = 1;
                                  k = "Jannat";
                                  show1 = false;
                                });
                              },
                              child: Text("Jannat"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      bed == 1 ? Colors.green : Colors.blue),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  bed = 2;
                                  k = "Home";
                                  show1 = false;
                                });
                              },
                              child: Text("Home"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      bed == 2 ? Colors.green : Colors.blue),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  bed = 3;
                                  k = "Bank";
                                  show1 = false;
                                });
                              },
                              child: Text("Bank"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      bed == 3 ? Colors.green : Colors.blue),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  bed = 4;
                                  show1 = !show1;
                                });
                              },
                              child: Text("Anything Else"),
                              style: ElevatedButton.styleFrom(
                                  primary:
                                      bed == 4 ? Colors.green : Colors.blue),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                          ]),
                        )
                      ],
                    ))),
            preferredSize: Size.fromHeight(60)),
        title: Text(
          "Rajkiya Engineering College Bijnor",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              shadows: [
                Shadow(
                  color: shadowcolor2,
                  blurRadius: 3,
                ),
                Shadow(
                  color: shadowcolor2,
                  blurRadius: 6,
                ),
                Shadow(
                  color: shadowcolor2,
                  blurRadius: 9,
                ),
              ],
              fontFamily: 'MsMadi',
              color: Colors.white),
        ),
      ),
      body: Form(
          key: formGlobalKey,
          child: Center(
              child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ConfettiWidget(
                    confettiController: controller2,
                    shouldLoop: true,
                    emissionFrequency: 0.08,
                    gravity: 0.3,
                    blastDirection: pi / 2,
                    createParticlePath: (size) {
                      final path = Path();
                      path.addPolygon([
                        Offset(20, 5),
                        Offset(8, 39.6),
                        Offset(38, 15.6),
                        Offset(2, 15.6),
                        Offset(32, 39.6),
                      ], true);
                      return path;
                    }),
                ConfettiWidget(
                    confettiController: controller2,
                    shouldLoop: true,
                    emissionFrequency: 0.08,
                    gravity: 0.3,
                    blastDirection: 0,
                    createParticlePath: (size) {
                      final path = Path();
                      path.addPolygon([
                        Offset(20, 5),
                        Offset(8, 39.6),
                        Offset(38, 15.6),
                        Offset(2, 15.6),
                        Offset(32, 39.6),
                      ], true);
                      return path;
                    }),
                ConfettiWidget(
                    confettiController: controller2,
                    shouldLoop: true,
                    emissionFrequency: 0.08,
                    gravity: 0.3,
                    blastDirection: pi,
                    createParticlePath: (size) {
                      final path = Path();
                      path.addPolygon([
                        Offset(20, 5),
                        Offset(8, 39.6),
                        Offset(38, 15.6),
                        Offset(2, 15.6),
                        Offset(32, 39.6),
                      ], true);
                      return path;
                    }),
                Visibility(
                  visible: show,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: PrettyQr(
                      image: AssetImage('assets/logo.png'),
                      typeNumber: 4,
                      size: 200,
                      data: s + k,
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                    ),
                  ),
                ),
                Visibility(
                  visible: !show,
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
                    controller: contoller1,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            setState(() {
                              if (formGlobalKey.currentState!.validate()) {
                                formGlobalKey.currentState!.save();
                                s = user!.email! + contoller1.text + k;
                                _createdb();
                                show = !show;
                                controller2.play();
                                Timer(Duration(seconds: 10), () {
                                  setState(() {
                                    controller2.stop();
                                  });
                                });
                              }
                            });

                            await UserSimplePreferences1.setusername1(s);
                            await UserSimplePreferences.setusername(show);
                          },
                          icon: Icon(Icons.check),
                        ),
                        hintText:
                            "Enter your Mobile no to generate Your QR Code"),
                  ),
                ),
                Visibility(
                  visible: show1,
                  child: TextField(
                    controller: contoller4,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async {
                            setState(() {
                              if (contoller4.text.length > 20) {
                                final snackbar = SnackBar(
                                    content: Text(
                                        "Enter the text within 40 letter"));
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(snackbar);
                              } else {
                                k = contoller4.text;
                              }

                              show1 = !show1;
                            });
                          },
                          icon: Icon(Icons.check),
                        ),
                        hintText: "Enter Place Where You are Going"),
                  ),
                )
              ],
            ),
          ))),
    );
  }

  _createdb() {
    int c = 0, d = 0, e = 0, f = 0;
    String g = "";
    setState(() {
      Name = '${s}'.substring(0, '${s}'.indexOf("."));
      int len = '${s}'.length;

      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('${s}'![i] == '.' && c == 0) {
          c = i;
        }
      }
      Branch = '${s}'.substring(c + 1, d + 2).toUpperCase();
      e = int.parse('${s}'[d + 6]) * 10;
      f = e + int.parse('${s}'[d + 7]);
      g = '${s}'.substring(d + 3, d + 8);
      phone = '${s}'.substring(d + 19, d + 29);
    });
    _dbref.child('Students').child("$Name$g$Branch").update({
      'Name': "$Name$g$Branch",
      'Timein': "--",
      'Timeout': "--",
      'Phone': "$phone",
      'Where': "--"
    });
  }
}
