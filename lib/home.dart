import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount : users.length,
          itemBuilder: (context,index){
            final user = users[index];
            final name = users[index].toString();
            // final email = user['email'];
            // final imageUrl = user['']["sites"]['chargers']['imageUrl'];
            return ListTile(
              leading: ClipRRect(
                borderRadius:BorderRadius.circular(100),
                // child: Image.network(imageUrl),
              ),
              // title: Text(email),
              subtitle: Text(name),
            );
          }),
      floatingActionButton: FloatingActionButton(onPressed: fetchUsers),
    );

  }

  void fetchUsers() async{
    print('FetchUsers Called');

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJVc2VyIERldGFpbHMiLCJpc3MiOiJHcmlkc2NhcGUiLCJpYXQiOjE2OTA4NzU2MTgsImVtYWlsIjoidGVzdF9yYWh1bDRAeW9wbWFpbC5jb20iLCJjdXN0b21lciI6MX0.89EJmwdHChxx_uAPtBwPtblJ5HMY0KdltI7Z9GRPsIs'
    };

    var request = http.Request('POST', Uri.parse('https://demo.grid-scape.com/m-interface/v2/chargers'));
    request.body = json.encode({
      "chargerVisibility": "ALL",
      "hierarchyLevel": "UPTO_CONNECTOR"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var res = await response.stream.bytesToString();
    print('Printing from response res variable ${jsonDecode(res)["data"]["sites"]}');
    var result = jsonDecode(res);



    setState(() {
      users = result["data"]["sites"][0]["address"];
    });


    print('fetchUsers completed');
  }
}
