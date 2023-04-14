import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Userjson.dart';
import 'package:fl_chart/fl_chart.dart';
import '../Bar_Chart_View.dart';
import 'package:intl/intl.dart';

TextStyle textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
List<BarChartGroupData> get barGroups => barGroups1;
List<int> value = List<int>.filled(31, 0, growable: false);
List<String> dates = [];
class Student_previous_data extends StatefulWidget {
  const Student_previous_data({Key? key, required this.Collection, required this.Phone_No})
      : super(key: key);
  final String Collection;
  final String Phone_No;
  @override
  State<Student_previous_data> createState() => _Student_previous_dataState();
}

class _Student_previous_dataState extends State<Student_previous_data>
    with TickerProviderStateMixin {
  @override
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;
  bool chart_view = false;
  void initState() {
    super.initState();
    readuser(widget.Collection);
    _fadeController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    repeatOnce();
    Timer(Duration(seconds: 4), () {
      setState(() {});
    });
  }

  void repeatOnce() async {
    await _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    for (int i = 0; i < 31; i++) value[i] = 0;
    dates.clear();
    super.dispose();
  }

  Widget build(BuildContext context) {
    String dt = DateFormat(
      "MMM",
    ).format(DateTime.now());
    Size size = MediaQuery.of(context).size;
    Widget buildsuser(User user) {
      for (int i = 1; i < 32; i++) {
        String zero="";
        if(i<10){
          zero="0";
        }
        if (user.Timein!.contains("$zero$i-$dt")) {
          if (dates.contains(user.Timein) == true) {
            value[i - 1]--;
            dates.remove(user.Timein!);
          } else {
            value[i - 1]++;
            dates.add(user.Timein!);
          }
        }
      }
      return FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            border: Border.all(color: Colors.black),
            color: Color.fromARGB(255, 198, 216, 255),
          ),
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${user.Timein!.substring(0, 6)}',
                  style: textStyle.copyWith(color: Colors.black),
                ),
                Text(
                  '${user.Timein!.substring(
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
                  '${user.Timeout!.substring(0, 6)}',
                  style: textStyle.copyWith(color: Colors.black),
                ),
                Text(
                  '${user.Timeout!.substring(
                    6,
                  )}',
                  style: textStyle.copyWith(color: Colors.black),
                ),
              ],
            ),
            title: Text(
              '${user.Where}',
              style: textStyle.copyWith(color: Colors.black),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 221, 210),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 170, 142, 200),
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  chart_view = !chart_view;
                });
                setState(() {});
              },
              icon: Icon(chart_view ? Icons.account_circle : Icons.bar_chart))
        ],
        title: Text(
          "Rajkiya Engineering College Bijnor",
          style: GoogleFonts.cookie(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        Visibility(
          visible: !chart_view,
          child: Column(children: [
            Text(
              "${widget.Collection.substring(0, widget.Collection.length - 7)} "
                      .toUpperCase() +
                  " Profile",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
            ),
            Container(
              width: size.width * 0.8,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white38,
                  border: Border.all(),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              height: size.height * 0.21,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Profilephoto(widget.Collection, size.height * 0.17),
                    Container(
                        width: size.width * 0.45,
                        child: Column(
                          children: [
                            listtile(
                              "Name",
                              widget.Collection.substring(
                                      0, widget.Collection.length - 7)
                                  .toUpperCase(),
                            ),
                            listtile(
                              "Branch",
                              widget.Collection.substring(
                                widget.Collection.length - 2,
                              ).toUpperCase(),
                            ),
                            listtile(
                              "Roll No.",
                              widget.Collection.substring(
                                      widget.Collection.length - 4,
                                      widget.Collection.length - 2)
                                  .toUpperCase(),
                            ),
                            listtile(
                              "Phone No.",
                             widget.Phone_No
                                  .toUpperCase(),
                            )
                          ],
                        )),
                  ]),
            ),
          ]),
        ),
        Visibility(
          visible: chart_view,
          child: Column(children: [
            Text(
              DateFormat(
                    "yyyy",
                  ).format(DateTime.now()) +
                  " " +
                  DateFormat(
                    "MMMM",
                  ).format(DateTime.now()) +
                  " Month Frequency Chart",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                  width: size.width * 2,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  padding: EdgeInsets.only(top: 12, right: 12),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 229, 228, 226),
                      border: Border.all(),
                     ),
                  height: size.height * 0.2,
                  child: Bar_Chart()),
            ),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Time-In",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
            ),
            Text(
              "Purpose",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 22),
            ),
            Text(
              "Time-Out",
              style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
            )
          ],
        ),
        Container(
          height: size.height * 0.57,
          child: StreamBuilder<List<User>>(
            stream: readuser(widget.Collection),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                    "Somrthing  Went Wrong ${snapshot.error.toString()}");
              } else if (snapshot.hasData) {
                final users = snapshot.data!;
                return ListView(
                  scrollDirection: Axis.vertical,
                  children: users.map(buildsuser).toList(),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.black),
                );
              }
            },
          ),
        ),
      ]),
    );
  }

  Stream<List<User>> readuser(String Collection) => FirebaseFirestore.instance
      .collection(Collection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
