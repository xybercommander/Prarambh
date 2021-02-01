import 'package:flutter/material.dart';
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
      home: Login(),
    );
  }
}