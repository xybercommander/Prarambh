import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';

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
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            // return Text(ds.id.replaceAll(CustomerConstants.fullName, '').replaceAll('_', ''));
            return ChatRoomListTile(ds, ds.id, ds['lastMessage'], isCompany);
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
        title: Text('Chatroom List Page'),
      ),

      body: chatRoomsList()
    );
  }
}

// Chat room list tile widget
class ChatRoomListTile extends StatefulWidget {
  final DocumentSnapshot ds;
  final String chatRoomId;
  final String lastMessage;
  bool isCompany;
  ChatRoomListTile(this.ds, this.chatRoomId, this.lastMessage, this.isCompany);
  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {

  DatabaseMethods databaseMethods = DatabaseMethods();

  String name = '', profilePic = '', lastMessage = '';
  
  getThisUserInfo() async {
    QuerySnapshot querySnapshot = await databaseMethods.getUserInfoByName(
      widget.ds['companyName'], widget.isCompany
    );

    widget.isCompany ? name = querySnapshot.docs[0]['companyName'] : name = querySnapshot.docs[0]['fullName'];
    widget.isCompany ? profilePic = querySnapshot.docs[0]['logoUrl'] : profilePic = querySnapshot.docs[0]['imgUrl'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          children: [
            Text('Hello'),
            // Text(widget.lastMessage)
          ],
        ),
    );
  }
}