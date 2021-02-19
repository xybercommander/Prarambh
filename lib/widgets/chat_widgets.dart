import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/model/theme_model.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/views/chat/chat_screen.dart';
import 'package:hack_it_out_demo/widgets/theme_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


// Chat room list tile widget
class ChatRoomListTile extends StatefulWidget {
  final String chatRoomId;
  final String lastMessage;
  bool isCompany;
  ChatRoomListTile(this.chatRoomId, this.lastMessage, this.isCompany);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {

  // DatabaseMethods databaseMethods = DatabaseMethods();
  // String name = '', profilePic = '', lastMessage = '';
  String name = '';
  var names = [];

  ThemeData themeData;
  
  getThisUserName() async {    
    names = widget.chatRoomId.split('_');
    if(widget.isCompany) {
      int i = names.indexOf(CompanyConstants.companyName);
      i == 0 ? name = names[1] : name = names[0];
    } else {
      int i = names.indexOf(CustomerConstants.fullName);
      i == 0 ? name = names[1] : name = names[0];
    }
    setState(() {});
  }

  @override
  void initState() {
    getThisUserName();
    themeData = Provider.of<ThemeModel>(context, listen: false).currentTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, PageTransition(
        child: ChatScreen(name, widget.isCompany),
        type: PageTransitionType.rightToLeftWithFade
      )),
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [                        
                    themeData == lightTheme ? Color.fromRGBO(223, 140, 112, 1) : Color(0xff1f655d),
                    themeData == lightTheme ? Color.fromRGBO(250, 89, 143, 1) : Color(0xff1f655d)
                  ])),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/icons/noImg.png'),
              backgroundColor: Colors.white,
              radius: 20,
            ),
            SizedBox(width: 20,),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [            
                  Text(name, style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  ),),
                  Text(
                    widget.lastMessage.length > 30 ? widget.lastMessage.substring(0, 30) + '...' : widget.lastMessage, 
                    overflow: TextOverflow.ellipsis, 
                    style: TextStyle(
                    color: Colors.white54
                  ),)
                ],
              ),
          ],
        ),
      ),
    );
  }
}