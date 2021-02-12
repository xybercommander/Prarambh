import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/services/auth.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_mainpage.dart';
import 'package:hack_it_out_demo/widgets/sign_in_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';

class CompanySignUp extends StatefulWidget {
  @override
  _CompanySignUpState createState() => _CompanySignUpState();
}

class _CompanySignUpState extends State<CompanySignUp> {
  TextEditingController companyNameTextEditingController =
      new TextEditingController();
  TextEditingController serviceTypeTextEditingController =
      new TextEditingController();
  TextEditingController descriptionTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  String serviceTypeValue = 'Developer';

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  signUp() {
    if (formKey.currentState.validate()) {
      Map<String, dynamic> companyMap = {
        'companyName': companyNameTextEditingController.text,
        'description': descriptionTextEditingController.text,
        'email': emailTextEditingController.text,
        'serviceType': CompanyConstants.serviceType,
        'isCompany': true
      };

      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        CompanyConstants.companyName = companyNameTextEditingController.text;
        CompanyConstants.description = descriptionTextEditingController.text;
        CompanyConstants.email = emailTextEditingController.text;
        // Company service type constants is already saved in signin widgets

        databaseMethods.uploadUserInfo(companyMap);

        Navigator.pushReplacement(
            context,
            PageTransition(
                child: CompanyMainPage(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: Duration(milliseconds: 300)));
      });
    }
  }

  // UI of the Page
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
                  "Create Services Account,",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
            height: 350,
            width: MediaQuery.of(context).size.width - 30,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  companyNameInput(context, companyNameTextEditingController),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Select a service type',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black45),
                    ),
                  ),
                  serviceTypeInput(context),
                  descriptionInput(context, descriptionTextEditingController),
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

  serviceTypeInput(context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black45),
          borderRadius: BorderRadius.circular(18)),
      child: DropdownButton(
        isExpanded: true,
        underline: SizedBox(),
        style: TextStyle(
            color: Colors.black45, fontFamily: 'Varela', fontSize: 16),
        icon: Icon(Icons.arrow_drop_down_outlined),
        value: '$serviceTypeValue',
        items: [
          'Developer',
          'Designer',
          'House Cleaning',
          'Grocery Store',
          'Restraunt'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          CompanyConstants.serviceType = value;
          setState(() {
            serviceTypeValue = value;
          });
        },
      ),
    );
  }
}
