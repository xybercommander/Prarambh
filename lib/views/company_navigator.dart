import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_account_page.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_chat_page.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_mainpage.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_search_page.dart';

class CompanyNavigationPage extends StatefulWidget {
  @override
  _CompanyNavigationPageState createState() => _CompanyNavigationPageState();
}

class _CompanyNavigationPageState extends State<CompanyNavigationPage> {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  List<Widget> pages = [CompanyMainPage(), CompanySearchPage(), CompanyAccountPage()];

  setAppBarTitle(int index) {
    if(index == 0) return Text('Company Main Page');
    if(index == 1) return Text('Company Search Page');
    if(index == 2) return Text('Company Account Page');    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: setAppBarTitle(_selectedIndex),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft, 
              end: Alignment.centerRight,
              colors: [ Color.fromRGBO(253, 170, 142, 1), Color.fromRGBO(250, 89, 143, 1)]
            )
          ),
        ),

        leading: IconButton(icon: Icon(Icons.menu, color: Colors.white,), onPressed: null),
        actions: [
          IconButton(icon: Icon(Icons.chat_bubble, color: Colors.white,), onPressed: null)
        ],
      ),
      
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
        onTap: (value) { setState(() {
          _selectedIndex = value;
          pageController.animateToPage(
            _selectedIndex, 
            duration: Duration(milliseconds: 300), 
            curve: Curves.linearToEaseOut
          );
        }); },

        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: _selectedIndex == 0 ? Color.fromRGBO(250, 89, 143, 1) : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: _selectedIndex == 1 ? Color.fromRGBO(250, 89, 143, 1) : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box, color: _selectedIndex == 2 ? Color.fromRGBO(250, 89, 143, 1) : Colors.grey[400]),
            title: Container(),
          ),
        ],
      ),

    );
  }
}