
// THIS CODE IS FOR THE FORGOT PASSWORD PAGE

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hack_it_out_demo/services/auth.dart';
import 'package:hack_it_out_demo/widgets/sign_in_widgets.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTextEditingController = TextEditingController();
  AuthMethods authMethods = new AuthMethods();

  forgotPassword() {
    authMethods.resetPassword(emailTextEditingController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Forgot your password?",
                  style: TextStyle(
                      height: 4,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "No worries, we'll send you a password reset mail",
                  style: TextStyle(
                      fontSize: 15,
                      height: 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20,),
            emailInput(context, emailTextEditingController),
            SizedBox(height: 30,),
            GestureDetector(
              onTap: () {
                print("Sending mail");
                forgotPassword();
                Fluttertoast.showToast(msg: 'Sending Email');
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.pop(context);
                });
                // print('Logged in');
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),                  
                    gradient: LinearGradient(colors: [const Color(0xFF915FB5), const Color(0xFFCA436B)])),
                child: Center(
                  child: Text(
                    "Send Mail",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}