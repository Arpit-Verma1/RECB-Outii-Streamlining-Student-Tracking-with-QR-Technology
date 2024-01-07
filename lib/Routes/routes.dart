import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outii/Authentication/View/Screens/forgotPassword.dart';
import 'package:outii/View/Qr_Generate.dart';
import 'package:outii/main.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:outii/View/Hompage.dart';
import 'package:outii/View/student_previous_data.dart';

import '../View/add_user.dart';

class Routes {
  static Route<dynamic> genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.My_HomePage:
        return MaterialPageRoute(builder: (context) => MyHomePage());
      case RouteName.add_user:
        return MaterialPageRoute(builder: (context) => add_user());
      case RouteName.forgot_passwd:
        return MaterialPageRoute(builder: (context) => ForgotPassword());
      case RouteName.sample:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => sample(User_UI: arguments["show"]));
      case RouteName.Qr_generate:
        return MaterialPageRoute(builder: (context) => Qr_Generate());
      case RouteName.Student_previous_data:
        Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (context) => Student_previous_data(
                Collection: arguments["collection_id"],
                Phone_No: arguments["Phone_No"]));
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text("No route defining"),
            ),
          );
        });
    }
  }
}
