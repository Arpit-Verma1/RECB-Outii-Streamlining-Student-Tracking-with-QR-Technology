import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:shimmer/shimmer.dart';

import 'package:video_player/video_player.dart';
class user_data extends StatefulWidget {
  const user_data({Key? key}) : super(key: key);

  @override
  State<user_data> createState() => _user_dataState();
}

class _user_dataState extends State<user_data> {
  String? s=UserSimplePreferences1.getusername1();
  String m="";
bool show1=false;

  String Branch="";
  final contoller1=TextEditingController();
  final contoller2=TextEditingController();
  final contoller4=TextEditingController();
  String Rollno="";
  String phone ="";
  final user=FirebaseAuth.instance.currentUser;
  late VideoPlayerController _controller3;
  late Future<void> _initializeVideoPlayerFuture;
  Color shadowcolor1=Colors.red;
  Color shadowcolor2=Colors.purpleAccent.shade700;
String Name="";
String Year="";
  String g="";
  Query dbRef =FirebaseDatabase.instance.ref().child('Students');
DatabaseReference reference= FirebaseDatabase.instance.ref() ;
  final formGlobalKey = GlobalKey < FormState > ();
  @override


  bool isRecoderready=false;
  double rating1=1;
 bool show=false;
  void initState(){
    super.initState();


    tz.initializeTimeZones();

    s=UserSimplePreferences1.getusername1()??"";
    if(s!=""){
      setState(() {
        show=true;
      });
    _createdb1();}

    _controller3 = VideoPlayerController.asset(
      'assets/final4.mp4',
    );
    _initializeVideoPlayerFuture = _controller3.initialize();
    // Once the video has been loaded we play the video and set looping to true.
    _controller3.setVolume(0.0);
    _controller3.play();
    _controller3.setLooping(true);


  }
  @override
  Widget listItem({required Map student}) {
    Size size=MediaQuery.of(context).size;

    return
    Center(
        child:Visibility(visible: student['Name']=="$Name$g$Branch",
            child:

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [Text("Name" ,style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),),
                SizedBox(width: size.width*0.13,),
                Text(
                "${Name.toUpperCase()}",
                style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),)
          ,
            ],),
              Row(children: [Text("Branch",style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),), SizedBox(width:size.width*0.11,),Text(
                Branch=="IT"?"Information Technology":Branch=="EE"?"Electrical Enginnering":"Civil Engineering",
                style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),
              )],),

        Row(children: [Text("Time in",style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),), SizedBox(width: size.width*0.1,),Text(
                student['Timein'],
                style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold ),
              )]),
        Row(children: [Text("Timeout",style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),), SizedBox(width: size.width*0.087,),Text(
                student['Timeout'],
                style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),
              ),]),
              Row(children: [Text("Purpose",style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),), SizedBox(width: size.width*0.087,),Text(
                student['Where'],
                style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),
              ),]),
        Row(children: [Text("Phone",style: TextStyle(fontSize: 17, fontWeight:FontWeight.bold),), SizedBox(width: size.width*0.13,),Text(
                student['Phone'],
                style: TextStyle(fontSize: 17,fontWeight:FontWeight.bold),
              ),IconButton(onPressed: (){
                setState(() {
show1=!show1;
                });
        }, icon: Icon(Icons.edit))]),

      Visibility(visible: show1,
        child:Form(key: formGlobalKey,
          child:
        TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ], // Only numbers can be entered
          validator: (value){
            if(value!.isEmpty){
              return null;
            }
            else if(value.length<10){
              return 'no can not be less than 10 digits';
            }
            else if(value.length>10){
              return 'no can not be more than 10 digits';
            }
            else{
              return null;
            }
          },
          controller: contoller1,
          decoration: InputDecoration(
              suffixIcon: IconButton(onPressed: ()async{
                setState(()  {
                  if (formGlobalKey.currentState!.validate()) {
                    formGlobalKey.currentState!.save();
                    m=user!.email!+contoller1.text;
show1=!show1;
if(contoller1.text!=""){
update(contoller1.text);}
                  }});
                if(contoller1.text!=""){
                await UserSimplePreferences1.setusername1(m);}




              }, icon:Icon(Icons.check),
              ),
              hintText: "Enter your Mobile no to generate Your QR Code"
          ),
        ),),),

]))
      ,

    );
  }
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255,245,189,159),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading:Container(
          width: size.width*0.2,
          height: size.width*0.2,
          child:
          FutureBuilder(
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

        title: Text("Rajkiya Engineering College Bijnor", style: TextStyle(
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
            color: Colors.white
        ),),),
      body:show==false?Container(margin: EdgeInsets.only(left: 15,right: 15),

                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Fill Your Mobile Number To Generate QR Code And See Your Details",style:  TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black
        ),),Shimmer.fromColors(child:Icon(Icons.arrow_back,size: 60,),
              direction:ShimmerDirection.rtl,
              baseColor: Colors.red,
             loop: 1000,
              period: Duration(seconds: 0),
              highlightColor: Colors.white),
          ],

        )
      ):
      Center(child:
      Container(
        margin: EdgeInsets.only(top: 180,bottom: 50,left: 20,right: 20),
        child: FirebaseAnimatedList(
          padding: EdgeInsets.all(0.0),

          query: dbRef,

          itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {

            Map student = snapshot.value as Map;
            student['key'] = snapshot.key;
            return listItem(student: student);

          },
        ),),)
    );
  }

  _createdb1(){
    int c=0,d=0;
    setState(() {
      Year='$s'.contains("210")==true?"First Year":'$s'.contains("170")==true?"Second Year":'$s'.contains("190")==true?"Third Year":"Fourth Year";
      Name='$s'.substring(0,'$s'.indexOf("."));
      int len='$s'.length;

      for(int i=0;i<len;i++){
        if(c!=0&&d==0){
          d=i;  break;
        }
        if('$s'![i]=='.'&&c==0){
          c=i;
        }

      }
      Branch='$s'.substring(c+1,d+2).toUpperCase();

      g='$s'.substring(d+3,d+8);

    });


  }
  update(String k){

    reference.child("Students").child("$Name$g$Branch").update({"Phone":"$k"});

  }
}
class Recieve extends StatefulWidget {
  const Recieve({Key? key}) : super(key: key);

  @override
  State<Recieve> createState() => _RecieveState();
}

class _RecieveState extends State<Recieve> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
