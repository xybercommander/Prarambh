import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';

class CustomerSearchPage extends StatefulWidget {    
  @override
  _CustomerSearchPageState createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Search Page'),
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
        child: Text('Search Page'),
      ),
    );
  }
}