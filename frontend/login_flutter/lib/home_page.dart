import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String userid;
  const HomePage({
    Key? key,
    required this.userid,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // get data
  final url = 'http://10.0.2.2:8080/';
  Future getUserData() async {
    final response = await http.get(Uri.parse('${url}api/user/$this.userid'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to get user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            return Text(snapshot.data);
          }
          return SafeArea(child: Container(child: Text(snapshot.data)));
        });
  }
}
