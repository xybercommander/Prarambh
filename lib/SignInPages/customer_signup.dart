import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';
import 'package:hack_it_out_demo/services/auth.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/customer_navigator.dart';
import 'package:hack_it_out_demo/widgets/sign_in_widgets.dart';
import 'package:image_picker/image_picker.dart';
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
  File _image;
  String imgUrl = '';

  signUp() async {
    if (formKey.currentState.validate()) {
      await uploadPic();

      Map<String, dynamic> userInfo = {
        'fullName': nameTextEditingController.text,
        'email': emailTextEditingController.text,
        'imgUrl': imgUrl == '' ? '' : imgUrl,
        'isCompany': false
      };

      SharedPref.saveFullNameSharedPreference(nameTextEditingController.text);
      SharedPref.saveEmailSharedPreference(emailTextEditingController.text);
      if (imgUrl != '') SharedPref.saveImgUrlSharedPreference(imgUrl);
      SharedPref.saveIsCompanySharedPreference(false);
      SharedPref.saveLoggedInSharedPreference(true);

      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        CustomerConstants.fullName = nameTextEditingController.text;
        CustomerConstants.imgUrl = imgUrl == ''
            ? ''
            : imgUrl; //  Change this to firebase storage url getter

        databaseMethods.uploadUserInfo(userInfo);

        Navigator.pushReplacement(
            context,
            PageTransition(
                child: CustomerNavigationPage(
                  isLoggedIn: false,
                ),
                type: PageTransitionType.rightToLeftWithFade,
                duration: Duration(milliseconds: 300)));
      });
    }
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

  Future uploadPic() async {
    final file = _image;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference = storage.ref().child(file.path);
    await reference.putFile(file);
    imgUrl = await reference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(        
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,          
            padding: EdgeInsets.symmetric(vertical: 64, horizontal: 16),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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
                  // color: Colors.redAccent,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                color: Color.fromRGBO(250, 89, 143, 1),
                                splashColor: Colors.white.withOpacity(0.6),
                                elevation: 10,
                                child: Text(
                                  'Add a Profile Pic',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
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
                RaisedButton(
                  onPressed: () {
                    print('Trying to sign up');
                    signUp();
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: new LinearGradient(colors: [const Color(0xFF915FB5), const Color(0xFFCA436B)])),
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 22),
                    )),
                  ),
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I am already a member, ", style: TextStyle(color: Colors.black),),
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
}
