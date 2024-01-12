import 'package:flutter/material.dart';
import 'package:outii/Admin/ViewModel/adminViewModel.dart';
import 'package:outii/Authentication/View/Widgets/authButton.dart';
import 'package:outii/Utils/constant.dart';
import 'package:provider/provider.dart';
import '../../../Core/Widgets/customSnackBar.dart';

class qrScanResult extends StatelessWidget {
  const qrScanResult({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: lightPeach,
        padding: EdgeInsets.all(10),
        child:
            Consumer<AdminProvider>(builder: (context, adminProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Name :- " + adminProvider.Student_Name,
                  style: boldText,
                ),
                Text("Branch :- " + adminProvider.Student_Branch,
                    style: boldText),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phone No :- ' + adminProvider.Student_parents_phone_no,
                    style: boldText,
                  ),
                  Text(
                    'Roll No :- ' + adminProvider.Student_Roll_No,
                    style: boldText,
                  ),
                  Text(
                    "Year :-" + adminProvider.Student_current_Year.toString(),
                    style: boldText,
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      "Purpose :- " + adminProvider.Student_Going_Place,
                      style: boldText,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.05,
                      child: authButton(
                        function: () async {
                          if (adminProvider.BarCode?.code == null)
                            errorSnackbar(
                                "Error Occured", "Envalid QR", context);
                          else {
                            await adminProvider.Check_Out(context);
                            successSnackbar("Check Out Successfully",
                                "Mail Sent To Warden", context);
                          }
                        },
                        buttonName: 'Check Out',
                        fontSize: 15,
                      )),
                  SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.3,
                      child: authButton(
                        function: () {
                          if (adminProvider.BarCode?.code == null)
                            errorSnackbar(
                                "Error Occured", "Envalid QR", context);
                          else {
                            adminProvider.Check_In();
                            successSnackbar("Check Out Successfully",
                                "Mail Sent To Warden", context);
                          }
                        },
                        buttonName: 'Check In',
                        fontSize: 15,
                      )),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                        color: purple.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Text(
                          "Parents",
                          style: boldText.copyWith(color: Colors.white),
                        ),
                        Switch(
                            activeTrackColor: Colors.black,
                            activeColor: Colors.white,
                            value: context
                                .watch<AdminProvider>()
                                .send_mail_parents,
                            onChanged: (bool newValue) {
                              adminProvider.setsend_mail_parents(newValue);
                            })
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        }));
  }
}
