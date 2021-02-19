import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/model/theme_model.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_preview.dart';
import 'package:hack_it_out_demo/views/chat/chat_screen.dart';
import 'package:hack_it_out_demo/widgets/theme_widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CustomerSearchPage extends StatefulWidget {
  @override
  _CustomerSearchPageState createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream companiesStream;
  ThemeData themeData;
  
  Set<String> querySet = Set();
  List<Map<String, dynamic>> companyQueries = [];

  fixSearchText(String text) {
    String fixedText = text[0].toUpperCase() + text.substring(1);
    return fixedText;
  }

  getChatRoomId(String a, String b) {
    if(a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  // initiateSearch(servicetype) async {    
  //   companiesStream = await databaseMethods.searchByService(searchTextEditingController.text);    
  // }

  @override
  void initState() {
    themeData = Provider.of<ThemeModel>(context, listen: false).currentTheme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.all(32),
          child: TextField(
            controller: searchTextEditingController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, 
                  color: themeData == lightTheme ? Color.fromRGBO(250, 89, 143, 1) : Color.fromRGBO(255, 153, 102, 1)), 
                  onPressed: () {
                    setState(() {});
                  }
                ),
                labelText: 'Search',
                labelStyle: TextStyle(color: themeData == lightTheme ? Color.fromRGBO(250, 89, 143, 1) : Color.fromRGBO(255, 153, 102, 1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: themeData == lightTheme ? Color.fromRGBO(250, 89, 143, 1) : Color.fromRGBO(255, 153, 102, 1))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: themeData == lightTheme ? Color.fromRGBO(250, 89, 143, 1) : Color.fromRGBO(255, 153, 102, 1)))),
            style: TextStyle(fontSize: 18),
          ),
        ),
        Expanded(
          child: StreamBuilder(
            stream: databaseMethods.searchByService(searchTextEditingController.text),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                for(int i = 0; i < snapshot.data.docs.length; i++) {
                  DocumentSnapshot documentSnapshot = snapshot.data.docs[i];
                  if(documentSnapshot['companyService'] == searchTextEditingController.text) {
                    querySet.add(documentSnapshot['companyName']);
                  }
                }
              }

              return ListView(
                physics: BouncingScrollPhysics(),
                children: snapshot.data.docs.map((docs) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    height: 180,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage('assets/icons/noImg.png'),
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(docs['logoUrl']),
                                  backgroundColor: Colors.transparent,
                                  radius: 40,
                                ),
                              ],
                            ),
                            SizedBox(width: 20,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(docs['companyName'], style: TextStyle(fontSize: 25, color: Colors.orange),),
                                  Text(docs['companyService'], style: TextStyle(color: Colors.grey[400]),),
                                  Container(
                                    height: 0.5,
                                    width: MediaQuery.of(context).size.width / 3,
                                    color: Colors.blueGrey,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      RaisedButton(
                                        color: Color.fromRGBO(250, 89, 143, 1),
                                        shape: StadiumBorder(),
                                        child: Text('Contact', style: TextStyle(color: Colors.white),),
                                        onPressed: () {
                                          var chatRoomId = getChatRoomId(CustomerConstants.fullName, docs['companyName']);
                                          Map<String, dynamic> chatRoomInfoMap = {
                                            'users' : [CustomerConstants.fullName, docs['companyName']]
                                          };
                                          databaseMethods.createChatRoom(chatRoomId, chatRoomInfoMap);

                                          Navigator.pushReplacement(context, PageTransition(
                                            child: ChatScreen(docs['companyName'], false,),
                                            type: PageTransitionType.rightToLeftWithFade
                                          ));
                                        },
                                      ),
                                      SizedBox(width: 15,),
                                      RaisedButton(
                                        shape: StadiumBorder(),
                                        color: Colors.white,
                                        child: Text('View', style: TextStyle(color: Color.fromRGBO(250, 89, 143, 1)),),
                                        onPressed: () {
                                          Navigator.push(context, PageTransition(
                                            child: CompanyPreview(docs),
                                            type: PageTransitionType.rightToLeftWithFade
                                          ));
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ),
                  );
                }).toList(),
              );
            },
          ),
        )
      ],
    ));
  }
}
