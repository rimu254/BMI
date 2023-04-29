import 'package:bmi_calculator/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (BuildContext context, Orientation orientation, deviceType) {
      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      // ]);
      return GetMaterialApp(
        title: 'BMI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Color(0xFF082DD9),
          scaffoldBackgroundColor: Color(0xFF1E3DCE),
        ),
        home: LoginScreen(),
        // home: IntroScreens(),
      );
    });
  }
}
