import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:video_player/video_player.dart';
class qrscan extends StatefulWidget {
  const qrscan({Key? key}) : super(key: key);

  @override
  State<qrscan> createState() => _qrscanState();
}

class _qrscanState extends State<qrscan> {
  final user=FirebaseAuth.instance.currentUser;
  String Year="";
  String Branch="";
  String Name="";
  String Rollno="";
  String phone ="";
  String Where="";
  final qrkey=GlobalKey(debugLabel: 'QR');
  QRViewController?controller;
 DatabaseReference _dbref=FirebaseDatabase.instance.ref();

  Barcode? barcode;
TextEditingController Controller=TextEditingController();

  Color shadowcolor1=Colors.red;
  Color shadowcolor2=Colors.purpleAccent.shade700;
  @override
  void initState(){
    super.initState();
    _dbref=FirebaseDatabase.instance.ref();}

  @override


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,


        title: Text("Rajkiya Engineering College Bijnor", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
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
            color: Colors.white
        ),),),
      backgroundColor: Color.fromARGB(255,245,189,159),
      body: Column(

        children: [

          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.67,
            child:Center(
              child:  buildQview(context)
                ,
            ) ,
          ),
          buildresult()
         ,

        ],
      ),
    );
  }

  Widget buildresult()=>Container(margin: EdgeInsets.all(5),
      decoration: BoxDecoration(borderRadius:BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.1,child:Column(children: [
        SelectableText(showCursor: true,toolbarOptions: ToolbarOptions(cut: true,copy: true,selectAll: true),
          barcode!=null?'result: ${barcode!.code}':'Scan the code',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
SizedBox(height: MediaQuery.of(context).size.height*0.01,),
       Row(mainAxisAlignment: MainAxisAlignment.center,
         children: [ElevatedButton(onPressed: (){
         _createdb();
       }, child: Text("Check In")),SizedBox(width: MediaQuery.of(context).size.width*0.2,)
           ,ElevatedButton(onPressed: (){
         _createdb1();
       }, child: Text("Check Out"))],)

    ],)
     );

  Widget buildQview(BuildContext context)=>QRView(key: qrkey, onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
        cutOutSize: MediaQuery.of(context).size.width*0.6,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10
    ),);
  void onQRViewCreated(QRViewController controller){
    setState((){
      controller.resumeCamera();
      this.controller=controller;
      controller.scannedDataStream.listen((barcode)=>setState(()=>this.barcode=barcode));
    });}
  _createdb(){
    int c=0,d=0,e=0,f=0;
    String g="";
    setState(() {

      Name='${barcode!.code}'.substring(0,'${barcode!.code}'.indexOf("."));
      int len='${barcode!.code}'.length;

      for(int i=0;i<len;i++){
        if(c!=0&&d==0){
          d=i;  break;
        }
        if('${barcode!.code}'![i]=='.'&&c==0){
          c=i;
        }

      }
      Branch='${barcode!.code}'.substring(c+1,d+2).toUpperCase();
      e=int.parse('${barcode!.code}'[d+6])*10;
      f=e+int.parse('${barcode!.code}'[d+7]);
       g='${barcode!.code}'.substring(d+3,d+8);
       phone='${barcode!.code}'.substring(d+19,d+29);
       Where='${barcode!.code}'.substring(d+29,);
    });
    _dbref.child('Students').child("$Name$g$Branch").update({'Name':"$Name$g$Branch",'Timein':"${Datein()}",'Timeout':"0",'Phone':"$phone",'Where':"$Where"});

  }
  _createdb1(){
    int c=0,d=0;
    String g="";
    setState(() {

      Name='${barcode!.code}'.substring(0,'${barcode!.code}'.indexOf("."));
      int len='${barcode!.code}'.length;

      for(int i=0;i<len;i++){
        if(c!=0&&d==0){
          d=i;  break;
        }
        if('${barcode!.code}'![i]=='.'&&c==0){
          c=i;
        }

      }
      Branch='${barcode!.code}'.substring(c+1,d+2).toUpperCase();

      g='${barcode!.code}'.substring(d+3,d+8);

    });
    _dbref.child('Students').child("$Name$g$Branch").update({'Timeout':"${Datein()}",});

  }
  String Datein(){
    String dt=DateFormat("dd/MMMM",).format(DateTime.now());
    dt=dt.substring(0,6);
    String dt1=DateFormat("hh:mm a",).format(DateTime.now());
    return dt+" "+dt1;
  }
}
