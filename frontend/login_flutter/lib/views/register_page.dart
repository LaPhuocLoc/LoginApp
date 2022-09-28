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

  void validate() {
    if (_formKey.currentState!.validate()) {
      signUp();
    }
  }

  // controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final userController = TextEditingController();

  Future<void> signUp() async {
    // var formData = FormData.fromMap(
    //     {'username': userController.text, 'password': passwordController.text});
    // Response response =
    //     await dio.post('http://10.0.2.2:8080/api/user/login', data: formData);
    // final UserModel map = UserModel.fromJson(response.data["data"]);
    // print(response.data["status"]);
    // return map;
    dynamic res =
        await ApiClient.register(userController.text, passwordController.text);
    print(res["data"]);
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

                  //Sign Up button
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: validate,
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
