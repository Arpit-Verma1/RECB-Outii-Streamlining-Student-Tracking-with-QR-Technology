import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Userjson.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../Bar_Chart.dart';
import 'package:intl/intl.dart';

TextStyle textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
List<BarChartGroupData> get barGroups => barGroups1;
List<int> value = List<int>.filled(31, 0, growable: false);
List<String> dates = [];

class Student_previous_data extends StatefulWidget {
  const Student_previous_data(
      {Key? key, required this.Collection, required this.Phone_No})
      : super(key: key);
  final String Collection;
  final String Phone_No;
  @override
  State<Student_previous_data> createState() => _Student_previous_dataState();
}

class _Student_previous_dataState extends State<Student_previous_data>
    with TickerProviderStateMixin {
  @override
  String dropdownvalue = DateFormat(
    "MMM",
  ).format(DateTime.now()).toString();
  bool recollect_bardata = true;
  bool change_bardata = true;
  bool chart_view = true;
  // List of items in our dropdown menu
  var items = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

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
    Size size = MediaQuery.of(context).size;
    Widget build_list(User user) {
      String dt = dropdownvalue;
      char_frequency_counter(user, dt);
      return user.Timein!.contains(dt) == true
          ? FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
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
                        '${user.Timeout?.substring(0, 6)}',
                        style: textStyle.copyWith(color: Colors.black),
                      ),
                      Text(
                        '${user.Timeout?.substring(
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
            )
          : Container();
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
              icon: chart_view
                  ? Icon(Icons.account_circle)
                  : Row(
                      children: [
                        Icon(Icons.bar_chart),
                      ],
                    ))
        ],
        titleSpacing: 0,
        title: Text(
          "Rajkiya Engineering College Bijnor",
          style: GoogleFonts.cookie(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Visibility(
          visible: !chart_view,
          child: Column(children: [
            Row(
              children: [
                Text(
                  DateFormat(
                        "yyyy",
                      ).format(DateTime.now()) +
                      " " +
                      dropdownvalue +
                      " Month Frequency Chart",
                  style: GoogleFonts.lobster(color: Colors.black, fontSize: 20),
                ),
                DropdownButton(
                  menuMaxHeight: 300,
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(
                        items,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                      for (int i = 0; i < 31; i++) value[i] = 0;
                      dates.clear();
                      recollect_bardata = !recollect_bardata;
                      change_bardata = !change_bardata;
                      Future.delayed(Duration(seconds: 1), () {
                        recollect_bardata = !recollect_bardata;
                        setState(() {
                          change_bardata = !change_bardata;
                        });
                      });
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          change_bardata = !change_bardata;
                          change_bardata = !change_bardata;
                        });
                      });
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Visibility(
                visible: change_bardata,
                replacement: Container(
                    height: size.height * 0.2,
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    ))),
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
            ),
          ]),
          replacement: Column(children: [
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
                              widget.Phone_No.toUpperCase(),
                            )
                          ],
                        )),
                  ]),
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
          height: size.height * 0.56,
          child: Visibility(
            visible: recollect_bardata,
            replacement:
                Center(child: CircularProgressIndicator(color: Colors.black)),
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
                    children: users.map(build_list).toList(),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  );
                }
              },
            ),
          ),
        )
      ]),
    );
  }

  void char_frequency_counter(User user, String dt) {
    if (recollect_bardata) {
      for (int i = 1; i < 32; i++) {
        String zero = "";
        if (i < 10) {
          zero = "0";
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
    }
  }

  Stream<List<User>> readuser(String Collection) => FirebaseFirestore.instance
      .collection(Collection)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
