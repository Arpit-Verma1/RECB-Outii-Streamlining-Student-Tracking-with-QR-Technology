import 'package:flutter/material.dart';

import '../../Database/Server_and Functions.dart';

class StudentProfileCard extends StatelessWidget {
  final String id;
  final double height;

  const StudentProfileCard({super.key, required this.id, required this.height});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
  }
}
