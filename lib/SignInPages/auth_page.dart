
// THIS CODE GETS THE INITIAL DATA FROM FIRESTORE

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/company_navigator.dart';
import 'package:hack_it_out_demo/views/customer_navigator.dart';
import 'package:page_transition/page_transition.dart';

import '../modules/customer_constants.dart';

class AuthPage extends StatefulWidget {
  @required
  final String email;
  final Stream userstream;
  AuthPage({this.email, this.userstream});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Stream userStream;
  DocumentSnapshot documentSnapshot;
  DatabaseMethods databaseMethods = new DatabaseMethods();

  onLogin() {
    setState(() {
      userStream = widget.userstream;
    });
    print('User STREAM ---------> $userStream');
  }

  @override
  void initState() {
    onLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          // if (snapshot.hasData)
          //   print('DATA IS THERE BRUV');
          // else
          //   print('NO DATA BRUV');
          if (snapshot.hasData) documentSnapshot = snapshot.data.docs[0];

          Future.delayed(Duration(seconds: 5), () {
            if (documentSnapshot['isCompany'] == true) {
              CompanyConstants.companyName = documentSnapshot['companyName'];
              CompanyConstants.email = documentSnapshot['email'];
              CompanyConstants.serviceType = documentSnapshot['serviceType'];
              CompanyConstants.description = documentSnapshot['description'];
              CompanyConstants.logoUrl = documentSnapshot['logoUrl'];

              SharedPref.saveCompanyNameSharedPreference(
                  documentSnapshot['companyName']);
              SharedPref.saveEmailSharedPreference(documentSnapshot['email']);
              SharedPref.saveLogoUrlSharedPreference(documentSnapshot['logoUrl']);
              SharedPref.saveCompanyDescriptionSharedPreference(
                  documentSnapshot['description']);
              SharedPref.saveCompanyServiceTypeSharedPreference(
                  documentSnapshot['serviceType']);
              SharedPref.saveIsCompanySharedPreference(true);
              SharedPref.saveLoggedInSharedPreference(true);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: CompanyNavigationPage(),
                        type: PageTransitionType.fade));
              });
            } else {
              CustomerConstants.fullName = documentSnapshot['fullName'];
              CustomerConstants.imgUrl = documentSnapshot['imgUrl'];
              CustomerConstants.email = documentSnapshot['email'];

              SharedPref.saveFullNameSharedPreference(
                  documentSnapshot['fullName']);
              SharedPref.saveEmailSharedPreference(documentSnapshot['email']);
              SharedPref.saveImgUrlSharedPreference(documentSnapshot['imgUrl']);
              SharedPref.saveIsCompanySharedPreference(false);
              SharedPref.saveLoggedInSharedPreference(true);

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: CustomerNavigationPage(
                          isLoggedIn: false,
                        ),
                        type: PageTransitionType.fade));
              });
            }
            if (snapshot.hasData)
              print('IS COMPANY ----------> ${documentSnapshot['isCompany']}');
          });

          return Center(
            child: FlareActor(
              'assets/animations/loading_circle.flr',
              animation: 'index',
            ),
          );
        },
      ),
    );
  }
}
