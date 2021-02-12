import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/views/splash_screen.dart';
// import 'package:hack_it_out_demo/SignInPages/company_signup.dart';
// import 'package:hack_it_out_demo/SignInPages/profile_type.dart';
// import 'package:hack_it_out_demo/SignInPages/user_signup.dart';
import 'SignInPages/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:hack_it_out_demo/views/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hack it out App Demo',
      theme: ThemeData(
        fontFamily: 'Varela'
      ),      
      home: SplashScreen(),
    );
  }
}
