import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hack_it_out_demo/helper/sharedpreferences.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:random_string/random_string.dart';

class ChatScreen extends StatefulWidget {
  final String chatWithName;
  final bool isCompany;
  ChatScreen(this.chatWithName, this.isCompany);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  String chatRoomId, messageId = '';
  String myName, profilePic, myEmail;
  TextEditingController messageTextEditingController = TextEditingController();

  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream messageStream;

  // Initial functions to be executed
  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  getMyInfo() async {    
    if(widget.isCompany) {
      myName = await SharedPref.getCompanyNameInSharedPreference();
    } else {
      myName = await SharedPref.getFullNameInSharedPreference();
    }
    profilePic = 'assets/icons/noImg.png';
    myEmail = await SharedPref.getEmailInSharedPreference();
    chatRoomId = getChatRoomId(widget.chatWithName, myName);
  }

  doThisOnLaunch() async {
    await getMyInfo();
    getAndSetMessages();
  }// Initial functions ended



  // Chat room functions
  Widget chatBubble(String text, bool sendByMe) {
    return Align(
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(        
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),        
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(sendByMe ? 0 : 20),
            bottomLeft: Radius.circular(!sendByMe ? 0 : 20),
          ),
          gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  sendByMe ? Color.fromRGBO(223, 140, 112, 1) : Color.fromRGBO(194, 200, 197, 1),
                  sendByMe ? Color.fromRGBO(250, 89, 143, 1) : Color.fromRGBO(221, 221, 218, 1),
                ])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, style: TextStyle(color: sendByMe ? Colors.white : Colors.blueGrey[900]),),
          ),
      ),
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData ? ListView.builder(
          physics: BouncingScrollPhysics(),
          reverse: true,
          padding: EdgeInsets.only(bottom: 80),
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            return chatBubble(ds['message'], myName == ds['sendBy']);
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


  getAndSetMessages() async {
    messageStream = await databaseMethods.getChatRoomMessages(chatRoomId);
    setState(() {}); // setting the state after fetching the messages
  }


  // synchronizing the messages
  addMessage(bool sendClicked) {
    if(messageTextEditingController.text != '') {
      String message = messageTextEditingController.text;
      var lastMessageTimeStamp = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        'message' : message,
        'sendBy' : myName,
        'ts' : lastMessageTimeStamp //  the timestamp of the msg
      };

      if(messageId == '') {
        messageId = randomAlphaNumeric(12);
      }

      databaseMethods.addMessage(chatRoomId, messageId, messageInfoMap)
        .then((value) {
          Map<String, dynamic> lastMessageInfoMap = {
            'lastMessage': message,
            'lastMessageSentTs' : lastMessageTimeStamp,
            'lastMessageSentBy' : myName
          };   

          databaseMethods.updateLastMessageSent(chatRoomId, lastMessageInfoMap);      

          if(sendClicked) {
            // remove the text
            messageTextEditingController.text = '';    
            messageId = '';
          }
        });
    }
  }  


  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatWithName),
        backgroundColor: Color.fromRGBO(223, 140, 112, 1),        
      ),

      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        // onChanged: (value) {
                        //   addMessage(false);
                        // },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'type a message..',
                          hintStyle: TextStyle(color: Colors.grey[500])
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(Icons.send)
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}