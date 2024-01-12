import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:outii/Admin/ViewModel/speechapi.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../Core/Widgets/customSnackBar.dart';
import '../Model/firestoreStudentModel.dart';
import '../Model/realtimeDBStudentModel.dart';
import 'google auth api.dart';

class AdminProvider with ChangeNotifier {
  String Student_Branch = "";
  int Student_current_Year = 0;
  String Student_Name = "";
  String Student_Roll_No = "";
  String Student_parents_mail_id = "";
  String Student_parents_phone_no = "";
  String Student_Going_Place = "";
  bool send_mail_parents = false;
  String mail_message = "";
  String searchFieldText = "";
  QRViewController? qrcontroller;
  Barcode? BarCode;
  List<String> warden1 = ['kingarpit268@gmail.com'];
  List<String> warden2 = ['kingarpitverma@gmail.com'];
  List<String> warden3 = ['arpitverma0249@gmail.com'];
  List<String> warden4 = ['kingarpitverma@gmail.com'];
  List<String> sms_phone_numbers = [];
  bool isListening = false;
  TextEditingController Controller = TextEditingController();
  final qrkey = GlobalKey(debugLabel: 'QR');
  DatabaseReference dbref =
      FirebaseDatabase.instance.ref();

  GlobalKey get qrKey => qrkey;

  updateqrcontroller(QRViewController value) {
    qrcontroller = value;
    notifyListeners();
  }

  updatebarcode(Barcode value) {
    BarCode = value;
    notifyListeners();
  }

  void setStudent_Branch(String value) {
    Student_Branch = value;
    notifyListeners();
  }

  void setStudent_current_Year(int value) {
    Student_current_Year = value;
    notifyListeners();
  }

  void setStudent_Name(String value) {
    Student_Name = value;
    notifyListeners();
  }

  void setStudent_Roll_No(String value) {
    Student_Roll_No = value;
    notifyListeners();
  }

  void setStudent_parents_mail_id(String value) {
    Student_parents_mail_id = value;
    notifyListeners();
  }

  void setStudent_parents_phone_no(String value) {
    Student_parents_phone_no = value;
    notifyListeners();
  }

  void setStudent_Going_Place(String value) {
    Student_Going_Place = value;
    notifyListeners();
  }

  void setsend_mail_parents(bool value) {
    send_mail_parents = value;
    notifyListeners();
  }

  void setmail_message(String value) {
    mail_message = value;
    notifyListeners();
  }

  void onQRViewCreated(QRViewController controller) {
    String barcode = "";
    controller.resumeCamera();
    updateqrcontroller(controller);
    controller.scannedDataStream.listen((Barcode) => {
          updatebarcode(Barcode),
          barcode = BarCode!.code!,
          setStudent_Name(
              barcode.substring(0, barcode.indexOf(".")).toUpperCase()),
          setStudent_Branch(barcode
              .substring(barcode.indexOf(".") + 1, barcode.indexOf(".") + 3)
              .toUpperCase()),
          setStudent_Roll_No(barcode.substring(
              barcode.indexOf(".") + 7, barcode.indexOf(".") + 9)),
          setStudent_current_Year(int.parse(barcode.substring(
              barcode.indexOf(".") + 4, barcode.indexOf(".") + 6))),
          setStudent_Going_Place(barcode.substring(
            barcode.indexOf("@") + 21,
          )),
          setStudent_parents_phone_no(
            barcode.substring(
                barcode.indexOf("@") + 11, barcode.indexOf("@") + 21),
          ),
        });
  }

  String Current_Time() {
    return DateFormat(
      "dd-MMM hh:mm a",
    ).format(DateTime.now());
  }

  Check_Out(context) async {
    try {
      String Student_parents_mail_id = "";
      String mail_message =
          "Your child $Student_Name is going to $Student_Going_Place at ${Current_Time()} -regards hostel warden";
      if (send_mail_parents) {
        switch (Student_current_Year) {
          case 1:
            warden1.add(Student_parents_mail_id);
            break;
          case 2:
            warden2.add(Student_parents_mail_id);
            break;
          case 3:
            warden3.add(Student_parents_mail_id);
            break;
          case 4:
            warden4.add(Student_parents_mail_id);
            break;
        }
      }
      String DatabaseId =
          "${Student_Name.toLowerCase()}${Student_current_Year}0$Student_Roll_No$Student_Branch";

      final docuser_firestore =
          FirebaseFirestore.instance.collection(DatabaseId).doc(Current_Time());
      final firestoreStudentModel = FirestoreStudentModel(
          timein: "${Current_Time()}",
          timeout: "---------------",
          where: Student_Going_Place);
      await docuser_firestore.set(firestoreStudentModel.toJson());
      final realtimeDBStudentModel = RealtimeDBStudentModel(
          name: Student_Name,
          timein: Current_Time(),
          timeout: "---------------",
          phone: Student_parents_phone_no,
          where: Student_Going_Place,
          branch: Student_Branch,
          batch: Student_current_Year.toString(),
          rollno: Student_Roll_No
      );

      dbref
          .child('Students')
          .child(DatabaseId)
          .update(realtimeDBStudentModel.toJson());

      sms_phone_numbers.add(Student_parents_phone_no);
      await sendEmail(mail_message);
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
    } catch (e) {
      errorSnackbar("Error Occured", e.toString(), context);
    }
  }

  Check_In() async {
    String DatabaseId =
        "${Student_Name.toLowerCase()}${Student_current_Year}0$Student_Roll_No$Student_Branch";
    dbref.child('Students').child(DatabaseId).update({
      'Timeout': "${Current_Time()}",
    });
    String checkOutTime = await CheckOutTime(DatabaseId);
    final docuser_firestore =
        FirebaseFirestore.instance.collection(DatabaseId).doc(checkOutTime);
    docuser_firestore.update({'Timeout': Current_Time()});
  }

  Future sendEmail(String mail_message) async {
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
      ..text = mail_message;
    try {
      await send(message, smtpServer);
    } on MailerException catch (e) {
      print(e.toString());
    }
  }

  Future<void> send_SMS(List<String> recipients, String mail_message,
      BuildContext context) async {
    try {
      await sendSMS(
        message: mail_message,
        recipients: recipients,
        sendDirect: true,
      );
    } catch (error) {
      errorSnackbar("Error Occured", error.toString(), context);
    }
  }

  CheckOutTime(String DatabaseId) async {
    DatabaseReference reference =
        FirebaseDatabase.instance.ref("Students/$DatabaseId/Timein");
    DatabaseEvent event = await reference.once();
    return event.snapshot.value;
  }

  Future<void> togglerecording() async {
    Speechapi.togglerecording(onresult: (text) {
      Controller.text = text;
      notifyListeners();
    }, onlistening: (islistening) {
      isListening = islistening;
      notifyListeners();
    });
  }
}
