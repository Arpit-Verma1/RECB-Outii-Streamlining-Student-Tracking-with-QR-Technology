import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'speechapi.dart';
import 'package:intl/intl.dart';

const TextStyle studentdatastyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);
OutlineInputBorder Textfieldborder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15.0),
  borderSide: BorderSide(color: Colors.white, width: 2),
);

class Studentsdata extends StatefulWidget {
  const Studentsdata({Key? key}) : super(key: key);

  @override
  State<Studentsdata> createState() => _StudentsdataState();
}

class _StudentsdataState extends State<Studentsdata> {
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
          padding: const EdgeInsets.all(7),
          height: size.height * 0.05,
          decoration: BoxDecoration(
              color: "${student['Timeout'].toString()}" == "0"
                  ? Colors.red
                  : Colors.green,
              border: Border(bottom: BorderSide(color: Colors.black))),
          child: ListView(
            itemExtent: 110,
            scrollDirection: Axis.horizontal,
            children: [
              Text(student['Name'], style: studentdatastyle),
              Text(student['Timein'], style: studentdatastyle),
              Text(student['Timeout'], style: studentdatastyle),
              Text(student['Where'], style: studentdatastyle),
              Text(student['Phone'], style: studentdatastyle),
            ],
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
            child: RiveAnimation.asset(
              'assets/recb_outii.riv',
            ),
          ),
          title: Center(
            child: Text(
              "Students Data",
              style: GoogleFonts.pacifico(fontSize: 20),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.13),
            child: Container(
                height: size.height * 0.14,
                width: size.width,
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.7,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {});
                              },
                              controller: controller1,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                enabledBorder: Textfieldborder,
                                focusedBorder: Textfieldborder,
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
                            ),
                          ),
                          AvatarGlow(
                            animate: islistening,
                            endRadius: 30,
                            glowColor: Colors.white,
                            showTwoGlows: true,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
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
                            ),
                          ),
                        ]),
                    Container(
                      height: size.height * 0.042,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        itemExtent: 100,
                        children: [
                          Text("Name",
                              style: GoogleFonts.pacifico(
                                  fontSize: 18, color: Colors.white)),
                          Text("Timein",
                              style: GoogleFonts.pacifico(
                                  fontSize: 18, color: Colors.white)),
                          Text("Timeout",
                              style: GoogleFonts.pacifico(
                                  fontSize: 18, color: Colors.white)),
                          Text("Purpose",
                              style: GoogleFonts.pacifico(
                                  fontSize: 18, color: Colors.white)),
                          Text("Phone",
                              style: GoogleFonts.pacifico(
                                  fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                )),
          ),
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
