import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class add extends StatefulWidget {
  const add({Key? key}) : super(key: key);

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
 TextEditingController controller=TextEditingController();
 late DatabaseReference _dbref;
 String text="";

 void initState(){
   super.initState();
   _dbref=FirebaseDatabase.instance.ref();

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255,245,189,159),
      appBar: AppBar(

      ),
      body:     Container(width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 30,right: 30,top: 20),child:
      Column(crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       TextField(
            controller: controller,
            style: TextStyle(color: Colors.black),
            decoration: new InputDecoration(
              enabledBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(15),borderSide: BorderSide(color:Colors.black,width: 2)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(
                    color: Colors.black
                    ,width: 2
                ),
              ),
              prefix: Text("    "),suffixIcon: IconButton(onPressed:()=> _createdb() , icon:Icon(Icons.add)),
              contentPadding:
              EdgeInsets.only(top: 10,bottom: 10),
              filled: false,
              hintText: 'Add User Email Id',
              hintStyle: TextStyle(color: Colors.black),
            ),
          ),
              SizedBox(width: MediaQuery.of(context).size.width*0.2,)
              ,ElevatedButton(onPressed: (){
                remove();
              }, child: Text('remove')),





        ],
      ),)
    );
  }
 _createdb(){
   _dbref.child("User").update({controller.text.substring(
       0, controller.text.indexOf('.')):controller.text});
 }
 remove(){
   _dbref.child("User").child(controller.text.substring(
       0, controller.text.indexOf('.'))).remove();
 }



}
