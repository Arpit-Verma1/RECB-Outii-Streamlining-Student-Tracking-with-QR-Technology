import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outii/Admin/View/Screens/student_previous_data.dart';
import 'package:outii/Authentication/View/Screens/forgotPassword.dart';
import 'package:outii/Students/View/Screens/Qr_Generate.dart';
import 'package:outii/main.dart';
import 'package:outii/routes/routes_name.dart';
import '../Admin/View/Screens/add_user.dart';
import '../Hompage.dart';

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

        return MaterialPageRoute(
            builder: (context) => HomePage());
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
