import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';

class CustomerMainPage extends StatefulWidget {    
  @override
  _CustomerMainPageState createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  List<String> services = ['Developer', 'Designer', 'House Cleaning', 'Grocery Store', 'Restaurant', 'Education'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return Container(
            height: 150,            
            margin: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(services[index], style: TextStyle(fontSize: 20),),
                StreamBuilder(
                  stream: databaseMethods.searchByService(services[index]),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data.docs.map((docs) {
                          return Container(
                            margin: EdgeInsets.all(16),                    
                            height: 80,
                            width: 80,
                            child: Card(
                              elevation: 10,
                              child: 
                                Center(child: Text('Company Name: ${docs['companyName']}')),                                                  
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  },
                )
              ],
            ),
          );
        },
      )
    );
  }
}