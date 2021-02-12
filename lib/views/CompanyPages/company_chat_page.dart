import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';

class CompanyChatPage extends StatefulWidget {
  @override
  _CompanyChatPageState createState() => _CompanyChatPageState();
}

class _CompanyChatPageState extends State<CompanyChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Chat Page'),
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
        child: Text('Company Chat Page'),
      ),
    );
  }
}