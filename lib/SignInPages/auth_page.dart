import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/company_mainpage.dart';
import 'package:hack_it_out_demo/views/user_mainpage.dart';
import 'package:page_transition/page_transition.dart';

class AuthPage extends StatefulWidget {
  @required
  String email;
  AuthPage(this.email);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Stream userStream;  
  DocumentSnapshot documentSnapshot;

  onLogin() async {     
    userStream = await DatabaseMethods().getUserInfoByEmail(widget.email);
    print('User STREAM ---------> $userStream');    
  }

  @override
  void initState() {    
    super.initState();
    onLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Visibility(
        visible: userStream != null,
        child: StreamBuilder(
          stream: userStream,
          builder: (context, snapshot) {
            if(snapshot.hasData) print('DATA IS THERE BRUV');
            else print('NO DATA BRUV');
            if(snapshot.hasData) documentSnapshot = snapshot.data.docs[0];            

            // if(documentSnapshot['isCompany'] == true) {
            //   CompanyConstants.companyName = documentSnapshot['companyName'];
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     Navigator.pushReplacement(context, PageTransition(
            //       child: CompanyMainPage(),
            //       type: PageTransitionType.fade
            //     ));
            //   });
            // } else {
            //   CustomerConstants.fullName = documentSnapshot['fullName'];
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     Navigator.pushReplacement(context, PageTransition(
            //       child: UserMainPage(),
            //       type: PageTransitionType.fade
            //     ));
            //   });
            // }
            if(snapshot.hasData) print('IS COMPANY ----------> ${documentSnapshot['isCompany']}');

            return snapshot.hasData ? Container() : Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  }
}