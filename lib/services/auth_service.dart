import 'dart:convert';
import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cizaro_app/model/SignUpModel.dart';
import 'package:cizaro_app/model/loginModel.dart';
import 'package:cizaro_app/model/socialLoginModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
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

  Future<User> signInWithApple({List<Scope> scopes = const []}) async {
    final _firebaseAuth = FirebaseAuth.instance;
    // 1. perform the sign-in request
    final result = await AppleSignIn.performRequests(
        [AppleIdRequest(requestedScopes: scopes)]);
    // 2. check the result
    switch (result.status) {
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
          idToken: String.fromCharCodes(appleIdCredential.identityToken),
          accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
        );
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if (scopes.contains(Scope.fullName)) {
          final displayName =
              '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';
          await firebaseUser.updateProfile(displayName: displayName);
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString(),
        );

      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      default:
        throw UnimplementedError();
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
