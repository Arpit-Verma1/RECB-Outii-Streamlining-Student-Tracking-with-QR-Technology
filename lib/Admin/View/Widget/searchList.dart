import 'package:flutter/material.dart';
import 'package:outii/Admin/Model/realtimeDBStudentModel.dart';
import 'package:outii/Admin/ViewModel/adminViewModel.dart';
import 'package:provider/provider.dart';

import '../../../Routes/routes_name.dart';
import '../../../Students/View/Screens/User_Data.dart';

class SearchList extends StatefulWidget {
  final RealtimeDBStudentModel student;

  const SearchList({super.key, required this.student});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList>
    with TickerProviderStateMixin{
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AdminProvider>(
      builder: (context, adminProvider, child) => Visibility(
          visible: adminProvider.Controller.text == ""
              ? true
              : adminProvider.Controller.text.toLowerCase() == "out" &&
                      widget.student.timeout == "---------------"
                  ? true
                  : adminProvider.Controller.text.toLowerCase() == "in" &&
                          widget.student.timeout != "---------------"
                      ? true
                      : widget.student.name
                          .toString()
                          .contains(adminProvider.Controller.text),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteName.Student_previous_data,
                  arguments: {
                    "collection_id": widget.student.name,
                    "Phone_No": widget.student.phone,
                  });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                border: Border.all(color: Colors.black),
                color: widget.student.timeout == "---------------"
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
                        '${widget.student.timein.substring(0, 6)}',
                        style: textStyle.copyWith(color: Colors.black),
                      ),
                      Text(
                        '${widget.student.timein.substring(
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
                        '${widget.student.timeout.substring(0, 6)}',
                        style: textStyle.copyWith(color: Colors.black),
                      ),
                      Text(
                        '${widget.student.timeout.substring(
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
                        "${widget.student.name}"
                            .toUpperCase(),
                        style: textStyle.copyWith(color: Colors.black),
                      ),
                      Text(
                        "Branch: ${widget.student.branch}",
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
                            "Roll no: ${widget.student.rollno}",
                            style: textStyle.copyWith(color: Colors.black),
                          ),
                          Text(
                            "Batch: 20${widget.student.batch}",
                            style: textStyle.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                      Text(
                        "Purpose: ${widget.student.where}",
                        style: textStyle.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
