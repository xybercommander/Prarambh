import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';

class CustomerMainPage extends StatefulWidget {
  @override
  _CustomerMainPageState createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Customer Main Page'),
      //   centerTitle: true,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.centerLeft,
      //         end: Alignment.centerRight,
      //         colors: [Color.fromRGBO(250, 89, 143, 1), Color.fromRGBO(253, 170, 142, 1)]
      //       )
      //     ),
      //   ),
      // ),

      body: Center(
        child: Text(CustomerConstants.fullName),
      ),
    );
  }
}
