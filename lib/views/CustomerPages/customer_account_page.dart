import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/SignInPages/login.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/model/theme_model.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/auth.dart';
import 'package:network_to_file_image/network_to_file_image.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';

class CustomerAccountPage extends StatefulWidget {
  @override
  _CustomerAccountPageState createState() => _CustomerAccountPageState();
}

class _CustomerAccountPageState extends State<CustomerAccountPage> {
  File _image;
  bool darkTheme = false;

  AuthMethods authMethods = AuthMethods();

  List<String> options = [
    'Dark Theme',
    'Payment Options',
    'Privacy Policy',
    'About us',
    'Logout'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 32),
            height: MediaQuery.of(context).size.height / 2 - 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  Color.fromRGBO(253, 170, 142, 1),
                  Color.fromRGBO(250, 89, 143, 1)
                ])),
            child: Column(
              children: [
                Center(
                    child: CustomerConstants.imgUrl == ''
                        ? Image.asset('assets/icons/noImg.png', height: 150, width: 150,)
                        : CircleAvatar(
                          backgroundImage: NetworkImage(CustomerConstants.imgUrl),
                          radius: 75,
                          backgroundColor: Colors.transparent,
                        )
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  CustomerConstants.fullName,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  CustomerConstants.email,
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              separatorBuilder: (context, index) => Divider(),
              itemCount: options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    if (options[index] == 'Logout') {
                      await authMethods.signOut();
                      SharedPref.saveLoggedInSharedPreference(false);
                      Navigator.pushReplacement(
                          context,
                          PageTransition(
                              child: Login(),
                              type: PageTransitionType.fade,
                              duration: Duration(milliseconds: 500)));
                    }
                  },
                  child: ListTile(
                    leading: setIcon(options[index]),
                    title: Text(options[index]),
                    trailing: setTrailing(options[index]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Icon setIcon(String option) {
    if (option == 'Dark Theme') return Icon(Icons.nightlight_round);
    if (option == 'Payment Options') return Icon(Icons.payment);
    if (option == 'Privacy Policy') return Icon(Icons.privacy_tip);
    if (option == 'About us') return Icon(Icons.info);
    if (option == 'Logout') return Icon(Icons.logout);
  }

  setTrailing(String option) {
    if (option == 'Dark Theme') {
      return Switch(
          activeColor: Color.fromRGBO(250, 89, 143, 1),
          value: darkTheme,
          onChanged: (bool value) {
            setState(() {
              darkTheme = !darkTheme;
              Provider.of<ThemeModel>(context, listen: false).toggleTheme();
            });
          });
    } else {
      return null;
    }
    // if (option == 'Payment Options') return null;
    // if (option == 'Privacy Policy') return Icon(Icons.privacy_tip);
    // if (option == 'About us') return Icon(Icons.info);
    // if (option == 'Logout') return Icon(Icons.logout);
  }
}
