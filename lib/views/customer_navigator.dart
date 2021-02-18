import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_account_page.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_mainpage.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_search_page.dart';
import 'package:hack_it_out_demo/views/chat/chatroom_list.dart';
import 'package:page_transition/page_transition.dart';

class CustomerNavigationPage extends StatefulWidget {
  final bool isLoggedIn;
  CustomerNavigationPage({this.isLoggedIn});

  @override
  _CustomerNavigationPageState createState() => _CustomerNavigationPageState();
}

class _CustomerNavigationPageState extends State<CustomerNavigationPage> {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  List<Widget> pages = [
    CustomerMainPage(),
    CustomerSearchPage(),
    CustomerAccountPage()
  ];

  setAppBarTitle(int index) {
    if (index == 0) return Text('Customer Main Page');
    if (index == 1) return Text('Customer Search Page');
    if (index == 2) return Text('Customer Account Page');
  }

  void setCredentials() async {
    if (widget.isLoggedIn) {
      CustomerConstants.fullName =
          await SharedPref.getFullNameInSharedPreference();
      CustomerConstants.email = await SharedPref.getEmailInSharedPreference();
      CustomerConstants.imgUrl = await SharedPref.getImgUrlInSharedPreference();
    }
  }

  @override
  void initState() {
    setCredentials();
    super.initState();
    print('IMAGE URL ---------------> ${CustomerConstants.imgUrl}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: setAppBarTitle(_selectedIndex),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                Color.fromRGBO(253, 170, 142, 1),
                Color.fromRGBO(250, 89, 143, 1)
              ])),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.chat,
                color: Colors.white,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.push(context, PageTransition(
                  child: ChatRoomList(),
                  type: PageTransitionType.rightToLeftWithFade
                ));
              }
            )
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

    drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
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
            icon: Icon(Icons.home,
                color: _selectedIndex == 0
                    ? Color.fromRGBO(250, 89, 143, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _selectedIndex == 1
                    ? Color.fromRGBO(250, 89, 143, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box,
                color: _selectedIndex == 2
                    ? Color.fromRGBO(250, 89, 143, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
        ],
      ),
    );
  }
}
