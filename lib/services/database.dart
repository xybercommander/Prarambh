
// THIS CODE IS FOR THE FIREBASE FIRESTORE DATABASE

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_it_out_demo/modules/company_constants.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';

class DatabaseMethods {

  // Upload user info map to firestore (company or customer)
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  // Upload only company info
  uploadCompanyInfo(companyinfomap) {
    FirebaseFirestore.instance.collection('companies').add(companyinfomap);
  }

  // Get user info from firestore by using the email
  Future<Stream<QuerySnapshot>> getUserInfoByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userEmail)
      .snapshots();
  }

  // Searching for company info by typing their service
  searchByService(String servicetype) {
    return FirebaseFirestore.instance.collection('companies')
      .where('companyService', isEqualTo: servicetype)
      .snapshots();
  }
  
  // adding a message to chats sub-collection of chatrooms collection
  Future addMessage(String chatRoomId, String messageId, Map messageInfoMap) {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .collection('chats')
      .doc(messageId)
      .set(messageInfoMap);
  }

  // Updating the last message sent collections
  updateLastMessageSent(String chatRoomId, Map lastMessageInfoMap) {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .update(lastMessageInfoMap);
  }

  // Creating or searching for new or existing chatrooms
  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapshot = await FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .get();

    if(snapshot.exists) {
      // if chatroom exists
      return true;
    } else {
      // if chatroom does not exist
      return FirebaseFirestore.instance.collection('chatrooms')
        .doc(chatRoomId)
        .set(chatRoomInfoMap);
    }
  }

  // retrieving the chat messages
  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return FirebaseFirestore.instance.collection('chatrooms')
      .doc(chatRoomId)
      .collection('chats')
      .orderBy('ts', descending: true)
      .snapshots();
  }

  // Getting the list of all the chatrooms created
  Future<Stream<QuerySnapshot>> getChatRooms(isCompany) async {
    String name;
    if(isCompany) {
      name = CompanyConstants.companyName;
    } else {
      name = CustomerConstants.fullName;
    }

    return FirebaseFirestore.instance.collection('chatrooms')
      .orderBy('lastMessageSentTs', descending: true)
      .where('users', arrayContains: name)
      .snapshots();
  }
}
