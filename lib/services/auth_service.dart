import 'dart:convert';

import 'package:cizaro_app/model/SignUpModel.dart';
import 'package:cizaro_app/model/loginModel.dart';
import 'package:cizaro_app/model/socialLoginModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static const API = 'http://cizaro.tree-code.com/api/v1';

  Future<void> registerCustomerData(SignUp signUp, String lang) async {
    final response = await http.post(
      API + '/register/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': '$lang'
      },
      body: jsonEncode(signUp.toJson()),
    );
    print(response.body);
    var status = response.body.contains('token');
    var data = json.decode(response.body);

    if (status) {
      saveToken(data['data']['token']);
      saveId(data['data']['id']);
      print(data['data']['id']);
      print(data['data']['token']);
    } else {
      throw Exception("Invalid Email or password");
    }
  }

  Future<void> loginCustomer(Login login, String lang) async {
    final response = await http.post(
      API + '/login/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': '$lang'
      },
      body: jsonEncode(login.toJson()),
    );
    var data = json.decode(response.body);
    if (data['message'] == '' && response.statusCode == 200) {
      saveId(data['data']['id']);
      saveToken(data['data']['token']);
      jsonDecode(response.body);
    } else {
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<void> signUpWithSocial(SignUp signUp, String lang) async {
    final response = await http.post(
      API + '/social-register/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': '$lang'
      },
      body: jsonEncode(signUp.toJson()),
    );
    var data = json.decode(response.body);
    print(data);
    saveStatusCode(data['status_code']);
    if (response.statusCode == 200 || data['message'] == '') {
      saveToken(data['data']['token']);
      saveId(data['data']['id']);
      jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<void> loginWithSocial(SocialLogin socialLogin, String lang) async {
    final response = await http.post(
      API + '/social-login/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept-Language': '$lang'
      },
      body: jsonEncode(socialLogin.toJson()),
    );
    var data = json.decode(response.body);
    print(data);
    if (response.statusCode == 200 || data['message'] == '') {
      saveToken(data['data']['token']);
      saveId(data['data']['id']);
      jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }
}

saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('token', token);
}

saveId(int customerId) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('customer_id', customerId);
}

saveStatusCode(int statusCode) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt('status_code', statusCode);
}
