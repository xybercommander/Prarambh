import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/services/auth.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/company_navigator.dart';
import 'package:hack_it_out_demo/widgets/sign_in_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';

class CompanySignUp extends StatefulWidget {
  @override
  _CompanySignUpState createState() => _CompanySignUpState();
}

class _CompanySignUpState extends State<CompanySignUp> {
  TextEditingController companyNameTextEditingController = TextEditingController();
  TextEditingController serviceTypeTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  String serviceTypeValue = 'Developer';
  bool darkMode = false;

  File _image;
  String logoUrl = '';

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Future uploadPic() async {
    final file = _image;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child(file.path);
    await reference.putFile(file);
    logoUrl = await reference.getDownloadURL();
  }

  final picker = ImagePicker();
  Future getImage() async {
    PickedFile pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Fluttertoast.showToast(
            msg: 'No Image Picked!',
            textColor: Colors.white,
            backgroundColor: Color.fromRGBO(253, 170, 142, 1));
      }
    });
  }

  signUp() async {
    if (formKey.currentState.validate()) {
      await uploadPic();

      Map<String, dynamic> companyMap = {
        'companyName': companyNameTextEditingController.text,
        'description': descriptionTextEditingController.text,
        'email': emailTextEditingController.text,
        'serviceType': CompanyConstants.serviceType,
        'logoUrl': logoUrl == '' ? '' : logoUrl,
        'isCompany': true
      };

      Map<String, dynamic> companyInfo = {
        'companyDesc': descriptionTextEditingController.text,
        'companyName': companyNameTextEditingController.text,
        'companyService': CompanyConstants.serviceType,
        'logoUrl': logoUrl == '' ? '' : logoUrl,
      };

      // Shared Preference implementations
      SharedPref.saveCompanyNameSharedPreference(companyNameTextEditingController.text);
      SharedPref.saveEmailSharedPreference(emailTextEditingController.text);
      SharedPref.saveIsCompanySharedPreference(true);
      SharedPref.saveLoggedInSharedPreference(true);
      if (logoUrl != '') SharedPref.saveImgUrlSharedPreference(logoUrl);
      SharedPref.saveCompanyDescriptionSharedPreference(descriptionTextEditingController.text);
      SharedPref.saveCompanyServiceTypeSharedPreference(CompanyConstants.serviceType);
      SharedPref.saveLogoUrlSharedPreference(logoUrl);

      authMethods.signUpWithEmailAndPassword
        (emailTextEditingController.text, passwordTextEditingController.text).then((value) {
        CompanyConstants.companyName = companyNameTextEditingController.text;
        CompanyConstants.description = descriptionTextEditingController.text;
        CompanyConstants.email = emailTextEditingController.text;
        CompanyConstants.logoUrl = logoUrl == ''
            ? ''
            : logoUrl; 
        // Company service type constants is already saved in signin widgets

        databaseMethods.uploadUserInfo(companyMap);
        databaseMethods.uploadCompanyInfo(companyInfo);

        Navigator.pushReplacement(
            context,
            PageTransition(
                child: CompanyNavigationPage(),
                type: PageTransitionType.rightToLeftWithFade,
                duration: Duration(milliseconds: 300)));
      });
    }
  }

  // UI of the Page
  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                        style:
                            TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                  height: MediaQuery.of(context).size.height / 1.8,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _image == null
                                  ? Image.asset(
                                      'assets/icons/noImg.png',
                                      height: 100,
                                      width: 100,
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.file(
                                            _image,
                                            width: 100,
                                            height: 100,
                                          ))),
                              RaisedButton(
                                onPressed: () async {
                                  await getImage();
                                },
                                color: const Color(0xFFCA436B),
                                splashColor: Colors.white.withOpacity(0.6),
                                elevation: 10,
                                child: Text(
                                  'Add a Company Logo',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        companyNameInput(
                            context, companyNameTextEditingController),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            'Select a service type',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.black45),
                          ),
                        ),
                        serviceTypeInput(context),
                        descriptionInput(
                            context, descriptionTextEditingController),
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
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                        BoxShadow(
                            color: darkMode ? Colors.grey[900] : Colors.grey[600],
                            offset: Offset(4.0, 4.0),
                            blurRadius: 15.0,
                            spreadRadius: 1.0),
                        BoxShadow(
                          color: darkMode ? Colors.grey[800] : Colors.white,
                          offset: Offset(-4.0, -4.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0)
                    ],
                    gradient: new LinearGradient(
                      colors: [const Color(0xFF915FB5), const Color(0xFFCA436B)],
                    )),
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
            color: const Color(0xFF915FB5), fontFamily: 'Varela', fontSize: 16),
        icon: Icon(Icons.arrow_drop_down_outlined),
        value: '$serviceTypeValue',
        items: ['Developer', 'Designer', 'House Cleaning', 'Grocery Store', 'Restaurant']
            .map<DropdownMenuItem<String>>((String value) {
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
