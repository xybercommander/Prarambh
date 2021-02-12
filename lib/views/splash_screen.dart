import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context, PageTransition(
        child: Login(),
        type: PageTransitionType.fade,
        duration: Duration(milliseconds: 400)
      ));
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

// git branch -m Samrat master
// git fetch origin
// git branch -u origin/master master