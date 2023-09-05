import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

        child: Container(

        child: Scaffold(

        appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
    child:AppBar(
    elevation: 0,
    title: ListView(
    shrinkWrap: true,
    children: [
    Padding(
    padding: const EdgeInsets.all(20.0),
    child: TextField(
    decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(30.0),
    borderSide: BorderSide(width: 0.8),

    ),
    filled:true,
    fillColor: Colors.white,
    hintText: 'Search Chargers',
    prefixIcon: Icon(
    Icons.search ,
    size:21.0),

    ),

    ),

    ),

    ],

    // prototypeItem: Icon(Icons.access_alarms),

    ),

    flexibleSpace: ClipRRect(
    // borderRadius: BorderRadius.only(bottomRight:  Radius.circular(50),bottomLeft: Radius.circular(50)),
    child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/img1.png"),
    fit: BoxFit.fill

    ),

    ),
    ),
    ),

    ),

    ),



    body:HomeScreen(),



          bottomNavigationBar: BottomNavigationBar(
            currentIndex: 0,
            // onTap: _navigateBottomBar,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.location_on) ,label: 'Map'),
              BottomNavigationBarItem(icon: Icon(Icons.star_border),label: 'Favorite'),
              BottomNavigationBarItem(icon: Icon(Icons.payment),label: 'Message'),
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),

            ],),

        ),
        )
    );
  }
}
