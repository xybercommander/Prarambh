import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }  

  Future<Stream<QuerySnapshot>> getUserInfoByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: userEmail)
      .snapshots();
  }
}