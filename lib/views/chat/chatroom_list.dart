
// THIS PAGE IS FOR THE CHAT ROOM LIST

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/modules/encryption_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/widgets/chat_widgets.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream chatRoomsStream;
  bool isCompany;
  final encrypter = Encrypter(AES(EncryptionConstants.encryptionKey));

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
            String message = encrypter.decrypt64(ds['lastMessage'], iv: EncryptionConstants.iv);
            return ChatRoomListTile(ds.id, message, isCompany);
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