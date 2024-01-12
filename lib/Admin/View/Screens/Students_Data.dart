import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:outii/Admin/Model/realtimeDBStudentModel.dart';
import 'package:outii/Admin/View/Widget/searchList.dart';
import 'package:outii/Utils/constant.dart';
import 'package:outii/Admin/ViewModel/adminViewModel.dart';
import 'package:provider/provider.dart';

class Studentsdata extends StatefulWidget {
  const Studentsdata({Key? key}) : super(key: key);

  @override
  State<Studentsdata> createState() => _StudentsdataState();
}

class _StudentsdataState extends State<Studentsdata> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 5, left: 3, right: 3),
      color: Color.fromARGB(255, 255, 221, 210),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
          child: TextField(
            onChanged: (value) {
              setState(() {});
            },
            controller: context.watch<AdminProvider>().Controller,
            decoration: InputDecoration(
                enabledBorder: Textfieldborder,
                focusedBorder: Textfieldborder,
                contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintText: 'Search Students',
                suffixIcon: AvatarGlow(
                  animate: context.watch<AdminProvider>().isListening,
                  endRadius: 30,
                  glowColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      context.read<AdminProvider>().togglerecording();
                    },
                    icon: Icon(context.watch<AdminProvider>().isListening
                        ? Icons.mic
                        : Icons.mic_none),
                    color: Colors.black,
                  ),
                )),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Time-In",
              style: regLobster,
            ),
            Text(
              "Student Details",
              style: regLobster,
            ),
            Text(
              "Time-Out",
              style: regLobster,
            )
          ],
        ),
        Container(
          height: size.height * 0.65,
          child: FirebaseAnimatedList(
            defaultChild: Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
            query: context.read<AdminProvider>().dbref.child('Students'),
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map student =
                  snapshot.value as Map;
              student['key'] = snapshot.key!;
              RealtimeDBStudentModel studentModel =
                  RealtimeDBStudentModel.fromJson(student);
              return SearchList(student: studentModel);
            },
          ),
        ),
      ]),
    );
  }
}
