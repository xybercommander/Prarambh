import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CompanyPreview extends StatelessWidget {
  QueryDocumentSnapshot queryDocumentSnapshot;
  CompanyPreview(this.queryDocumentSnapshot);

  AssetImage _setCover() {
    switch(queryDocumentSnapshot['companyService']) {
      case 'Developer' :
        return AssetImage('assets/icons/devCover.jpg');
        break;
      case 'Designer' :
        return AssetImage('assets/icons/designerCover.jpg');
        break;
      case 'House Cleaning' :
        return AssetImage('assets/icons/cleaningCover.jpg');
        break;
      case 'Grocery Store' :
        return AssetImage('assets/icons/storeCover.jpg');
        break;
      case 'Restaurant' :
        return AssetImage('assets/icons/restaurantCover.png');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _setCover(),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back, color: Colors.white,), 
                      onPressed: () { 
                        Navigator.pop(context);
                       },
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(height: 20,),
                    Text('${queryDocumentSnapshot['companyName']}', style: TextStyle(fontSize: 40), textAlign: TextAlign.center,),
                    SizedBox(height: 10,),
                    Text('${queryDocumentSnapshot['companyService']}', style: TextStyle(fontSize: 25),  textAlign: TextAlign.center,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                      height: 0.5,                   
                      color: Colors.blueGrey[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        '${queryDocumentSnapshot['companyDesc']}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          height: 50,
                          child: RaisedButton.icon(
                            onPressed: () {  },
                            shape: StadiumBorder(),
                            elevation: 3,
                            icon: Icon(Icons.chat, color: Colors.white, size: 30,),
                            label: Text('Contact', style: TextStyle(color: Colors.white, fontSize: 20),),
                            color: Colors.pinkAccent,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 3,
            top: 120,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/icons/noImg.png'),
              backgroundColor: Colors.grey[100],
              radius: 60,
            ),
          ),
        ],
      ),
    );
  }
}