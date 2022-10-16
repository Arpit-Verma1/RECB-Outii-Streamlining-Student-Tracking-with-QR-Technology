import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'splash.dart';

import 'Utils.dart';
class Verifyemail extends StatefulWidget {
  const Verifyemail({Key? key}) : super(key: key);

  @override
  State<Verifyemail> createState() => _VerifyemailState();
}

class _VerifyemailState extends State<Verifyemail> {

  bool isverify=false;
  bool resendemail=false;
  Timer?timer;
  @override
  void initState(){
    super.initState();
    isverify=FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isverify){
      sendverification();
      timer=Timer.periodic(Duration(seconds: 3), (_)=>checkemailverified());
    }
  }
  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }
  Future checkemailverified()async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState((){
      isverify=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isverify)timer?.cancel();
  }
  Future sendverification()async{
    try{
    final user=FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    setState(()=>resendemail=false);
    await Future.delayed(Duration(seconds: 4));
    setState(()=>resendemail=true);}

        catch(e) {
      Utils.showSnackBar(e.toString());
        }
  }
  @override
  Widget build(BuildContext context){
    Color shadowcolor1=Colors.red;
    Color shadowcolor=Colors.blue;
    Size size=MediaQuery.of(context).size;
    return isverify?splash():
  Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Colors.black,

      ),
      child:
      Column(
          children: [
      Padding(padding: EdgeInsets.only(top: 18,bottom: 12,left: 12,right:12)),SingleChildScrollView(child:
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
  ),

  child:SingleChildScrollView(child:Column(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
  SizedBox(
  height:MediaQuery.of(context).size.height*0.03
  ),Padding(padding: EdgeInsets.only(left: 6),child:  Text(
  "Rajkiya Engineering",
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 40,
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
  ),
  ),),
  Padding(padding: EdgeInsets.only(left: 5),child:  Text(
  "College Bijnor",
  style: TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 40,
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
  ),
  ),),
  SizedBox(
  height: size.height*0.20,
  ),
  Center(
  child: Padding(
  padding: EdgeInsets.only(left: 10,right: 10),
  child:Container(width: size.width*0.7,
  height: size.height*0.1,
  child:Text("A link has been sent to your your email for varification",style:  TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 20,

      shadows: [
        Shadow(
          color: shadowcolor,
          blurRadius: 3,
        ),
        Shadow(
          color: shadowcolor,
          blurRadius: 6,
        ),
        Shadow(
          color: shadowcolor,
          blurRadius: 9,
        ),
      ],fontFamily: 'Pacifico',
      color: Colors.white
  ),),))),
    InkWell(
      onTap:(){
        sendverification();
      },
      borderRadius:BorderRadius.circular(30),
      child: Container(
        width:size.width*0.5,
        height: size.height*0.05,
        decoration: BoxDecoration(
          color: Colors.purple,
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.shade200,
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 3.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                3, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
        child:Text(
            "Reset Email",
            textAlign: TextAlign.center,
            style:TextStyle(
              height: 1.7,
              fontSize: 20,

              color: Colors.white,
            )
        ) ,
      ),
    ),
    InkWell(
      onTap:()=>FirebaseAuth.instance.signOut(),
      borderRadius:BorderRadius.circular(30),
      child: Container(
        width:size.width*0.3,
        height: size.height*0.03,
        decoration: BoxDecoration(
          color: Colors.purple,
          boxShadow: [
            BoxShadow(
              color: Colors.purpleAccent.shade200,
              blurRadius: 5.0, // soften the shadow
              spreadRadius: 3.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                3, // Move to bottom 10 Vertically
              ),
            )
          ],
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
        child:Text(
            "Cancel",
            textAlign: TextAlign.center,
            style:TextStyle(
              height: 1.5,
              fontSize: 15,

              color: Colors.white,
            )
        ) ,
      ),
    ),
        SizedBox(height: 10,),

      ],
    ),
    
  )))]));}
}
