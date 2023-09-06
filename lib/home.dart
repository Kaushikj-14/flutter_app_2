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
            final given_lat = users[index]["latitude"].toString();
            final given_long = users[index]["longitude"].toString();
            final actual_lat = Text("22.2939420161382");
            final actula_lon = Text("73.1737424669467");
            final name = users[index]["address"].toString();
            final id = users[index]["chargers"][0]["chargerId"].toString();
            final place = users[index]["name"].toString();
            final port_type = users[index]["chargers"][0]["evses"][0]["connector"][0]["type"].toString();
            // final imageUrl = user['']["sites"]['chargers']['imageUrl'];
            return Container(
              padding: const EdgeInsets.all(8),
              height: 200,
              color: Colors.white,
              child: SingleChildScrollView(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        ListTile(
                          leading: ClipRRect(
                            borderRadius:BorderRadius.circular(100),
                            // child: Image.network(imageUrl),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(id),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(place)
                                ],
                              )
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(name),
                                ],
                              ),
                              Row(children: [
                                Icon(Icons.location_on),
                                Text('8157 Miles')
                              ],)
                            ],

                          ),
                        ),


                        ListTile(
                          title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.electric_bolt),
                                  alignment: Alignment.topRight,
                                  onPressed: () {
                                    print("Icon Button clicked");
                                  },
                                ),
                                Column(
                                  children: [

                                    MaterialButton(
                                      shape: const CircleBorder(),
                                      color: Colors.grey,
                                      padding: const EdgeInsets.all(10),
                                      onPressed: () {},
                                      child: const Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ]
                          ),

                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(port_type)],
                              ),

                              Column(
                                children: [
                                  MaterialButton(
                                    shape: const CircleBorder(),
                                    color: Colors.green,
                                    padding: const EdgeInsets.all(10),
                                    onPressed: () {},
                                    child: const Icon(
                                      Icons.near_me_sharp,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],


                              ),




                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      indent: 25.0,
                      endIndent: 25.0,
                    )
                  ],
                ),
              ),
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

      // for(var i=0;i<10;i++){
      //   users = result["data"]["sites"][i];
      // }

      users = result["data"]["sites"];

    });


    print('fetchUsers completed');
  }
}
