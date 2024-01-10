import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

DatabaseReference reference_realtime_database = FirebaseDatabase.instance.ref();

class FireStoreDataBase {
  String downloadURL = "";

  Future getData(String name) async {
    try {
      await downloadURLExample(name);
      return downloadURL;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> downloadURLExample(String name) async {
    try {
      downloadURL =
          await FirebaseStorage.instance.ref().child(name).getDownloadURL();
    } on FirebaseException catch (e) {
      print("Failed with error '${e.code}': ${e.message}");
    }
  }
}

uploadImage(String id) async {
  final _firebaseStorage = FirebaseStorage.instance;
  final _imagePicker = ImagePicker();
  XFile image;
  await Permission.photos.request();

  var permissionStatus = await Permission.photos.status;

  if (permissionStatus.isGranted) {
    //Select Image
    image = (await _imagePicker.pickImage(source: ImageSource.gallery))!;
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _firebaseStorage.ref().child(id).putFile(file);
      var downloadUrl = await snapshot.ref.getDownloadURL();
    } else {
      print('No Image Path Received');
    }
  } else {
    print('Permission not granted. Try Again with permission access');
  }
}

int Year_and_batch(int year) {
  int current_year = int.parse(DateFormat(
        "yyyy",
      ).format(DateTime.now())) -
      2000;
  int current_month = int.parse(DateFormat(
    "MM",
  ).format(DateTime.now()));
  if (current_month <= 8) {
    if (year + 1 == current_year)
      return 1;
    else if (year + 2 == current_year) return 2;
    if (year + 3 == current_year)
      return 3;
    else
      return 4;
  } else {
    if (year == current_year)
      return 1;
    else if (year + 1 == current_year) return 2;
    if (year + 2 == current_year)
      return 3;
    else
      return 4;
  }
}
