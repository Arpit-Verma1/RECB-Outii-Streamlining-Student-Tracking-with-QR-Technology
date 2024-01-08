import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outii/Authentication/View/Screens/authToggle.dart';
import 'package:outii/Authentication/View/Screens/emailVerify.dart';
import 'package:outii/Authentication/ViewModel/authViewModel.dart';
import 'package:outii/Component/Widgets/widgets.dart';
import 'package:outii/Shared_Preferences.dart';
import 'package:outii/routes/rotes_name.dart';
import 'package:outii/routes/routes.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// @dart=2.9
Future<void> main() async {
  await Future.delayed(const Duration(seconds: 1))
      .then((value) => FlutterNativeSplash.remove());
  WidgetsFlutterBinding.ensureInitialized();
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
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) =>AuthenticationProvider()),
    ],
    child: MyApp(),
  ));
}



final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
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
          return EmailVerify();
        } else {
          return AuthTogglePage(
            islogin: true,
          );
        }
      },
    ));
  }
}
