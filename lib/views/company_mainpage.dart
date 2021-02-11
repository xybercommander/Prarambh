import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';

class CompanyMainPage extends StatefulWidget {
  @override
  _CompanyMainPageState createState() => _CompanyMainPageState();
}

class _CompanyMainPageState extends State<CompanyMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(CompanyConstants.companyName),
      ),
    );
  }
}