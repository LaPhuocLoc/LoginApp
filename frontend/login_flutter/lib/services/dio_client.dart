import 'package:dio/dio.dart';
import 'package:login_flutter/models/user_model.dart';

class ApiClient {
  // login
  static Future login(String username, String password) async {
    Response response = await Dio().post('http://10.0.2.2:8080/api/user/login',
        data: {'username': username, 'password': password});
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      print(response.data);
      return response.data;
    }
  }

  // get user by id
  static Future<UserModel> getUser(int id) async {
    try {
      final userid = id.toString();
      Response response =
          await Dio().get('http://10.0.2.2:8080/api/user/$userid');
      final UserModel userData = UserModel.fromJson(response.data["data"]);
      print(userData);
      return userData;
    } catch (e) {
      throw Exception(e);
    }
  }

  // register
  static Future register(
      String username, String password, String name, String email) async {
    try {
      Response response = await Dio()
          .post('http://10.0.2.2:8080/api/user/register', data: {
        'username': username,
        'password': password,
        'name': name,
        'email': email
      });
      print(response.data);
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}
