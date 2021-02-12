import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';
import 'package:hack_it_out_demo/services/auth.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_mainpage.dart';
import 'package:hack_it_out_demo/views/customer_navigator.dart';
import 'package:hack_it_out_demo/widgets/sign_in_widgets.dart';
import 'package:page_transition/page_transition.dart';

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool showPassword = false;

  signUp() {
    Map<String, dynamic> userInfo = {
      'fullName': nameTextEditingController.text,
      'email': emailTextEditingController.text,
      'isCompany': false
    };

    authMethods
        .signUpWithEmailAndPassword(
            emailTextEditingController.text, passwordTextEditingController.text)
        .then((value) {
      CustomerConstants.fullName = nameTextEditingController.text;

      databaseMethods.uploadUserInfo(userInfo);

      Navigator.pushReplacement(
          context,
          PageTransition(
              child: CustomerNavigationPage(),
              type: PageTransitionType.rightToLeftWithFade,
              duration: Duration(milliseconds: 300)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //resizeToAvoidBottomPadding: false,
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
                Text(
                  "Create Account,",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Sign up to get started!",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            height: 230,
            width: MediaQuery.of(context).size.width - 30,
            // color: Colors.redAccent,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  fullNameInput(context, nameTextEditingController),
                  emailInput(context, emailTextEditingController),
                  passwordInput(
                      context, passwordTextEditingController, showPassword),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                    ],
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              print("Trying to signup");
              signUp();
            },
            child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(250, 89, 143, 1),
                    Color.fromRGBO(253, 170, 142, 1)
                  ])),
              child: Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width - 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("I am already a member, "),
                GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: Login(),
                              type: PageTransitionType.leftToRightWithFade,
                              duration: Duration(milliseconds: 200)),
                        ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Colors.pink),
                    )),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
