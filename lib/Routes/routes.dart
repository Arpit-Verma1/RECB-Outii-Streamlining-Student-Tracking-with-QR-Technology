import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outii/Forgot_Password_Page.dart';
import 'package:outii/Qr_Generate.dart';
import 'package:outii/add%20user.dart';
import 'package:outii/main.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:outii/sample.dart';
class Routes{
  static Route<dynamic>genrateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.My_HomePage:
        return MaterialPageRoute(builder: (context)=>MyHomePage());
      case RouteName.add_user:
        return MaterialPageRoute(builder: (context)=>add());
      case RouteName.forgot_passwd:
        return MaterialPageRoute(builder: (context)=>ForgotPassword());
      case RouteName.sample:
        Map<String,dynamic>arguments=settings.arguments as Map<String,dynamic>;
        return MaterialPageRoute(builder: (context)=>sample(show: arguments["show"]));
      case RouteName.Qr_generate:
        return MaterialPageRoute(builder: (context)=>Page1());
      default:
        return MaterialPageRoute(builder: (context){
          return Scaffold(
            body: Center(
              child: Text("No route defining"),
            ),
          );
        });
    }
  }
}
