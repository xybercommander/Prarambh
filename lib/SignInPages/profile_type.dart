import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/company_signup.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';
import 'package:hack_it_out_demo/SignInPages/customer_signup.dart';
import 'package:page_transition/page_transition.dart';
import 'package:clay_containers/clay_containers.dart';

class ProfileType extends StatelessWidget {
  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        child: Column(
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
                    "Profile Type,",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Select a Profile Type According to your needs",
                    style: TextStyle(
                        height: 2,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              height: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: UserSignUp(),
                          type: PageTransitionType.rightToLeftWithFade,
                          duration: Duration(milliseconds: 200)),
                    ),
                    child: ClayContainer(
                      spread: 2,
                      depth: 12,
                      color: Colors.white,
                      borderRadius: 20,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 80,
                        height: 180,
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6)
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.supervised_user_circle,
                              color: Colors.white,
                              size: 60,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Customer",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Select this profile type if you are looking for services",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: CompanySignUp(),
                          type: PageTransitionType.rightToLeftWithFade,
                          duration: Duration(milliseconds: 200)),
                    ),
                    child: ClayContainer(
                      borderRadius: 20,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 28, horizontal: 10),
                        width: MediaQuery.of(context).size.width - 80,
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                              color: Color.fromRGBO(143, 148, 251, 1),
                              width: 3),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.design_services,
                              color: Color.fromRGBO(143, 148, 251, 1),
                              size: 60,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Company",
                                    style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        fontSize: 25),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Select this profile type if you want to sell your services",
                                    style: TextStyle(
                                        color: Color.fromRGBO(143, 148, 251, 1),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 60,
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
                        style: TextStyle(color: Colors.green[600]),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}