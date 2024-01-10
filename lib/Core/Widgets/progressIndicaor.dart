import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
