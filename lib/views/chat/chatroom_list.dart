import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/chat/chat_screen.dart';
import 'package:hack_it_out_demo/widgets/chat_widgets.dart';
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