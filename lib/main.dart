import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/company_signup.dart';
import 'package:hack_it_out_demo/SignInPages/profile_type.dart';
import 'package:hack_it_out_demo/SignInPages/user_signup.dart';
import 'SignInPages/login.dart';
// import 'package:hack_it_out_demo/views/mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hack it out App Demo',
      theme: ThemeData(
        fontFamily: 'Varela'
      ),      
      home: CompanySignUp(),
    );
  }
}