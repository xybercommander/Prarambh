import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/model/theme_model.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_account_page.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_mainpage.dart';
import 'package:hack_it_out_demo/views/CustomerPages/customer_search_page.dart';
import 'package:hack_it_out_demo/views/chat/chatroom_list.dart';
import 'package:hack_it_out_demo/widgets/theme_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomerNavigationPage extends StatefulWidget {
  final bool isLoggedIn;
  CustomerNavigationPage({this.isLoggedIn});

  @override
  _CustomerNavigationPageState createState() => _CustomerNavigationPageState();
}

class _CustomerNavigationPageState extends State<CustomerNavigationPage> {
  PageController pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;
  ThemeData themeData;

  List<Widget> pages = [
    CustomerMainPage(),
    CustomerSearchPage(),
    CustomerAccountPage()
  ];

  setAppBarTitle(int index) {
    if (index == 0) return Text('Customer Main Page', style: TextStyle(fontFamily: 'Varela'),);
    if (index == 1) return Text('Customer Search Page', style: TextStyle(fontFamily: 'Varela'),);
    if (index == 2) return Text('Customer Account Page', style: TextStyle(fontFamily: 'Varela'),);
  }

  void setCredentials() async {
    if (widget.isLoggedIn) {
      themeData = Provider.of<ThemeModel>(context, listen: false).currentTheme;
      CustomerConstants.fullName = await SharedPref.getFullNameInSharedPreference();
      CustomerConstants.email = await SharedPref.getEmailInSharedPreference();
      CustomerConstants.imgUrl = await SharedPref.getImgUrlInSharedPreference();

      bool darktheme = await SharedPref.getThemeStateInSharedPreference();
      if(darktheme) {
        Provider.of<ThemeModel>(context, listen: false).toggleTheme();
      }        
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
                    ? Color.fromRGBO(255, 153, 102, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
                color: _selectedIndex == 1
                    ? Color.fromRGBO(255, 153, 102, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box,
                color: _selectedIndex == 2
                    ? Color.fromRGBO(255, 153, 102, 1)
                    : Colors.grey[400]),
            title: Container(),
          ),
        ],
      ),
    );
  }
}
