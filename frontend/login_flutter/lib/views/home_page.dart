import 'package:flutter/material.dart';
import 'package:login_flutter/services/dio_client.dart';

import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  final int userid;
  const HomePage({
    Key? key,
    required this.userid,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get data
  Future<UserModel> getUserData() async {
    dynamic res = await ApiClient.getUser(widget.userid);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(22, 22, 30, 1),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(22, 22, 30, 1),
          centerTitle: true,
          title: Text(
            'Profile',
          ),
          leading: new IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: new Icon(Icons.logout, color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text("Edit",
                  style: TextStyle(color: Color.fromRGBO(123, 97, 255, 1))),
            )
          ]),
      body: SizedBox(
        width: double.infinity,
        child: FutureBuilder<UserModel>(
          future: getUserData(),
          builder: (
            BuildContext context,
            AsyncSnapshot<UserModel> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Visibility(
                    visible: snapshot.hasData,
                    child: Text(
                      snapshot.data!.name,
                      style: const TextStyle(color: Colors.black, fontSize: 24),
                    ),
                  )
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                // Render UI when the data is available
                return Container(
                  child: Column(
                    children: [
                      SizedBox(height: 25),
                      // Avatar
                      Padding(
                        padding: EdgeInsets.fromLTRB(32, 8, 32, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage('images/avatar.jpg'),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!.name,
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                  Text(snapshot.data!.email,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 14)),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                      // Profiles
                      SizedBox(height: 25),
                      Column(
                        children: [
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Name",
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 15)),
                                Text(
                                  snapshot.data!.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                          Divider(
                            color: Colors.white10,
                            thickness: 2,
                            indent: 16,
                            endIndent: 16,
                            height: 32,
                          ),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Date of birth",
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 15)),
                                Text(
                                  "Date of birth",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                          Divider(
                            color: Colors.white10,
                            thickness: 2,
                            indent: 16,
                            endIndent: 16,
                            height: 32,
                          ),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Phone number",
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 15)),
                                Text(
                                  "070-8959-2557",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                          Divider(
                            color: Colors.white10,
                            thickness: 2,
                            indent: 16,
                            endIndent: 16,
                            height: 32,
                          ),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Gender",
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 15)),
                                Text(
                                  "Male",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                          Divider(
                            color: Colors.white10,
                            thickness: 2,
                            indent: 16,
                            endIndent: 16,
                            height: 32,
                          ),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Email",
                                    style: TextStyle(
                                        color: Colors.white38, fontSize: 15)),
                                Text(
                                  snapshot.data!.email,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
