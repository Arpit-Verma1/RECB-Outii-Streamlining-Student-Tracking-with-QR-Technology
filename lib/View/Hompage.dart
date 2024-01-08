import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Shared_Preferences.dart';
import 'package:outii/routes/rotes_name.dart';
import '../Utils/Constant.dart';
import '../Students/View/Screens/Qr_Generate.dart';
import '../Admin/View/Screens/Student_Qr_Scan.dart';
import '../Admin/View/Screens/Students_Data.dart';
import '../Students/View/Screens/User_Data.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri faceboook_url = Uri.parse('https://www.facebook.com/recbup/');
final Uri twitter_url = Uri.parse('https://twitter.com/recb_up');
final Uri linkedin_url = Uri.parse(
    'https://www.linkedin.com/company/rajkiya-engineering-college-bijnor/');
final Uri instagram_url = Uri.parse('https://www.instagram.com/recbup/');

class sample extends StatefulWidget {
  const sample({Key? key, this.User_UI, }) : super(key: key);
  final User_UI;
  @override
  State<sample> createState() => _sampleState();
}
class _sampleState extends State<sample> {
  List Guard_UI_page_list = [qrscan(), Studentsdata()];
  List User_UI_page_list = [Qr_Generate(), user_data()];
  int current_nav_tab = 0;
  final Guard_UI_Icons = <Widget>[
    Icon(Icons.qr_code_scanner_rounded),
    Icon(Icons.search),
  ];
  final User_Icons = <Widget>[
    Icon(Icons.qr_code, color: Colors.black87),
    Icon(
      Icons.account_circle,
      color: Colors.black87,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.black)),
        child: CurvedNavigationBar(
          color: Color.fromARGB(255, 170, 142, 200),
          buttonBackgroundColor: Color.fromARGB(255, 170, 142, 200),
          backgroundColor: Color.fromARGB(255, 255, 221, 210),
          height: 55,
        animationDuration:Duration(milliseconds: 800) ,
          items: widget.User_UI == false ? User_Icons : Guard_UI_Icons,
          onTap: (pageindex) => setState(() {
           this.current_nav_tab = pageindex;
          }),
        ),
      ),
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
      drawer: Drawer(
          backgroundColor:Color.fromARGB(255, 233, 230, 230),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
              children: [
                Container(
                  height: size.height*0.25,
                  width: double.infinity,
                  child: Stack(children: [
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(.6),
                                  BlendMode.darken),
                              fit: BoxFit.cover,
                              image: AssetImage('assets/recb.jpg')),
                          color: Colors.grey.shade900,
                          boxShadow: [BoxShadow(blurRadius: 15)],
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(150))),
                      padding: EdgeInsets.all(10),
                      width: double.infinity,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 50,
                        child: Container(
                          width: size.width * 0.3,
                          height: size.width * 0.3,
                          child: CircleAvatar(
                            backgroundImage:
                            AssetImage('assets/logo.png'),
                          ),
                        )),
                  ]),
                ),
                SizedBox(height: size.height*0.1,),
                Visibility(
                  visible: widget.User_UI,
                  child: SizedBox(
                    width: size.width * 0.5,
                    height: size.height * 0.05,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.logout),
                      label: Text("Add User",
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      style: buttonstyle.copyWith(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.grey.shade900,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RouteName.add_user);
                      },
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.02
                  ,),
                SizedBox(
                  width: size.width * 0.5,
                  height: size.height * 0.05,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.logout),
                    label: Text("Logout",
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    style: buttonstyle.copyWith(
                      backgroundColor: MaterialStatePropertyAll(
                        Colors.grey.shade900,
                      ),
                    ),
                    onPressed: () async {
                      await UserSimplePreferences.clear();
                      FirebaseAuth.instance.signOut().then((value) =>
                          Navigator.pushReplacementNamed(
                              context, RouteName.My_HomePage));
                      FirebaseAuth.instance.signOut();
                    },
                  ),
                ),
                SizedBox(height: size.height*0.03,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(faceboook_url)) {
                            await launchUrl(faceboook_url);
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          size: 40.0,
                          color: Colors.blue,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(twitter_url)) {
                            await launchUrl(twitter_url);
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          size: 40.0,
                          color: Colors.blue,
                        )),
                    IconButton(
                      onPressed: () async {
                        if (await canLaunchUrl(linkedin_url)) {
                          await launchUrl(linkedin_url);
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.linkedin,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (await canLaunchUrl(instagram_url)) {
                            await launchUrl(instagram_url);
                          }
                        },
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          size: 40.0,
                          color: Colors.purpleAccent,
                        ))
                  ],
                )
              ])),
      body: widget.User_UI == false
          ? User_UI_page_list[current_nav_tab]
          : Guard_UI_page_list[current_nav_tab],
    );
  }

}
