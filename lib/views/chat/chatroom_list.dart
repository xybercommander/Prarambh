import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/chat/chat_screen.dart';
import 'package:page_transition/page_transition.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatRoomsStream;
  bool isCompany;

  getIsCompany() async {
    isCompany = await SharedPref.getIsCompanySharedPreference();
  }

  getChatRooms() async {
    chatRoomsStream = await databaseMethods.getChatRooms(isCompany);
    setState(() {});
  }

  onScreenLoaded() async {
    await getIsCompany();
    getChatRooms();
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {        
        return snapshot.hasData ? ListView.builder(
          padding: EdgeInsets.only(top: 24),       
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            // return Text(ds.id.replaceAll(CustomerConstants.fullName, '').replaceAll('_', ''));
            return ChatRoomListTile(ds.id, ds['lastMessage'], isCompany);
          },
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/emptyImg.svg', height: 200, width: 200,),
              SizedBox(height: 20,),
              Text('Seems empty')
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    onScreenLoaded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(223, 140, 112, 1),
        title: Text('Chatroom List Page'),
      ),

      body: chatRoomsList()
    );
  }
}

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
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                    Color.fromRGBO(223, 140, 112, 1),
                    Color.fromRGBO(250, 89, 143, 1)
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