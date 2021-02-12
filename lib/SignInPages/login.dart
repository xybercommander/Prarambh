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

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  QuerySnapshot snapshotUserInfo;
  Stream<QuerySnapshot> userStream;

  final formKey = GlobalKey<FormState>();

  bool showPassword = false;


  onLogin() async {
    userStream = await databaseMethods.getUserInfoByEmail(emailTextEditingController.text);    
  }

  signIn() async {
    if(formKey.currentState.validate()) {    
      await onLogin();
              
      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value) {
        if(value != null) {
          print('$value');          
        } else {
          print('Error');
        }

        Navigator.pushReplacement(context, PageTransition(
          child: AuthPage(email: emailTextEditingController.text, userstream: userStream,),          
          type: PageTransitionType.fade
        ));
      });        
    }
  }



  // UI of the Login Page
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      resizeToAvoidBottomPadding: false,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 64, horizontal: 16),        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width - 30,              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome,", style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold),),
                  Text("Sign in to continue!", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),),
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
                    emailInput(context, emailTextEditingController),
                    passwordInput(context, passwordTextEditingController, showPassword),
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
                        SizedBox(width: MediaQuery.of(context).size.width / 2 - 110),
                        Text("Forgot Password?", style: TextStyle(color: Colors.black),),
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
                  borderRadius: BorderRadius.circular(20),                  
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(250, 89, 143, 1), Color.fromRGBO(253, 170, 142, 1)]
                  )
                ),
                child: Center(
                  child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 30,              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("I am a new user, "),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context, PageTransition(
                        child: ProfileType(), 
                        type: PageTransitionType.rightToLeftWithFade,
                        duration: Duration(milliseconds: 200)),),
                    child: Text("Sign Up", style: TextStyle(color: Colors.pink),)),
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
      )
    );
  }
}