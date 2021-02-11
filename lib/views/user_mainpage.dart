import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';

class UserMainPage extends StatefulWidget {  
  String email;
  UserMainPage({this.email});

  @override
  _UserMainPageState createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  Stream userStream;
  bool isSearching = false;
  DocumentSnapshot documentSnapshot;

  onLogin() async { 
    isSearching = false;   
    userStream = await DatabaseMethods().getUserInfoByEmail(widget.email);
    print('User STREAM ---------> $userStream');
    setState(() {});
  }

  @override
  void initState() {    
    super.initState();
    onLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Main Page'),
        centerTitle: true,
      ),

      body: Visibility(
        visible: widget.email != null,
        child: StreamBuilder(
          stream: userStream,
          builder: (context, snapshot) {
            if(snapshot.hasData) documentSnapshot = snapshot.data.docs[0];
            return snapshot.hasData ? Center(
              child: Column(                        
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(documentSnapshot['fullName'])
                ],
              ),
            ) : Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}