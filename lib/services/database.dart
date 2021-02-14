import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  uploadCompanyInfo(companyinfomap) {
    FirebaseFirestore.instance.collection('companies').add(companyinfomap);
  }

  Future<Stream<QuerySnapshot>> getUserInfoByEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .snapshots();
  }

  // Future<Stream<QuerySnapshot>> getCompanyList(String serviceType) async {
  //   return await FirebaseFirestore.instance
  //       .collection('companies')
  //       .where('companyService', isEqualTo: serviceType)
  //       .snapshots();
  // }
}
