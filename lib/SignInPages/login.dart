import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/auth_page.dart';
import 'package:hack_it_out_demo/SignInPages/profile_type.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/widgets/sign_in_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hack_it_out_demo/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot snapshotUserInfo;
  Stream<QuerySnapshot> userStream;

  final formKey = GlobalKey<FormState>();

  bool showPassword = false;
  bool darkMode = false;

  onLogin() async {
    userStream = await databaseMethods
        .getUserInfoByEmail(emailTextEditingController.text);
  }

  signIn() async {
    await onLogin();

    authMethods
        .signInWithEmailAndPassword(
            emailTextEditingController.text, passwordTextEditingController.text)
        .then((value) {
      if (value != null) {
        print('$value');
      } else {
        print('Error');
      }

      Navigator.pushReplacement(
          context,
          PageTransition(
              child: AuthPage(
                email: emailTextEditingController.text,
                userstream: userStream,
              ),
              type: PageTransitionType.fade));
    });
  }

  // UI of the Login Page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
        backgroundColor: darkMode ? Colors.grey[850] : Colors.white,
        body: Stack(
          children: [
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage('assets/image/background.png'),
                    fit: BoxFit.fill,
                  )),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 64, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width - 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let's sign you in,",
                          style: TextStyle(
                              height: 4,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text(
                          "Welcome Back. You've been missed",
                          style: TextStyle(
                              fontSize: 20,
                              height: 2,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width - 30,
                    // color: Colors.redAccent,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          emailInput(
                            context,
                            emailTextEditingController,
                          ),
                          passwordInput(context, passwordTextEditingController,
                              showPassword),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: showPassword,
                                onChanged: (flag) {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                checkColor: Colors.white,
                                activeColor: Color.fromRGBO(250, 89, 143, 1),
                              ),
                              Text("Show Password"),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      110),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Logging in");
                      signIn();
                      // print('Logged in');
                    },
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width - 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: [
                            BoxShadow(
                                color: darkMode
                                    ? Colors.grey[900]
                                    : Colors.grey[600],
                                offset: Offset(4.0, 4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0),
                            BoxShadow(
                                color:
                                    darkMode ? Colors.grey[800] : Colors.white,
                                offset: Offset(-4.0, -4.0),
                                blurRadius: 15.0,
                                spreadRadius: 1.0)
                          ],
                          gradient: LinearGradient(colors: [
                            Color.fromRGBO(143, 148, 251, 1),
                            Color.fromRGBO(143, 148, 251, .6)
                          ])),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 17),
                  Container(
                    color: Colors.white,
                    height: 50,
                    width: MediaQuery.of(context).size.width - 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "I am a new user, ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      child: ProfileType(),
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      duration: Duration(milliseconds: 200)),
                                ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.green[600]),
                            )),
                      ],
                    ),
                  ),

                  // StreamBuilder(
                  //   stream: userStream,
                  //   builder: (context, snapshot) {
                  //     if(snapshot != null) {
                  //       print(snapshot.data.document);
                  //     }
                  //     return Container(

                  //     );
                  //   },
                  // )
                ],
              ),
            ),
          ],
        ));
  }
}
