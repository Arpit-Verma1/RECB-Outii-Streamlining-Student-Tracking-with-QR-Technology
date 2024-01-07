import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/google%20auth%20api.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

List<String> warden1 = ['kingarpit268@gmail.com'];
List<String> warden2 = ['kingarpitverma@gmail.com'];
List<String> warden3 = ['arpitverma0249@gmail.com'];
List<String> warden4 = ['kingarpitverma@gmail.com'];
List<String> sms_phone_numbers = [];
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

Check_Out(
    String DatabaseId,
    bool send_mail_parents,
    int Student_current_Year,
    Barcode? barcode,
    String Student_Name,
    String Student_Going_Place,
    String Student_parents_phone_no,
    context) async {
  String Student_parents_mail_id = "";

  if (send_mail_parents) {
    Student_parents_mail_id =
        '${barcode!.code}'.substring(0, '${barcode!.code}'.indexOf(".") + 20);
  }
  String mail_message =
      "Your child $Student_Name is going to $Student_Going_Place at ${Current_Time()} -regards hostel warden";
  if (send_mail_parents) {
    Student_current_Year == 1
        ? warden1.add(Student_parents_mail_id)
        : Student_current_Year == 2
            ? warden2.add(Student_parents_mail_id)
            : Student_current_Year == 3
                ? warden3.add(Student_parents_mail_id)
                : warden4.add(Student_parents_mail_id);
  }

  final docuser_firestore =
      FirebaseFirestore.instance.collection(DatabaseId).doc(Current_Time());
  final json = {
    'Timein': Current_Time(),
    "Timeout": "---------------",
    "Where": "$Student_Going_Place"
  };
  await docuser_firestore.set(json);

  reference_realtime_database.child('Students').child(DatabaseId).update({
    'Name': DatabaseId,
    'Timein': Current_Time(),
    'Timeout': "---------------",
    'Phone': "$Student_parents_phone_no",
    'Where': "$Student_Going_Place"
  });

  sms_phone_numbers.add("$Student_parents_phone_no");
  await sendEmail(Student_current_Year, mail_message);
  await send_SMS(sms_phone_numbers, mail_message, context);
  sms_phone_numbers.remove(Student_parents_phone_no);
  if (send_mail_parents) {
    Student_current_Year == 1
        ? warden1.remove(Student_parents_mail_id)
        : Student_current_Year == 2
            ? warden2.remove(Student_parents_mail_id)
            : Student_current_Year == 3
                ? warden3.remove(Student_parents_mail_id)
                : warden4.remove(Student_parents_mail_id);
  }
}

Check_In(String DatabaseId) async {
  reference_realtime_database.child('Students').child(DatabaseId).update({
    'Timeout': Current_Time(),
  });
  String check_out_time = await Check_Out_Time(DatabaseId);
  final docuser_firestore =
      FirebaseFirestore.instance.collection(DatabaseId).doc(check_out_time);
  docuser_firestore.update({'Timeout': Current_Time()});
}

Future sendEmail(int Student_current_Year, String mail_message) async {
  final _googlesignin = GoogleSignIn(scopes: ['https://mail.google.com/']);
  var user = await Googleauthapi.signIn();
  if (user == null) {
    user = await _googlesignin.signIn();
  }
  ;
  final email = user?.email;
  final auth = await user?.authentication;
  final token = auth?.accessToken!;
  final smtpServer = gmailSaslXoauth2(email!, token!);
  final message = Message()
    ..from = Address(email)
    ..recipients = Student_current_Year == 1
        ? warden1
        : Student_current_Year == 2
            ? warden2
            : Student_current_Year == 3
                ? warden3
                : warden4
    ..subject = "Regarding Your child "
    ..text = "$mail_message";
  try {
    await send(message, smtpServer);
  } on MailerException catch (e) {
    print(e.toString());
  }
}

Future<void> send_SMS(
    List<String> recipients, String mail_message, BuildContext context) async {
  try {
    await sendSMS(
      message: mail_message,
      recipients: recipients,
      sendDirect: true,
    );
  } catch (error) {
    showsnackbar("Error Occured", error.toString(), Colors.red, context);
  }
}

String Current_Time() {
  return DateFormat(
    "dd-MMM hh:mm a",
  ).format(DateTime.now());
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

Check_Out_Time(String DatabaseId) async {
  DatabaseReference reference =
      FirebaseDatabase.instance.ref("Students/$DatabaseId/Timein");
  DatabaseEvent event = await reference.once();
  return event.snapshot.value;
}
