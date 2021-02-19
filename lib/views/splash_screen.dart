import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/views/company_navigator.dart';
import 'package:hack_it_out_demo/views/customer_navigator.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  bool isCompany = false;  

  void getLogAndCompanyStates() async {
    bool log = await SharedPref.getUserLoggedInSharedPreference();
    bool iscompany = await SharedPref.getIsCompanySharedPreference();

    setState(() {
      if (log == null) {
        isLoggedIn = false;
      } else {
        isLoggedIn = log;
      }

      if (iscompany == null) {
        isCompany = false;
      } else {
        isCompany = iscompany;
      }
    });
  }

  @override
  void initState() {
    getLogAndCompanyStates();

    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          PageTransition(
              child: !isLoggedIn
                  ? Login()
                  : isCompany
                      ? CompanyNavigationPage(isLoggedIn: isLoggedIn,)
                      : CustomerNavigationPage(
                          isLoggedIn: isLoggedIn,
                        ),
              type: PageTransitionType.fade,
              duration: Duration(milliseconds: 400)));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: FlareActor(
          'assets/animations/loading_circle.flr',
          animation: 'index',
        ),
      ),
    );
  }
}
