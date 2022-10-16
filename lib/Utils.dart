import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class Utils{
  static Future<String>downloadfile(String url,String filename)async{
    final directory=await getApplicationDocumentsDirectory();
    final filepath='${directory.path}/${filename}';
    final response=await http.get(Uri.parse(url));
    final file=File(filepath);
    await file.writeAsBytes(response.bodyBytes);
    return filepath;
  }
  static GlobalKey<ScaffoldMessengerState> messengerKey=GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String?text){

    if(text==null)return;
    final snackbar=SnackBar(content:Text(text),backgroundColor: Colors.red);
    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackbar);
  }

}



