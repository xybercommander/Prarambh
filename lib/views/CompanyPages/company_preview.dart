import 'package:flutter/material.dart';

class CompanyPreview extends StatelessWidget {
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
                        image: AssetImage('assets/icons/devCover.jpg'),
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
                    Text('Company Name', style: TextStyle(fontSize: 40), textAlign: TextAlign.center,),
                    SizedBox(height: 10,),
                    Text('Company Service', style: TextStyle(fontSize: 25),  textAlign: TextAlign.center,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                      height: 0.5,                   
                      color: Colors.blueGrey[800],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lacinia at quis risus sed vulputate odio. Rutrum tellus pellentesque eu tincidunt tortor. Placerat in egestas erat imperdiet sed euismod nisi porta. Ac tincidunt vitae semper quis lectus nulla at volutpat diam. Pharetra magna ac placerat vestibulum. Varius vel pharetra vel turpis nunc eget lorem dolor sed. Lectus vestibulum mattis ullamcorper velit sed. Eget nunc scelerisque viverra mauris. Lacinia quis vel eros donec ac. A erat nam at lectus urna duis convallis convallis tellus. Sed nisi lacus sed viverra tellus in hac habitasse. Maecenas volutpat blandit aliquam etiam erat velit scelerisque in. Lectus mauris ultrices eros in cursus. Non pulvinar neque laoreet suspendisse interdum consectetur libero id faucibus. Molestie nunc non blandit massa enim. Id eu nisl nunc mi ipsum. In ornare quam viverra orci sagittis eu volutpat. Eget egestas purus viverra accumsan in nisl nisi. Morbi enim nunc faucibus a pellentesque. Mattis nunc sed blandit libero volutpat sed cras ornare. Tincidunt tortor aliquam nulla facilisi cras. Sed velit dignissim sodales ut eu sem integer vitae. Eu ultrices vitae auctor eu augue. Fringilla est ullamcorper eget nulla.',
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