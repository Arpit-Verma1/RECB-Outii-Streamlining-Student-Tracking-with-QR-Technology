import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Utils/Constant.dart';

class add_user extends StatefulWidget {
  const add_user({Key? key}) : super(key: key);

  @override
  State<add_user> createState() => _add_userState();
}

class _add_userState extends State<add_user> {
  TextEditingController controller = TextEditingController();
  late DatabaseReference _dbref;
  String text = "";

  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.ref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 221, 210),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 170, 142, 200),
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Rajkiya Engineering College Bijnor",
            style: GoogleFonts.cookie(
                wordSpacing: 2,
                fontSize: 20,
                letterSpacing: 1,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: new InputDecoration(
                  enabledBorder: Textfieldborder,
                  focusedBorder: Textfieldborder,
                  suffixIcon: IconButton(
                      onPressed: () => _createdb(), icon: Icon(Icons.add)),
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                  filled: false,
                  hintText: 'Add User Email Id',
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              ElevatedButton(
                  onPressed: () {
                    remove();
                  },
                  child: Text('remove')),
            ],
          ),
        ));
  }

  _createdb() {
    _dbref.child("User").update({
      controller.text.substring(0, controller.text.indexOf('.')):
          controller.text
    });
  }

  remove() {
    _dbref
        .child("User")
        .child(controller.text.substring(0, controller.text.indexOf('.')))
        .remove();
  }
}
