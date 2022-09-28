import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:form_validator/form_validator.dart';
import 'package:login_flutter/services/dio_client.dart';
import 'package:login_flutter/views/login_page.dart';
// import 'package:http/http.dart' as http;
// import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var dio = Dio();
  // validator for sign up
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      //show snackbar to indicate loading
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Processing Data'),
        backgroundColor: Colors.green.shade300,
      ));
      // post user data to be sent and get response from ApiClient
      dynamic res = await ApiClient.register(userController.text,
          passwordController.text, nameController.text, emailController.text);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //checks if there is no error in the response body.
      //if error is not present, navigate the users to Login Screen.
      if (res['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Register Successful!"),
            backgroundColor: Colors.green.shade300));
      } else {
        //if error is present, display a snackbar showing the error messsage
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
                  Icon(Icons.app_registration, size: 100),
                  SizedBox(height: 25),
                  // Hello
                  Text("Hello There!",
                      style: GoogleFonts.bebasNeue(fontSize: 52)),
                  SizedBox(height: 10),
                  Text("Register below with your detail!",
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
                              6, "Password should contain at least 6 letter")
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
                  //Confirm password

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Password and confirm password should be the same';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Full Name
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: ValidationBuilder()
                          .minLength(6, "Name should contain at least 6 letter")
                          .build(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Full Name',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Email Address
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextFormField(
                      controller: emailController,
                      validator:
                          ValidationBuilder().email().maxLength(50).build(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),

                  //Sign Up button
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: signUp,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25.0),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Sign Up',
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
                        'I am a member?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: (() => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()))
                            }),
                        child: Text(
                          ' Login now!',
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
