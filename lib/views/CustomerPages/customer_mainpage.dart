
// THIS PAGE IS FOR THE CUSTOMER MAIN PAGE

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hack_it_out_demo/modules/customer_constants.dart';
import 'package:hack_it_out_demo/services/database.dart';
import 'package:hack_it_out_demo/views/CompanyPages/company_preview.dart';
import 'package:hack_it_out_demo/widgets/customer_widgets.dart';
import 'package:page_transition/page_transition.dart';

class CustomerMainPage extends StatefulWidget {    
  @override
  _CustomerMainPageState createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends State<CustomerMainPage> {

  DatabaseMethods databaseMethods = DatabaseMethods();
  List<String> services = [ 'Grocery Store', 'Restaurant', 'Developer', 'Designer', 'House Cleaning'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: Stack(
        children: [
          Container(
            // color: Colors.blueGrey[900],
          ),
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return Container(            
                height: 260,                        
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        services[index],                    
                        style: TextStyle(
                          fontSize: 20, 
                          fontWeight: FontWeight.bold, 
                          letterSpacing: 2,
                          fontFamily: 'Varela',
                          color: Color.fromRGBO(255, 153, 102, 1)                         
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: databaseMethods.searchByService(services[index]),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        String serviceType = services[index];

                        return Expanded(                      
                          child: Swiper(
                            physics: BouncingScrollPhysics(),
                            scale: 0.8,
                            viewportFraction: 0.5,
                            loop: false,                                                
                            itemCount: snapshot.data.docs.length,                        
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(16), 
                                    decoration: BoxDecoration(
                                      gradient: setContainerGradient(serviceType),
                                      borderRadius: BorderRadius.circular(20),                                      
                                    ),
                                    width: 150,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [                                  
                                          SizedBox(height: MediaQuery.of(context).size.height / 17.5,),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                              snapshot.data.docs[index]['companyName'], 
                                              style: TextStyle(color: Colors.white, fontSize: 25, fontFamily: 'Varela'),
                                            )
                                          ),
                                          SizedBox(height: 10,),
                                          Flexible(
                                            child: Text(
                                              snapshot.data.docs[index]['companyDesc'],
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(color: Colors.white54, fontFamily: 'Varela'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 50,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage('assets/icons/noImg.png'),
                                      radius: 40,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 50,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data.docs[index]['logoUrl']),
                                      radius: 40,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Positioned(           
                                    bottom: 8,
                                    left: 40,                     
                                    child: SizedBox(
                                      width: 100,
                                      height: 25,
                                      child: RaisedButton(   
                                        color: Colors.white,                               
                                        shape: StadiumBorder(),
                                        child: Text('Preview', style: TextStyle(color: Colors.pinkAccent, fontFamily: 'Varela'),),
                                        onPressed: () {
                                          Navigator.push(context, PageTransition(
                                            child: CompanyPreview(snapshot.data.docs[index]),
                                            type: PageTransitionType.rightToLeftWithFade
                                          ));
                                        },
                                      ),
                                    )
                                  ),
                                ],
                              );
                            },                       
                          )
                        );
                      },
                    )
                  ],
                ),
              );
            },
          ),
        ],
      )
    );
  }
}