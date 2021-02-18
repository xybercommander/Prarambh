import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_account_page.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_chat_page.dart';
import 'package:hack_it_out_demo/views/chat/chatroom_list.dart';

class CompanyNavigationPage extends StatefulWidget {
  final bool isLoggedIn;
  CompanyNavigationPage({this.isLoggedIn});

  @override
  _CompanyNavigationPageState createState() => _CompanyNavigationPageState();
}

class _CompanyNavigationPageState extends State<CompanyNavigationPage> {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  List<Widget> pages = [
    ChatRoomList(),    
    CompanyAccountPage()
  ];

  setAppBarTitle(int index) {
    if (index == 0) return Text('Company Chat Page');    
    if (index == 1) return Text('Company Account Page');
  }

  void setCredentials() async {
    if (widget.isLoggedIn) {
      CompanyConstants.companyName =
          await SharedPref.getCompanyNameInSharedPreference();
      CompanyConstants.email = await SharedPref.getEmailInSharedPreference();
      CompanyConstants.description =
          await SharedPref.getCompanyDescriptionInSharedPreference();
      CompanyConstants.serviceType =
          await SharedPref.getCompanyServiceTypeInSharedPreference();
      CompanyConstants.logoUrl = await SharedPref.getLogoUrlInSharedPreference();
    }
  }

  @override
  void initState() {
    setCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: setAppBarTitle(_selectedIndex),
      //   centerTitle: true,
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //             begin: Alignment.centerLeft,
      //             end: Alignment.centerRight,
      //             colors: [
      //           Color.fromRGBO(253, 170, 142, 1),
      //           Color.fromRGBO(250, 89, 143, 1)
      //         ])),
      //   ),
      // ),
      
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            pageController.animateToPage(_selectedIndex,
                duration: Duration(milliseconds: 300),
                curve: Curves.linearToEaseOut);
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat,
                color: _selectedIndex == 0
                    ? Color.fromRGBO(250, 89, 143, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box,
                color: _selectedIndex == 1
                    ? Color.fromRGBO(250, 89, 143, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
        ],
      ),
    );
  }
}
