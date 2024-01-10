import 'package:flutter/material.dart';

class drawerHeader extends StatelessWidget {
  const drawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      width: double.infinity,
      child: Stack(children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(.6), BlendMode.darken),
                  fit: BoxFit.cover,
                  image: AssetImage('assets/recb.jpg')),
              color: Colors.grey.shade900,
              boxShadow: [BoxShadow(blurRadius: 15)],
              borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(150))),
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
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            )),
      ]),
    );
  }
}
