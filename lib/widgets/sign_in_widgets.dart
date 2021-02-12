import 'package:flutter/material.dart';



Widget emailInput(context, TextEditingController textEditingController) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: 50,                      
    decoration: BoxDecoration(                        
      border: Border.all(width: 1, color: Colors.black45),
      borderRadius: BorderRadius.circular(18)
    ),
    child: TextFormField(
      controller: textEditingController,
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
  );
}



Widget passwordInput(context, TextEditingController textEditingController, bool showPassword) {
  return Container(    
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: 50,                      
    decoration: BoxDecoration(                        
      border: Border.all(width: 1, color: Colors.black45),
      borderRadius: BorderRadius.circular(18)
    ),
    child: TextFormField(
      controller: textEditingController,
      obscureText: showPassword ? false : true,
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
  );
}



Widget companyNameInput(context, TextEditingController textEditingController) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: 50,                      
    decoration: BoxDecoration(                        
      border: Border.all(width: 1, color: Colors.black45),
      borderRadius: BorderRadius.circular(18)
    ),
    child: TextFormField(
      controller: textEditingController,                                            
      decoration: InputDecoration(
        hintText: "company name",
        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
        border: InputBorder.none,                              
      ),
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}



Widget fullNameInput(context, TextEditingController textEditingController) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: 50,                      
    decoration: BoxDecoration(                        
      border: Border.all(width: 1, color: Colors.black45),
      borderRadius: BorderRadius.circular(18)
    ),
    child: TextFormField(
      controller: textEditingController,                                            
      decoration: InputDecoration(
        hintText: "full name",
        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
        border: InputBorder.none,                              
      ),
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}



Widget descriptionInput(context, TextEditingController textEditingController) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    width: MediaQuery.of(context).size.width,
    height: 50,                      
    decoration: BoxDecoration(                        
      border: Border.all(width: 1, color: Colors.black45),
      borderRadius: BorderRadius.circular(18)
    ),
    child: TextFormField(
      controller: textEditingController,                                            
      decoration: InputDecoration(
        hintText: "description",
        hintStyle: TextStyle(color: Colors.black45, fontSize: 16),
        border: InputBorder.none,                              
      ),
      style: TextStyle(color: Colors.black, fontSize: 16),
    ),
  );
}