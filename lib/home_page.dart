import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Welcome> samplePosts = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Container(
                  height: 130,
                  color: Colors.yellow,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text('User id: ${samplePosts[index].data}', style: TextStyle(fontSize: 18),),
                      Text('Id: data', style: TextStyle(fontSize: 18),),
                      Text('Title: data', style: TextStyle(fontSize: 18),),
                      Text('Body: data', style: TextStyle(fontSize: 18),),

                    ],),
                );
              }
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Future<List<Welcome>> getData() async{
    final response = await http.get(Uri.parse('https://demo.grid-scape.com/m-interface/v2/chargers'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String,dynamic> index in data){
        samplePosts.add(data.fromJson(index));
      }

      return samplePosts;
    }else{
      return samplePosts;
    }
  }
}
