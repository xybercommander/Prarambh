import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';

class UserMainPage extends StatefulWidget {
  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("${CustomerConstants.fullName}"),
      ),
    );
  }
}