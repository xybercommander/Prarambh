import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:page_transition/page_transition.dart';

class CustomerSearchPage extends StatefulWidget {
  @override
  _CustomerSearchPageState createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();
  DatabaseMethods databaseMethods = DatabaseMethods();
  Stream companiesStream;
  
  Set<String> querySet = Set();
  List<Map<String, dynamic>> companyQueries = [];

  fixSearchText(String text) {
    String fixedText = text[0].toUpperCase() + text.substring(1);
    return fixedText;
  }

  // initiateSearch(servicetype) async {    
  //   companiesStream = await databaseMethods.searchByService(searchTextEditingController.text);    
  // }

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
                suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {
                  setState(() {});
                }),
                labelText: 'Search',
                labelStyle: TextStyle(color: Color.fromRGBO(250, 89, 143, 1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(250, 89, 143, 1))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(250, 89, 143, 1)))),
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
                    margin: EdgeInsets.all(16),                    
                    height: 100,
                    child: Card(
                      elevation: 10,
                      child: 
                        Center(child: Text('Company Name: ${docs['companyName']}, Company Service: ${docs['companyService']}')),
                                            
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
