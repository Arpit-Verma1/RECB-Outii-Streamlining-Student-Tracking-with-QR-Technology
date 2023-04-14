import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:outii/Shared_Preferences.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

List destination_list = ["Market", "Jannat", "Home", "Bank", "Anything Else"];

class Qr_Generate extends StatefulWidget {
  const Qr_Generate({Key? key}) : super(key: key);
  @override
  State<Qr_Generate> createState() => _Qr_GenerateState();
}
class _Qr_GenerateState extends State<Qr_Generate> {
  final user = FirebaseAuth.instance.currentUser;
  DatabaseReference _dbref = FirebaseDatabase.instance.ref();
  bool QR_Show = false;
  bool custom_destinatinaton_check = false;
  String Branch = "";
  String Name = "";
  String roll_no_and_year = "";
  String User_id = "";
  String destination = "";
  String phone = "";
  final phone_controller = TextEditingController();
  final destination_controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    User_id = UserSimplePreferences.getusername() ?? "";
    // FlutterWindowManager.addFlags(
    //   FlutterWindowManager.FLAG_SECURE,
    // );
  }
  int selected_destination = -1;
  @override
  void dispose() {
    phone_controller.dispose();
    super.dispose();
  }
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Form(
        key: formGlobalKey,
        child: Container(
          color: Color.fromARGB(255, 255,221,210),
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selected_destination = index;
                              destination = destination_list[index];
                              custom_destinatinaton_check = index == 4
                                  ? !custom_destinatinaton_check
                                  : false;
                            });
                          },
                          child: Text(destination_list[index],style: TextStyle(fontWeight: FontWeight.bold),),
                          style: ElevatedButton.styleFrom(
                              primary: selected_destination == index
                                  ? Color.fromARGB(255, 64, 206, 104)
                                  :  Color.fromARGB(255, 121, 91, 245),),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: 5)),
              Visibility(
                visible: custom_destinatinaton_check,
                child: TextField(
                  controller: destination_controller,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          setState(() {
                            if (destination_controller.text.length > 20) {
                              final snackbar = SnackBar(
                                  content: Text(
                                      "Enter the text within 20 letter"));
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(snackbar);
                            } else {
                              destination = destination_controller.text;
                            }
                            custom_destinatinaton_check =
                            !custom_destinatinaton_check;
                          });
                        },
                        icon: Icon(Icons.check),
                      ),
                      hintText: "Enter destination where you are going."),
                ),
              ),
              Visibility(
                visible:User_id!="",
                child: Expanded(
                  flex: 15,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      child: PrettyQr(
                        elementColor: Colors.black,
                        image: AssetImage('assets/logo.png'),
                        typeNumber: 4,
                        size: 200,
                        data: User_id + destination,
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        roundEdges: true,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: User_id=="",
                child:Expanded(
                    flex: 15,
                    child: Center(child:
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Phone no can not be empty';
                    } else if (value.length < 10) {
                      return 'Phone no can not be less than 10 digits';
                    } else if (value.length > 10) {
                      return 'Phone no can not be more than 10 digits';
                    } else {
                      return null;
                    }
                  },
                  controller: phone_controller,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          setState(() {
                            if (formGlobalKey.currentState!.validate()) {
                              formGlobalKey.currentState!.save();
                              User_id = user!.email! +
                                  phone_controller.text +
                                  destination;
                              createdb();
                              QR_Show = !QR_Show;
                            }
                          });
                          await UserSimplePreferences.setusername(User_id);
                        },
                        icon: Icon(Icons.check),
                      ),
                      hintText:
                      "Enter your Mobile no to generate Your QR Code"),
                ),)),
              ),

            ],
          ),
        ));
  }

  createdb() {
    int c = 0, d = 0;
    setState(() {
      Name = '${User_id}'.substring(0, '${User_id}'.indexOf("."));
      int len = '${User_id}'.length;
      for (int i = 0; i < len; i++) {
        if (c != 0 && d == 0) {
          d = i;
          break;
        }
        if ('${User_id}'[i] == '.' && c == 0) {
          c = i;
        }
      }
      Branch = '${User_id}'.substring(c + 1, d + 2).toUpperCase();
      roll_no_and_year = '${User_id}'.substring(d + 3, d + 8);
      phone = '${User_id}'.substring(d + 19, d + 29);
    });
    _dbref.child('Students').child("$Name$roll_no_and_year$Branch").update({
      'Name': "$Name$roll_no_and_year$Branch",
      'Timein': "---------------",
      'Timeout': "---------------",
      'Phone': "$phone",
      'Where': "----------------"
    });
  }
}
