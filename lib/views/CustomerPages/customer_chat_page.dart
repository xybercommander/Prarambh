import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';

class CustomerChatPage extends StatefulWidget {    
  @override
  _CustomerChatPageState createState() => _CustomerChatPageState();
}

class _CustomerChatPageState extends State<CustomerChatPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Customer Chat Page'),
      //   centerTitle: true,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       gradient: LinearGradient(
      //         begin: Alignment.centerLeft, 
      //         end: Alignment.centerRight,
      //         colors: [ Color.fromRGBO(253, 170, 142, 1), Color.fromRGBO(250, 89, 143, 1)]
      //       )
      //     ),
      //   ),
      // ),

      body: Center(
        child: Text('Chat Page'),
      ),
    );
  }
}