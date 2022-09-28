import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:form_validator/form_validator.dart';
import 'package:login_flutter/services/dio_client.dart';
import 'package:login_flutter/views/home_page.dart';

import 'register_page.dart'; // import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var dio = Dio();
  // validator for login
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // controllers
  final passwordController = TextEditingController();
  final userController = TextEditingController();

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      //show snackbar to indicate loading
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));
      // get response from ApiClient
      dynamic res =
          await ApiClient.login(userController.text, passwordController.text);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (res['status'] == 'ok') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(userid: res["data"]),
            ));
      } else {
        //if an error occurs, show snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res['message']}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.android, size: 100),
                  SizedBox(height: 25),
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
                      validator: ValidationBuilder()
                          .minLength(
                              5, "Username should be between 6-15 characters")
                          .maxLength(
                              15, "Username should be between 6-15 characters")
                          .build(),
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
                      validator: ValidationBuilder()
                          .minLength(
                              3, "Password should contain at least 3 letter")
                          .build(),
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
                      GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()))
                        },
                        child: Text(
                          ' Register now!',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
