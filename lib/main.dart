import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:outii/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth.dart';
import 'emailverify.dart';
import 'Utils.dart';
import 'firebase_options.dart';

// @dart=2.9

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final binding = WidgetsFlutterBinding.ensureInitialized();
  binding.deferFirstFrame();
  binding.addPostFrameCallback((_) async {
    BuildContext context = binding.renderViewElement as BuildContext;
    if (context != null) {
      Text(
        "",
        style: GoogleFonts.lobster(),
      );
      Text(
        "",
        style: GoogleFonts.cookie(),
      );
    }
    binding.allowFirstFrame();
  });

  await UserSimplePreferences.init();
  await UserSimplePreferences1.init();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.My_HomePage,
      onGenerateRoute: Routes.genrateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Progressindicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Something Went Wrong",
            ),
          );
        } else if (snapshot.hasData) {
          return Verifyemail();
        } else {
          return AuthPage(
            islogin: true,
          );
        }
      },
    ));
  }
}

class UserSimplePreferences {
  static late SharedPreferences _preferences;
  static const key1 = 'av';
  static const key2 = 'av';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setusername(bool isChecked) async =>
      await _preferences.setBool(key1, isChecked);
  static bool? getusername() => _preferences.getBool(key1);
}

class UserSimplePreferences1 {
  static late SharedPreferences _preferences;
  static const key2 = 'av1';
  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setusername1(String isChecked1) async =>
      await _preferences.setString(key2, isChecked1);
  static String? getusername1() => _preferences.getString(key2);
  static const key3 = 'av1';

  static Future setusername11(String isChecked11) async =>
      await _preferences.setString(key3, isChecked11);
  static String? getusername11() => _preferences.getString(key3);
  static const key4 = 'av2';

  static Future setusername12(String isChecked12) async =>
      await _preferences.setString(key4, isChecked12);
  static String? getusername12() => _preferences.getString(key4);
}
