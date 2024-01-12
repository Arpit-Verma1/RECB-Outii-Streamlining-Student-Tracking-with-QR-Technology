import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Core/Widgets/drawerHeader.dart';
import 'package:outii/Core/Widgets/socialMediaButton.dart';
import 'package:outii/Utils/Shared_Preferences.dart';
import 'package:outii/Utils/constant.dart';
import 'package:outii/routes/routes_name.dart';
import 'package:provider/provider.dart';
import 'Authentication/View/Widgets/authButton.dart';
import 'Authentication/ViewModel/authViewModel.dart';
import 'Students/View/Screens/Qr_Generate.dart';
import 'Admin/View/Screens/Qr_Scan.dart';
import 'Admin/View/Screens/Students_Data.dart';
import 'Students/View/Screens/User_Data.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List Admin_UI_page_list = [qrScan(), Studentsdata()];
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
    ),
  ];

  @override
  Widget build(BuildContext context) {
    bool isAdminLogin = context.read<AuthenticationProvider>().isAdminLogin;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.black)),
        child: CurvedNavigationBar(
          color: purple.withOpacity(0.5),
          buttonBackgroundColor: purple.withOpacity(0.6),
          backgroundColor: lightPeach,
          height: 55,
          animationDuration: Duration(milliseconds: 800),
          items: isAdminLogin == false ? User_Icons : Guard_UI_Icons,
          onTap: (pageindex) => setState(() {
            this.current_nav_tab = pageindex;
          }),
        ),
      ),
      appBar: AppBar(
        backgroundColor: purple.withOpacity(0.5),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Rajkiya Engineering College Bijnor", style: regLobster),
      ),
      drawer: Drawer(
          backgroundColor: silverGrey,
          width: size.width * 0.7,
          child: Column(children: [
            drawerHeader(),
            SizedBox(
              height: size.height * 0.1,
            ),
            if (isAdminLogin)
              SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.05,
                child: authButton(
                  function: () {
                    Navigator.pushNamed(context, RouteName.add_user);
                  },
                  buttonName: "Add User",
                  fontSize: 18,
                ),
              ),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
                width: size.width * 0.4,
                height: size.height * 0.05,
                child: authButton(
                  function: () =>
                      context.read<AuthenticationProvider>().logout(context),
                  buttonName: 'Logout',
                  fontSize: 20,
                )),
            SizedBox(
              height: size.height * 0.03,
            ),
            SocialMediaButtons(),
          ])),
      body: isAdminLogin == false
          ? User_UI_page_list[current_nav_tab]
          : Admin_UI_page_list[current_nav_tab],
    );
  }
}
