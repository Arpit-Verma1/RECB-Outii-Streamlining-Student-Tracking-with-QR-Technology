import 'dart:async';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add user.dart';
import 'main.dart';
import 'page.dart';
import 'qrpage.dart';

import 'show.dart';
import 'splash.dart';
import 'user_data.dart';
import 'package:url_launcher/url_launcher.dart';
final Uri _url = Uri.parse('https://www.facebook.com/recbup/');
final Uri _url1 = Uri.parse('https://twitter.com/recb_up');
final Uri _url2 = Uri.parse('https://www.linkedin.com/company/rajkiya-engineering-college-bijnor/');
final Uri _url3 = Uri.parse('https://www.instagram.com/recbup/');
class sample extends StatefulWidget {
  const sample({Key? key, required this.show}) : super(key: key);
final bool show;
  @override
  State<sample> createState() => _sampleState();
}

class _sampleState extends State<sample> {
  List page=[

qrscan(),
    FetchData()
  ];
  List page1=[
    Page1(),
    user_data()

  ];
  int i=0;
  void _onItemTapped(int index) {
    setState(() {
      i = index;
    });
  }

  bool show1=false;

  @override
  @override
  void initState(){
Timer.periodic(Duration(seconds: 2), (_)=>_readdb1());
    _dbref = FirebaseDatabase.instance.ref();
    _readdb1();
    setState(() {

    });
    super.initState();

  }
  final user=FirebaseAuth.instance.currentUser;

