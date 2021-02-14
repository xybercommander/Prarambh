import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:page_transition/page_transition.dart';

class CustomerSearchPage extends StatefulWidget {
  @override
  _CustomerSearchPageState createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  TextEditingController searchTextEditingController = TextEditingController();

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
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(250, 89, 143, 1),
                ),
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
            stream:
                FirebaseFirestore.instance.collection('companies').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                children: snapshot.data.docs.map((docs) {
                  return ListTile(
                    title: docs['companyService'] == 'Developer' ? Text('Company Name: ${docs['companyName']}') : null,
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
