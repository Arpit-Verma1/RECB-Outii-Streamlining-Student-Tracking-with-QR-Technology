import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outii/Core/Widgets/studentProfileCard.dart';
import 'package:outii/Database/Server_and%20Functions.dart';
import 'package:outii/Utils/Shared_Preferences.dart';
import 'package:outii/Utils/constant.dart';

import '../../../Admin/View/Widget/studentListTile.dart';
import '../../../Core/Widgets/customSnackBar.dart';

TextStyle textStyle =
    TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black);

class user_data extends StatefulWidget {
  const user_data({Key? key}) : super(key: key);

  @override
  State<user_data> createState() => _user_dataState();
}

class _user_dataState extends State<user_data> {
  String User = UserSimplePreferences.getusername() ?? "";
  String Branch = "";
  String phone = "";
  String Name = "";
  String? imageUrl;
  String roll_no_and_year = "";
  bool change_phone = false;
  bool show_User_id_card = false;
  Query dbRef = FirebaseDatabase.instance.ref();
  final user = FirebaseAuth.instance.currentUser;
  final controller = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (User != "") {
      setState(() {
        show_User_id_card = true;
      });
      createdb();
    }
  }

  @override
  Widget listItem({required Map student}) {
    String branch = Branch == 'IT'
        ? "Information Technology"
        : Branch == "EE"
            ? "Electrical Enginnering"
            : "Civil Engineering";
    return Visibility(
        visible: student['Name'] == "$Name$roll_no_and_year$Branch",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StudentListTile(
              text1: "Name",
              text2: "${Name.toUpperCase()}",
            ),
            StudentListTile(text1: "Branch", text2: "$branch"),
            StudentListTile(
              text1: "Timein",
              text2: student['Timein'],
            ),
            StudentListTile(
              text1: "Timeout",
              text2: student['Timeout'],
            ),
            StudentListTile(
              text1: "Purpose",
              text2: student['Where'],
            ),
            Row(children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: StudentListTile(
                    text1: "Phone",
                    text2: student['Phone'],
                  )),
              IconButton(
                  onPressed: () {
                    setState(() {
                      change_phone = !change_phone;
                    });
                  },
                  icon: Icon(Icons.edit)),
            ])
          ],
        ));
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return show_User_id_card == false
        ? Container(
            color: Color.fromARGB(255, 255, 221, 210),
            child: Center(
              child: Text(
                "Fill Your Phone Number To Generate\n QR Code And See Your Details",
                style: bigLobster,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Container(
            color: Color.fromARGB(255, 255, 221, 210),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: EdgeInsets.all(7),
                padding:
                    EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    color: Colors.white38,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                height: size.height * 0.3,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(children: [
                        StudentProfileCard(
                          id: "$Name$roll_no_and_year$Branch",
                          height: size.height * 0.2,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black12),
                            onPressed: () async {
                              await uploadImage(
                                  "$Name$roll_no_and_year$Branch");
                              successSnackbar("Done", "Successfully Upload",
                                   context);
                              setState(() {});
                            },
                            child: Text(
                              "Upload Picture",
                              style: textStyle.copyWith(
                                  fontSize: 10, color: Colors.black),
                            ))
                      ]),
                      Container(
                        width: size.width * 0.6,
                        height: size.height * 0.3,
                        child: FirebaseAnimatedList(
                          query: dbRef.ref.child('Students'),
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            Map student = snapshot.value as Map;
                            student['key'] = snapshot.key;
                            return listItem(student: student);
                          },
                        ),
                      ),
                    ]),
              ),
            ]),
          );
  }

  createdb() {
    int c = 0, d = 0;
    setState(() {
      Name = '$User'.substring(0, '$User'.indexOf("."));
      int len = '$User'.length;
      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('$User'[i] == '.' && c == 0) {
          c = i;
        }
      }
      Branch = '$User'.substring(c + 1, d + 2).toUpperCase();
      roll_no_and_year = '$User'.substring(d + 3, d + 8);
      phone = '${User}'.substring(d + 19, d + 29);
    });
  }

  update_phone_no(String k) {
    dbRef.ref
        .child("Students")
        .child("$Name$roll_no_and_year$Branch")
        .update({"Phone": "$k"});
  }
}
