import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  Text("Create Account,,", style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold),),
                  Text("Sign up to get started!", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),),
                ],
              ), 
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 30,              
              // color: Colors.redAccent,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [   
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,                      
                      decoration: BoxDecoration(                        
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius: BorderRadius.circular(18)
                      ),
                      child: TextFormField(
                        controller: nameTextEditingController,                                            
                        decoration: InputDecoration(
                          hintText: "full name",
                          hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                          border: InputBorder.none,                              
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),               
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,                      
                      decoration: BoxDecoration(                        
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius: BorderRadius.circular(18)
                      ),
                      child: TextFormField(
                        controller: emailTextEditingController,
                        validator: (email) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)
                              ? null
                              : "Please provide a valid email id";
                        },                      
                        decoration: InputDecoration(
                          hintText: "email",
                          hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                          border: InputBorder.none,                              
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,                      
                      decoration: BoxDecoration(                        
                        border: Border.all(width: 1, color: Colors.black45),
                        borderRadius: BorderRadius.circular(18)
                      ),
                      child: TextFormField(
                        controller: passwordTextEditingController,
                        validator: (password) {
                                  return password.length > 6
                                      ? null
                                      : "Please provide a password which has more than 6 characters";
                                },                   
                        decoration: InputDecoration(
                          hintText: "password",
                          hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
                          border: InputBorder.none,                              
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    Text("Forgot Password?", style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print("Loggin in");
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
                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 20),),
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
                  Text("Sign In", style: TextStyle(color: Colors.pink),),
                ],
              ), 
            ),
          ],
        ),
      )
    );
  }
}