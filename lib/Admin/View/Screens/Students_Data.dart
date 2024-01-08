import 'package:avatar_glow/avatar_glow.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:outii/Admin/View/Screens/student_previous_data.dart';
import '../../../Utils/Constant.dart';
import '../../../speechapi.dart';

const TextStyle studentdatastyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
);


class Studentsdata extends StatefulWidget {
  const Studentsdata({Key? key}) : super(key: key);

  @override
  State<Studentsdata> createState() => _StudentsdataState();
}

class _StudentsdataState extends State<Studentsdata>  with TickerProviderStateMixin {
  Query dbRef = FirebaseDatabase.instance.ref().child('Students');
  TextEditingController Controller = TextEditingController();
  bool islistening = false;
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    repeatOnce();

  }

  void repeatOnce() async {
    await _fadeController.forward();
  }
  Widget listItem({required Map student}) {
    return Visibility(
        visible: Controller.text == ""
            ? true
            : Controller.text.toLowerCase() == "out" &&
                    student['Timeout'] == "---------------"
                ? true
                : Controller.text.toLowerCase() == "in" &&
                        student['Timeout'] != "---------------"
                    ? true
                    : student['Name'].toString().contains(Controller.text),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RouteName.Student_previous_data,
                arguments: {"collection_id": student['Name'],"Phone_No":student['Phone']});
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              border: Border.all(color: Colors.black),
              color: "${student['Timeout'].toString()}" == "---------------"
                  ? Color.fromARGB(255, 236, 145, 146)
                  : Color.fromARGB(255, 198, 216, 255),
            ),
            margin: EdgeInsets.only(top: 10, right: 5, left: 5),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${student['Timein'].substring(0, 6)}',
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                    Text(
                      '${student['Timein'].substring(
                        6,
                      )}',
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${student['Timeout'].substring(0, 6)}',
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                    Text(
                      '${student['Timeout'].substring(
                        6,
                      )}',
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${student['Name'].substring(0, "${student['Name']}".length - 7)}"
                          .toUpperCase(),
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Branch: ${student['Name'].substring(
                        "${student['Name']}".length - 2,
                      )}",
                      style: textStyle.copyWith(color: Colors.black),
                    )
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Roll no: ${student['Name'].substring("${student['Name']}".length - 4, "${student['Name']}".length - 2)}",
                          style: textStyle.copyWith(color: Colors.black),
                        ),
                        Text(
                          "Batch: 20${student['Name'].substring("${student['Name']}".length - 7, "${student['Name']}".length - 5)}",
                          style: textStyle.copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                    Text(
                      "Purpose: ${student['Where']}",
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

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
            controller: Controller,
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
                  animate: islistening,
                  endRadius: 30,
                  glowColor: Colors.black,
                  child: IconButton(
                    onPressed: () {
                      togglerecording();
                    },
                    icon: Icon(islistening ? Icons.mic : Icons.mic_none),
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
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
            ),
            Text(
              "Student Details",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 22),
            ),
            Text(
              "Time-Out",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
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
            query: dbRef,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              Map student = snapshot.value as Map;
              student['key'] = snapshot.key;
              return listItem(student: student);
            },
          ),
        ),
      ]),
    );
  }

  Future togglerecording() => Speechapi.togglerecording(
      onresult: (text) => setState(
            () => this.Controller.text = text,
          ),
      onlistening: (islistening) {
        setState(() => this.islistening = islistening);
      });
}
