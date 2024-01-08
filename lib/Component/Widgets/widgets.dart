import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:outii/Database/Server_and%20Functions.dart';
import '../../Students/View/Screens/User_Data.dart';

class Progressindicator extends StatelessWidget {
  const Progressindicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
        size: 50,
        itemBuilder: (context, index) {
          final colors = [Colors.orange, Colors.cyanAccent];
          final color = colors[index % colors.length];
          return DecoratedBox(
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                  shape: BoxShape.rectangle,
                  boxShadow: [
                BoxShadow(
                    blurRadius: 2,
                    offset: Offset(5, 5),
                    color: Colors.redAccent)
              ]));
        });
  }
}

class Button extends StatelessWidget {
  Button({Key? key, required this.buttoncolor, required this.text})
      : super(key: key);

  Color buttoncolor = Colors.blueAccent;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: buttoncolor),
      child: Text(text,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: 15,
            color: Colors.white,
          )),
    );
  }
}

Widget Profilephoto(String id, double height) => FutureBuilder(
      future: FireStoreDataBase().getData(id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            "Something went wrong",
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: height,
            width: (2 * height) / 3,
            decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                color: Colors.white38,
                image: DecorationImage(
                    image: NetworkImage(snapshot.data.toString() == ""
                        ? "https://firebasestorage.googleapis.com/v0/b/auth-92321.appspot.com/o/defalut.png?alt=media&token=fc9415d8-5596-42b7-a6c9-c2e51dd7ccdf"
                        : snapshot.data.toString()),
                    fit: BoxFit.fill)),
          );
        }
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.black,
        ));
      },
    );
Widget listtile(String text1, String text2) => ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      leading: Text(
        text1,
        style: textStyle.copyWith(color: Colors.black),
      ),
      title: Text(
        text2,
        style: textStyle.copyWith(color: Colors.black),
      ),
      dense: true,
    );

void showsnackbar(String tittle_message, String snack_message, Color color,
    BuildContext context) {
  Flushbar(
    title: tittle_message,
    message: snack_message,
    backgroundColor: color,
    icon: Icon(
      color == Colors.green ? Icons.check_circle : Icons.clear_outlined,
      color: Colors.white,
    ),
    duration: Duration(seconds: 3),
    flushbarPosition: FlushbarPosition.BOTTOM,
    forwardAnimationCurve: Curves.easeIn,
    reverseAnimationCurve: Curves.easeOut,
  ).show(context);
}
