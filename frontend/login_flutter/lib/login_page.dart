import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  final url = 'http://10.0.2.2:8080/';
  Future<Map<String, dynamic>> signIn() async {
    var response = await http.post(Uri.parse('${url}api/user/login'), body: {
      'username': userController.text,
      'password': passwordController.text
    });
    // if (response.statusCode == 200) {
    //   String userId = response.body;
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => HomePage(userid: userId)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.android, size: 100),
                SizedBox(height: 50),
                // Hello
                Text("Hello Again!",
                    style: GoogleFonts.bebasNeue(fontSize: 52)),
                SizedBox(height: 10),
                Text("Welcome back, you've been missed!",
                    style: TextStyle(fontSize: 20)),
                SizedBox(height: 50),

                // username textfield
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Username',
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                // password textfield

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      contentPadding: EdgeInsets.all(8),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                //sign in button
                GestureDetector(
                  onTap: signIn,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      ' Register now!',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
