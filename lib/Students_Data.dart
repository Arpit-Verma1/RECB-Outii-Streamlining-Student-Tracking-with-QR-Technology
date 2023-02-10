import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'speechapi.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  Color shadowcolor1 = Colors.red;
  Color shadowcolor2 = Colors.purpleAccent.shade700;
  Query dbRef = FirebaseDatabase.instance.ref().child('Students');
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('Students');
  TextEditingController controller1 = TextEditingController();
  bool islistening = false;
  final String b1 = DateFormat("yyyy").format(DateTime.now()).substring(2, 4);
  final int b2 =
      int.parse(DateFormat("yyyy").format(DateTime.now()).substring(2, 4)) - 1;
  final int b3 =
      int.parse(DateFormat("yyyy").format(DateTime.now()).substring(2, 4)) - 2;
  final int b4 =
      int.parse(DateFormat("yyyy").format(DateTime.now()).substring(2, 4)) - 3;
  String c1 = "";
  String c3 = "";
  String c4 = "";
  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'assets/final4.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    // Once the video has been loaded we play the video and set looping to true.
    _controller.setVolume(0.0);
    _controller.play();
    _controller.setLooping(true);
    super.initState();
  }

  Widget listItem({required Map student}) {
    final String a = student['Name'];
    Size size = MediaQuery.of(context).size;
    return Visibility(
        visible: controller1.text.toLowerCase() == "red"
            ? (student['Timeout'] == "0" ? true : false)
            : controller1.text.toLowerCase() == "green"
                ? (student['Timeout'] != "0" ? true : false)
                : controller1.text.toLowerCase() == "first red"
                    ? (a.contains("${b1}0") && student['Timeout'] == "0")
                    : controller1.text.toLowerCase() == "second red"
                        ? (a.contains("${b2}0") && student['Timeout'] == "0")
                        : controller1.text.toLowerCase() == "third red"
                            ? (a.contains("${b3}0") &&
                                student['Timeout'] == "0")
                            : controller1.text.toLowerCase() == "fourth red"
                                ? (a.contains("${b4}0") &&
                                    student['Timeout'] == "0")
                                : a.contains(controller1.text.toLowerCase()),
        child: Container(
          margin: const EdgeInsets.all(0),
          padding: const EdgeInsets.all(7),
          height: 35,
          decoration: BoxDecoration(
              color: "${student['Timeout'].toString()}" == "0"
                  ? Colors.red
                  : Colors.green,
              border: Border(bottom: BorderSide(color: Colors.black))),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student['Name'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text(
                  student['Timein'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text(
                  student['Timeout'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text(
                  student['Where'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: size.width * 0.1,
                ),
                Text(
                  student['Phone'],
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }

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
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
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
          bottom: PreferredSize(
              child: Container(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        children: [
                          Row(children: [
                            SizedBox(
                                width: size.width * 0.7,
                                height: size.height * 0.07,
                                child: TextField(
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                  controller: controller1,
                                  style: TextStyle(color: Colors.white),
                                  decoration: new InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                          color: Colors.white, width: 2),
                                    ),
                                    contentPadding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    prefixIcon: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        setState(() {
//print(b2);
                                        });
                                      },
                                    ),
                                    filled: false,
                                    hintText: 'Search Students',
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                )),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            AvatarGlow(
                              animate: islistening,
                              endRadius: 30,
                              glowColor: Colors.white,
                              showTwoGlows: true,
                              child: SizedBox(
                                  width: size.width * 0.15,
                                  height: size.height * 0.07,
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(55.0),
                                            side: BorderSide(
                                                width: 2, color: Colors.white),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent)),
                                    onPressed: () {
                                      togglerecording();
                                    },
                                    child: Icon(
                                      islistening ? Icons.mic : Icons.mic_none,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  )),
                            ),
                          ]),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(children: [
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 3,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 6,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 9,
                                      ),
                                    ],
                                    fontFamily: 'MsMadi',
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: size.width * 0.2,
                              ),
                              Text(
                                "Timein",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 3,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 6,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 9,
                                      ),
                                    ],
                                    fontFamily: 'MsMadi',
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: size.width * 0.2,
                              ),
                              Text(
                                "Timeout",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 3,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 6,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 9,
                                      ),
                                    ],
                                    fontFamily: 'MsMadi',
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: size.width * 0.2,
                              ),
                              Text(
                                "Purpose",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 3,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 6,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 9,
                                      ),
                                    ],
                                    fontFamily: 'MsMadi',
                                    color: Colors.white),
                              ),
                              SizedBox(
                                width: size.width * 0.2,
                              ),
                              Text(
                                "Phone",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    shadows: [
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 3,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 6,
                                      ),
                                      Shadow(
                                        color: shadowcolor1,
                                        blurRadius: 9,
                                      ),
                                    ],
                                    fontFamily: 'MsMadi',
                                    color: Colors.white),
                              ),
                            ]),
                          )
                        ],
                      ))),
              preferredSize: Size.fromHeight(100)),
        ),
        body: Container(
          height: double.infinity,
          child: FirebaseAnimatedList(
            padding: EdgeInsets.all(0.0),
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map student = snapshot.value as Map;
              student['key'] = snapshot.key;
              return listItem(student: student);
            },
          ),
        ));
  }

  Future togglerecording() => Speechapi.togglerecording(
      onresult: (text) => setState(
            () => this.controller1.text = text,
          ),
      onlistening: (islistening) {
        setState(() => this.islistening = islistening);
      });
}
