import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';

class CompanyAccountPage extends StatefulWidget {
  @override
  _CompanyAccountPageState createState() => _CompanyAccountPageState();
}

class _CompanyAccountPageState extends State<CompanyAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Account Page'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft, 
              end: Alignment.centerRight,
              colors: [Color.fromRGBO(250, 89, 143, 1), Color.fromRGBO(253, 170, 142, 1)]
            )
          ),
        ),
      ),

      body: Center(
        child: Text('Company Account Page'),
      ),
    );
  }
}