  final items=<Widget>[

    Icon(Icons.qr_code_scanner_rounded),
    Icon(Icons.search),
  ];
  late DatabaseReference _dbref;
  final items1=<Widget>[

    Icon(Icons.qr_code),
    Icon(Icons.account_circle),
  ];
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return FutureBuilder(future:_readdb1(),
        builder:((context, snapshot) =>
      Scaffold(

        bottomNavigationBar:Theme(

        data:Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.black)) ,
    child:
    CurvedNavigationBar(
    index: 0,
    color: Colors.cyanAccent,
    buttonBackgroundColor: Colors.purpleAccent,
    backgroundColor: Color.fromARGB(255,245,189,159),

    height: 55,
      items:show1==false?items1:items,
    onTap: (pageindex)=>setState((){
    this.i=pageindex;

    }),

    ),
    ),drawer: Drawer(
        elevation: 20,
        width: MediaQuery.of(context).size.width*0.86,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30)),
        ),
        child:Container(

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
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
                ), ]
          ),
          child:SingleChildScrollView(
            child: Column(
                children: [
                  Container(

                    height: 200,

                    width: double.infinity,

                    // color: Colors.black,

                    child: Stack(children: [

                      Container(

                        height: 150,

                        decoration: BoxDecoration(

                            image: DecorationImage(

                                colorFilter: ColorFilter.mode(

                                    Colors.black.withOpacity(.8),

                                    BlendMode.darken),

                                fit: BoxFit.cover,

                                image: AssetImage('assets/recb.jpg')),

                            color: Colors.grey.shade900,

                            boxShadow: [BoxShadow(blurRadius: 15)],

                            borderRadius: BorderRadius.only(

                                bottomRight: Radius.circular(150))),

                        padding: EdgeInsets.all(10),

                        width: double.infinity,

                      ),

                      Positioned(
                        bottom: 0,
                        left: 50,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: 100,
                              width: 100,

                              decoration: BoxDecoration(

                                image: DecorationImage(

                                    fit: BoxFit.cover,

                                    image: AssetImage('assets/logo.png')),

                                color: Colors.grey,

                                shape: BoxShape.circle,

                                boxShadow: [

                                  BoxShadow(blurRadius: 7, offset: Offset(0, 3))

                                ],

                              )),

                        ),

                      ),

                    ]),

                  ),
                  SizedBox(height: 20,),

                  ///////////////////////////

Visibility(visible: show1,
    child:
                    Container(

                      height: 40,
                      width: MediaQuery.of(context).size.width,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.only(

                              bottomRight: Radius.circular(30),

                              bottomLeft: Radius.circular(30),

                              topLeft: Radius.circular(30),

                              topRight: Radius.circular(30)),

                          color: Colors.grey.shade900,

                          boxShadow: [BoxShadow(blurRadius: 4)]),

                      // width: 150,

                      margin:

                      EdgeInsets.symmetric(horizontal: 15, vertical: 5),

                      alignment: Alignment.center,
                      child:
                      Padding(padding: EdgeInsets.only(left: 5),child:GestureDetector(onTap:(){
                        String t="";
                        _dbref.child('User').once().then((DatabaseEvent databaseEvent) {
                          setState(() async {
                            t=databaseEvent.snapshot.value.toString();
                            if(t.contains("${user!.email!}")){
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text("You are authorized ")));
                              await Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>add()));}
                            else{
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  content: Text("You are not authorized ")));

                            }});});
                      },child:Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.add,color: Colors.white,),
                            SizedBox(width: 10,),
                            Text('Add User'
                                ,style: TextStyle(

                                    fontSize: 15,

                                    color: Colors.white,

                                    fontWeight: FontWeight.w600)),]))

                        ,),
                    )),
                  /////////////////////////////////////
            Visibility(visible: show1,
                child:
                  Container(

                    height: 40,
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(

                            bottomRight: Radius.circular(30),

                            bottomLeft: Radius.circular(30),

                            topLeft: Radius.circular(30),

                            topRight: Radius.circular(30)),

                        color: Colors.grey.shade900,

                        boxShadow: [BoxShadow(blurRadius: 4)]),

                    // width: 150,

                    margin:

                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),

                    alignment: Alignment.center,
                    child:
                    Padding(padding: EdgeInsets.only(left: 5),child:GestureDetector(onTap:(){

      Navigator.of(context).push(MaterialPageRoute(builder: (Context)=>Page1()));
                    },child:Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.qr_code,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Your Qr Code'
                              ,style: TextStyle(

                                  fontSize: 15,

                                  color: Colors.white,

                                  fontWeight: FontWeight.w600)),]))

                      ,),)),

                  Container(

                    height: 40,
                    width: MediaQuery.of(context).size.width,

                    decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(

                            bottomRight: Radius.circular(30),

                            bottomLeft: Radius.circular(30),

                            topLeft: Radius.circular(30),

                            topRight: Radius.circular(30)),

                        color: Colors.grey.shade900,

                        boxShadow: [BoxShadow(blurRadius: 4)]),

                    // width: 150,

                    margin:

                    EdgeInsets.symmetric(horizontal: 15, vertical: 5),

                    alignment: Alignment.center,
                    child:
                    Padding(padding: EdgeInsets.only(left: 5),child:GestureDetector(onTap:(){
                      FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage())));

                      FirebaseAuth.instance.signOut();

                    },child:Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [Icon(Icons.logout,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('Logout'
                              ,style: TextStyle(

                                  fontSize: 15,

                                  color: Colors.white,

                                  fontWeight: FontWeight.w600)),]))

                      ,),
                  ),

                  Container(

                      height: 60,
                      width: MediaQuery.of(context).size.width,

                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.only(

                            bottomRight: Radius.circular(30),

                            bottomLeft: Radius.circular(30),

                            topLeft: Radius.circular(30),

                            topRight: Radius.circular(30)),

                        color: Colors.grey,

                      ),

                      // width: 150,

                      margin:

                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),

                      alignment: Alignment.center,
                      child:
                      Padding(padding: EdgeInsets.only(left: 5),child:
                      Row(
                        children: [
                          IconButton(onPressed: ()async{

                            if(await canLaunchUrl(_url)){
                              await launchUrl(_url);
                            }
                          }, icon:Icon(FontAwesomeIcons.facebook,
                            size:40.0,color: Colors.blue,)),SizedBox(width: 5,)
                          ,IconButton(onPressed: ()async{

                            if(await canLaunchUrl(_url1)){
                              await launchUrl(_url1);
                            }
                          },icon:Icon(FontAwesomeIcons.twitter,
                            size:40.0,color: Colors.blue,)),SizedBox(width: 5,),
                          IconButton(onPressed:()async{

                            if(await canLaunchUrl(_url2)){
                              await launchUrl(_url2);
                            }
                          }, icon: Icon(FontAwesomeIcons.linkedin,
                            size:40.0,color: Colors.blue,),),SizedBox(width: 5,),
                          IconButton(onPressed:()async{

                            if(await canLaunchUrl(_url3)){
                              await launchUrl(_url3);
                            }
                          }, icon:Icon(FontAwesomeIcons.instagram,
                            size:40.0,color: Colors.purpleAccent,))
                        ],
                      )))
                ]
            ),),
        ) ),


        body: show1==false?page1[i]:page[i],
     )
    )
    );
  }
  _readdb1(){
    String t="";

    _dbref.child('User').once().then((DatabaseEvent databaseEvent) {
      setState((){
        t=databaseEvent.snapshot.value.toString();
        if(t.contains("${user!.email!}")){

          setState(() {
            show1=true;

          });
          setState(() {

          });

          }
      else{
          setState(() {
            show1=false;

          });
          setState(() {

          });
        }}
      );
    });


  }
}
