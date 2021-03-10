import 'package:cizaro_app/model/SignUpModel.dart';
import 'package:cizaro_app/model/loginModel.dart';
import 'package:cizaro_app/model/otp_verification.dart';
import 'package:cizaro_app/model/socialLoginModel.dart';
import 'package:cizaro_app/model/verification_result.dart';
import 'package:cizaro_app/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class AuthViewModel extends ChangeNotifier {
  Future<dynamic> customerRegisterData(SignUp signUp, String lang) async {
    final results = await AuthServices().registerCustomerData(signUp, lang);
    notifyListeners();
    return results;
  }

  Future<dynamic> login(Login login, String lang) async {
    final results = await AuthServices().loginCustomer(login, lang);
    notifyListeners();
    return results;
  }

  Future<dynamic> signUpSocial(SignUp signUp, String lang) async {
    final results = await AuthServices().signUpWithSocial(signUp, lang);
    notifyListeners();
    return results;
  }

  Future<dynamic> loginSocial(SocialLogin socialLogin, String lang) async {
    final results = await AuthServices().loginWithSocial(socialLogin, lang);
    notifyListeners();
    return results;
  }

  Future<VerificationResult> otpVerification(
      OtpVerification otpVerification, String token) async {
    final results =
        await AuthServices().otpVerification(otpVerification, token);
    notifyListeners();
    return results;
  }
}
