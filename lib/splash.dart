import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'sample.dart';
import 'package:video_player/video_player.dart';
class splash extends StatefulWidget {
  const splash({Key? key}) : super(key: key);

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  final user=FirebaseAuth.instance.currentUser;
  late DatabaseReference _dbref;
  String databasejson="";
  bool show1=false;
  _readdb1(){
    String t="";
    _dbref.child('User').once().then((DatabaseEvent databaseEvent) {
      setState((){
        databasejson=databaseEvent.snapshot.value.toString();
      });
    });
    print(databasejson);

  }
  @override
  void initState() {
    _controller = VideoPlayerController.asset(
      'assets/final4.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    // Once the video has been loaded we play the video and set looping to true.
    _controller.play();
    _controller.setVolume(0.0);
    _controller.setLooping(true);
    _dbref = FirebaseDatabase.instance.ref();
    _readdb1();
    _readdb1();
    if(databasejson.contains("${user!.email!}"))
      setState(() {
        show1=!show1;
      });
    super.initState();
    Timer(Duration(seconds:5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>sample(show: show1,)));});
  }
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
  Widget build(BuildContext context) {
    Color shadowcolor1=Colors.red;
    Size size=MediaQuery.of(context).size;
  return Scaffold(
    backgroundColor: Colors.black,
      body:Center(
          child: Padding(
              padding: EdgeInsets.only(left: 10,right: 10),
              child:Container(width: size.width*0.9,
                height: size.height*0.7,
                child:
                Container(
                height:MediaQuery.of(context).size.height*0.92,
    width: MediaQuery.of(context).size.width*0.9,
    clipBehavior: Clip.none,
    decoration: BoxDecoration(
    color: Colors.black,

    //Border.all

    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
    bottomLeft: Radius.circular(20.0),
    bottomRight: Radius.circular(20.0),
    ),
    boxShadow: [
    BoxShadow(
    color: Colors.grey,
    offset: const Offset(
    5.0,
    5.0,
    ),
    blurRadius: 10.0,
    spreadRadius: 1.0,
    ),
    BoxShadow(
    color: Colors.grey,
    offset: const Offset(
    -5.0,
    -5.0,
    ),
    blurRadius: 10.0,
    spreadRadius: 1.0,
    ),//BoxShadow
    BoxShadow(
    color: Colors.white,
    offset: const Offset(0.0, 0.0),
    blurRadius: 0.0,
    spreadRadius: 0.0,
    ), //BoxShadow
    ],
    ),child:
                Column(children: [Padding(padding: EdgeInsets.all(40),child:
                FutureBuilder(
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
                )),Padding(padding: EdgeInsets.only(left:20,right:20),child:
                  Text(
    "Rajkiya Engineering College",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 30,
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
    color: Colors.white
    ),)
    ),
                  Padding(padding: EdgeInsets.only(left:30,right: 30),child:
                  Text(
                    "Bijnor Outii",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 29,
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
                        color: Colors.white
                    ),)
                  ),  Expanded(child: SpinKitCircle(
                      size: 50,
                      itemBuilder: (context,index){
                        final colors=[Colors.orange,Colors.cyanAccent];
                        final color=colors[index%colors.length];
                        return DecoratedBox(decoration:BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(2),
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2,
                                  offset: Offset(5, 5),
                                  color: Colors.redAccent
                              )
                            ]
                        ));
                      }
                  ))],))
      ),)),
  );
  }
}
