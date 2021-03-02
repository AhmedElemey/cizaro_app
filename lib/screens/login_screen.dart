import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart' as apple;
import 'package:cizaro_app/main.dart';
import 'package:cizaro_app/model/SignUpModel.dart';
import 'package:cizaro_app/model/loginModel.dart';
import 'package:cizaro_app/model/socialLoginModel.dart';
import 'package:cizaro_app/screens/forgetPassword_screen.dart';
import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:cizaro_app/services/auth_service.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/auth_view_model.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GoogleSignIn gSignIn = GoogleSignIn(scopes: ['email']);

class LoginScreen extends StatefulWidget {
  static final routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false, _obscureText = true;
  bool _isChecked = false, isSignIn = false, _fetching = false;
  var _currentItemSelectedGender;
  String birthDate;
  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _emailSignUpController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();
  TextEditingController _passwordSignUpController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _genderNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  AccessToken _accessToken;
  Map<String, dynamic> _userData;

  Future<void> _checkLogin() async {
    await Future.delayed(Duration(seconds: 1));
    _accessToken = await FacebookAuth.instance.isLogged;
    if (_accessToken != null) {
      saveFacebookToken(_accessToken.toString());
      await _getUserData();
    }

    _fetching = false;
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _getUserData() async {
    _userData = await FacebookAuth.instance
        .getUserData(fields: "id,email,name,picture,birthday,friends");
  }

  saveFacebookToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('facebook_token', token);
  }

  Future<void> _loginWithFacebook() async {
    try {
      setState(() {
        _fetching = true;
      });
      _accessToken = await FacebookAuth.instance.login();
      await _getUserData();
      setState(() {
        _fetching = false;
      });
      signUpWithFacebookButton();
    } catch (e, s) {
      setState(() {
        _fetching = false;
      });
      if (e is FacebookAuthException) {
        switch (e.errorCode) {
          case FacebookAuthErrorCode.OPERATION_IN_PROGRESS:
            print("FacebookAuthErrorCode.OPERATION_IN_PROGRESS");
            break;
          case FacebookAuthErrorCode.CANCELLED:
            print("FacebookAuthErrorCode.CANCELLED");
            break;
          case FacebookAuthErrorCode.FAILED:
            print("FacebookAuthErrorCode.FAILED");
            break;
        }
      }
    }
  }

  saveFacebookId(String faceId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('facebook_id', faceId);
  }

  Future loginWithFacebookButton() async {
    final login = Provider.of<AuthViewModel>(context, listen: false);
    final loginSocial =
        SocialLogin(facebookGoogleId: _userData['id'], socialType: 'facebook');
    setState(() => showSpinner = true);
    await login.loginSocial(loginSocial, 'en').then((_) {
      setState(() => showSpinner = false);
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }).catchError((error) {
      print(error);
      setState(() => showSpinner = false);
    });
  }

  Future loginWithAppleButton(String appleId) async {
    final login = Provider.of<AuthViewModel>(context, listen: false);
    final loginSocial =
        SocialLogin(facebookGoogleId: appleId, socialType: 'apple');
    setState(() => showSpinner = true);
    await login.loginSocial(loginSocial, 'en').then((_) {
      setState(() => showSpinner = false);
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }).catchError((error) {
      print(error);
      setState(() => showSpinner = false);
    });
  }

  Future signUpWithFacebookButton() async {
    final signUp = Provider.of<AuthViewModel>(context, listen: false);
    final signUpSocial = SignUp(
        email: _userData['email'],
        fullName: _userData['name'],
        username: _userData['name'],
        facebookId: _userData['id']);
    setState(() => showSpinner = true);
    print(_userData['email']);
    saveFacebookId(_userData['id']);
    await signUp
        .signUpSocial(signUpSocial, 'en')
        .catchError((error) => print(error));
    int statusCode = await getStatusCode();
    setState(() => showSpinner = false);
    print('Status-Code : $statusCode');
    if (statusCode == 400) {
      loginWithFacebookButton();
    } else {
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }
  }

  Future signUpWithAppleButton(
      String email, String fullName, String userName, String appleId) async {
    final signUp = Provider.of<AuthViewModel>(context, listen: false);
    final signUpSocial = SignUp(
        email: email,
        fullName: fullName,
        username: userName,
        facebookId: appleId);
    setState(() => showSpinner = true);
    saveFacebookId(appleId);
    await signUp
        .signUpSocial(signUpSocial, 'en')
        .catchError((error) => print(error));
    int statusCode = await getStatusCode();
    setState(() => showSpinner = false);
    print('Status-Code : $statusCode');
    if (statusCode == 400) {
      loginWithAppleButton(appleId);
    } else {
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  controlSgnIn(GoogleSignInAccount gSignInAccount) async {
    if (gSignInAccount != null) {
      if (!mounted) return;
      setState(() {
        isSignIn = true;
      });
    } else {
      if (!mounted) return;
      setState(() {
        isSignIn = false;
      });
    }
  }

  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<AuthServices>(context, listen: false);
      final user = await authService
          .signInWithApple(scopes: [apple.Scope.email, apple.Scope.fullName]);
      print('uid: ${user.uid}');
      signUpWithAppleButton(
          user.email, user.displayName, user.displayName, user.uid);
    } catch (e) {
      // TODO: Show alert here
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
    gSignIn.onCurrentUserChanged.listen((gSignInAccount) {
      controlSgnIn(gSignInAccount);
    }, onError: (gError) => print(gError));
    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount) {
      controlSgnIn(gSignInAccount);
    }).catchError((gError) {
      print(gError);
    });
  }

  loginUser() {
    gSignIn.signIn().then((result) {
      result.authentication.then((googleKey) {
        signUpWithGoogleButton();
      }).catchError((err) {
        print(err);
      });
    }).catchError((err) {
      print(err);
    });
  }

  Future signUpButton() async {
    if (!_formKey2.currentState.validate()) {
      return;
    }
    _formKey2.currentState.save();
    final postRegister = Provider.of<AuthViewModel>(context, listen: false);
    final register = SignUp(
        username: _userNameController.text,
        fullName: _fullNameController.text,
        email: _emailSignUpController.text,
        newPassword1: _passwordSignUpController.text,
        newPassword2: _confirmPasswordController.text,
        birthDate: _birthDateController.text,
        gender: _currentItemSelectedGender == 'Male' ? 1 : 2);
    setState(() => showSpinner = true);
    await postRegister.customerRegisterData(register, 'en').then((_) {
      setState(() => showSpinner = false);
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }).catchError((error) {
      print(error);
      Platform.isIOS ? _showIosDialog() : _showAndroidDialog();
      setState(() => showSpinner = false);
    });
  }

  Future loginButton() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final postRegister = Provider.of<AuthViewModel>(context, listen: false);
    final loginCustomer = Login(
        usernameEmail: _emailLoginController.text,
        password: _passwordLoginController.text);
    setState(() => showSpinner = true);
    await postRegister.login(loginCustomer, 'en').then((_) {
      setState(() => showSpinner = false);
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }).catchError((error) {
      print(error);
      Platform.isIOS ? _showIosDialog() : _showAndroidDialog();
      setState(() => showSpinner = false);
    });
  }

  Future<String> getGoogleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('google_id');
  }

  // check login before
  Future loginWithGoogleButton() async {
    final login = Provider.of<AuthViewModel>(context, listen: false);
    String id = await getGoogleId();
    final loginSocial = SocialLogin(facebookGoogleId: id, socialType: 'google');
    setState(() => showSpinner = true);
    await login.loginSocial(loginSocial, 'en').then((_) {
      setState(() => showSpinner = false);
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }).catchError((error) {
      print(error);
      setState(() => showSpinner = false);
    });
  }

  _showAndroidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Something Wrong Try Again!',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            FlatButton(
              child: Text('Close',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                showSpinner = false;
              },
            ),
          ],
        );
      },
    );
  }

  _showIosDialog() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Something Wrong Try Again!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  showSpinner = false;
                },
              ),
            ],
          );
        });
  }

  String validateName(String value) {
    if (value.isEmpty) {
      return 'FullName is Required';
    }
    return null;
  }

  String validateUserName(String value) {
    if (value.isEmpty) {
      return 'UserName is Required';
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is Required';
    }
    return null;
  }

  String validateBirthDate(String value) {
    if (value.isEmpty) {
      return 'BirthDate is Required';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value != _passwordSignUpController.text)
      return 'Must Be Match with Password';
    else if (value.isEmpty) {
      return 'Confirmed Password is Required';
    }
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'E-mail is Required';
    } else if (!regex.hasMatch(value)) return 'E-mail is not correct';
    return null;
  }

  Widget tabsWidgets() {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Container(
          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  labelPadding: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal * 10,
                      left: SizeConfig.blockSizeHorizontal * 12,
                      bottom: SizeConfig.blockSizeVertical * 1),
                  indicatorWeight: SizeConfig.blockSizeHorizontal * .7,
                  indicatorColor: Color(0xff294794),
                  labelColor: Color(0xff294794),
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: <Widget>[
                    Text(
                      'Login',
                      // textScaleFactor:
                      //     MediaQuery.of(context).textScaleFactor * 1.4,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'SignUp',
                      // textScaleFactor:
                      //     MediaQuery.of(context).textScaleFactor * 1.4,
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                showSpinner
                    ? Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator()
                            : CircularProgressIndicator())
                    : Form(
                        key: _formKey,
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeVertical * 80,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 3),
                                TextFieldBuild(
                                    obscureText: false,
                                    readOnly: false,
                                    textInputType: TextInputType.emailAddress,
                                    hintText: 'Email Address or User Name',
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.2,
                                    ),
                                    lineCount: 1,
                                    validator: validateEmail,
                                    textEditingController:
                                        _emailLoginController),
                                const SizedBox(height: 10),
                                TextFieldBuild(
                                    obscureText: _obscureText,
                                    readOnly: false,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    hintText: 'Password',
                                    lineCount: 1,
                                    validator: validatePassword,
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.2,
                                    ),
                                    textEditingController:
                                        _passwordLoginController,
                                    icon: _obscureText
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                    onClick: () => _toggle()),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2),
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    child: CupertinoButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5,
                                          ),
                                        ),
                                        onPressed: () => loginButton())),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2),
                                GestureDetector(
                                  // ForgetPasswordScreen
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: ForgetPasswordScreen.routeName),
                                      screen: ForgetPasswordScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Text('Forgot your password?',
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal *
                                                3.5,
                                      )
                                      // textScaleFactor:
                                      //     MediaQuery.of(context).textScaleFactor *
                                      //         1.1
                                      ),
                                ),
                                Divider(
                                    thickness: 0.8,
                                    color: Colors.grey,
                                    indent: SizeConfig.blockSizeHorizontal * 7,
                                    endIndent:
                                        SizeConfig.blockSizeHorizontal * 7),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2),
                                GestureDetector(
                                  onTap: () => loginWithGoogleButton(),
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                              'assets/images/google.png'),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  6),
                                          Text('Login with Google',
                                              // textScaleFactor:
                                              //     MediaQuery.of(context)
                                              //             .textScaleFactor *
                                              //         1.3,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      5,
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => loginWithFacebookButton(),
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff3A559F)),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset('assets/images/face.png'),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  6),
                                          Text('Login with Facebook',
                                              // textScaleFactor:
                                              //     MediaQuery.of(context)
                                              //             .textScaleFactor *
                                              //         1.3,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      5,
                                                  color: Color(0xff3A559F)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (appleSignInAvailable.isAvailable)
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: apple.AppleSignInButton(
                                      cornerRadius: 0.0,
                                      style: apple
                                          .ButtonStyle.black, // style as needed
                                      type: apple.ButtonType
                                          .continueButton, // style as needed
                                      onPressed: () =>
                                          _signInWithApple(context),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                showSpinner
                    ? Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator()
                            : CircularProgressIndicator())
                    : Form(
                        key: _formKey2,
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 100,
                          height: SizeConfig.blockSizeHorizontal * 80,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 2),
                                TextFieldBuild(
                                    obscureText: false,
                                    readOnly: false,
                                    textInputType: TextInputType.emailAddress,
                                    hintText: 'Email Address',
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.2,
                                    ),
                                    lineCount: 1,
                                    validator: validateEmail,
                                    textEditingController:
                                        _emailSignUpController),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              5,
                                          top: SizeConfig.blockSizeVertical *
                                              1.5),
                                      child: TextFieldBuild(
                                          obscureText: false,
                                          readOnly: false,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          hintText: 'Full Name',
                                          textStyle: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3.2,
                                          ),
                                          lineCount: 1,
                                          validator: validateName,
                                          textEditingController:
                                              _fullNameController),
                                    )),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2,
                                          top: SizeConfig.blockSizeVertical *
                                              1.5),
                                      child: TextFieldBuild(
                                          obscureText: false,
                                          readOnly: false,
                                          textInputType:
                                              TextInputType.emailAddress,
                                          hintText: 'User Name',
                                          textStyle: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3.2,
                                          ),
                                          lineCount: 1,
                                          validator: validateUserName,
                                          textEditingController:
                                              _userNameController),
                                    )),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1.5),
                                TextFieldBuild(
                                    obscureText: _obscureText,
                                    readOnly: false,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    hintText: 'Password',
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.2,
                                    ),
                                    lineCount: 1,
                                    validator: validatePassword,
                                    textEditingController:
                                        _passwordSignUpController,
                                    icon: _obscureText
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash,
                                    onClick: () => _toggle()),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1.5),
                                TextFieldBuild(
                                    obscureText: true,
                                    readOnly: false,
                                    textInputType:
                                        TextInputType.visiblePassword,
                                    hintText: 'Confirm password',
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.2,
                                    ),
                                    lineCount: 1,
                                    validator: validateConfirmPassword,
                                    textEditingController:
                                        _confirmPasswordController),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1.5),
                                Row(
                                  children: [
                                    // Expanded(
                                    //     child: Container(
                                    //         width: MediaQuery.of(context)
                                    //                 .size
                                    //                 .width *
                                    //             0.5,
                                    //         height: MediaQuery.of(context)
                                    //                 .size
                                    //                 .height *
                                    //             0.057,
                                    //         margin: const EdgeInsets.only(
                                    //             left: 20, bottom: 10),
                                    //         decoration: BoxDecoration(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(8),
                                    //             border: Border.all(
                                    //                 color: Colors.black54,
                                    //                 width: 1)),
                                    //         child: Center(
                                    //           child: DropdownButtonFormField(
                                    //               iconSize: MediaQuery.of(context).size.width *
                                    //                   0.08,
                                    //               iconEnabledColor:
                                    //                   Colors.black54,
                                    //               style: const TextStyle(
                                    //                   color: Colors.black),
                                    //               isExpanded: true,
                                    //               hint: Padding(
                                    //                   padding: const EdgeInsets.only(
                                    //                       left: 5),
                                    //                   child: Text('Gender',
                                    //                       style: const TextStyle(
                                    //                           color: Colors
                                    //                               .black54))),
                                    //               decoration: InputDecoration(
                                    //                   contentPadding:
                                    //                       EdgeInsets.all(3),
                                    //                   enabledBorder: UnderlineInputBorder(
                                    //                       borderSide: BorderSide(
                                    //                           color:
                                    //                               Colors.white)),
                                    //                   isDense: true),
                                    //               validator: (value) =>
                                    //                   value == null ? 'Choose Gender' : null,
                                    //               items: ['Male', 'Female']
                                    //                   .map((label) => DropdownMenuItem(
                                    //                         child: Padding(
                                    //                           padding:
                                    //                               const EdgeInsets
                                    //                                       .only(
                                    //                                   left: 15),
                                    //                           child: Text(label
                                    //                               .toString()),
                                    //                         ),
                                    //                         value: label,
                                    //                       ))
                                    //                   .toList(),
                                    //               onChanged: (newValueSelected) {
                                    //                 setState(() =>
                                    //                     _currentItemSelectedGender =
                                    //                         newValueSelected);
                                    //                 print(
                                    //                     _currentItemSelectedGender);
                                    //               },
                                    //               value: _currentItemSelectedGender),
                                    //         ))),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              5),
                                      child: TextFieldBuild(
                                        obscureText: false,
                                        readOnly: true,
                                        hintText: 'Gender',
                                        textStyle: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  3.2,
                                        ),
                                        lineCount: 1,
                                        textEditingController:
                                            _genderNameController,
                                        icon: CupertinoIcons.chevron_down,
                                        onClick: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext builder) {
                                                return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .copyWith()
                                                                .size
                                                                .height /
                                                            3,
                                                    child: CupertinoPicker(
                                                      onSelectedItemChanged:
                                                          (int index) {
                                                        int indexItem =
                                                            index + 1;
                                                        indexItem == 1
                                                            ? _genderNameController
                                                                .text = 'Male'
                                                            : _genderNameController
                                                                    .text =
                                                                'Female';
                                                      },
                                                      itemExtent: 50,
                                                      children: [
                                                        Text(
                                                          'Male',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                5,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Female',
                                                          style: TextStyle(
                                                            fontSize: SizeConfig
                                                                    .safeBlockHorizontal *
                                                                5,
                                                          ),
                                                        ),
                                                      ],
                                                    ));
                                              });
                                        },
                                      ),
                                    )),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  5,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: TextFieldBuild(
                                        obscureText: false,
                                        readOnly: true,
                                        hintText: 'Birth Date',
                                        textStyle: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  3.2,
                                        ),
                                        lineCount: 1,
                                        validator: validateBirthDate,
                                        textEditingController:
                                            _birthDateController,
                                        icon: CupertinoIcons.calendar,
                                        onClick: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (BuildContext builder) {
                                                return Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .copyWith()
                                                                .size
                                                                .height /
                                                            3,
                                                    child: CupertinoDatePicker(
                                                        initialDateTime:
                                                            DateTime.now(),
                                                        onDateTimeChanged: (DateTime
                                                                newDate) =>
                                                            _birthDateController
                                                                    .text =
                                                                '${newDate.year}-${newDate.month}-${newDate.day}',
                                                        use24hFormat: true,
                                                        minuteInterval: 1,
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date));
                                              });
                                        },
                                      ),
                                    )),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 2),
                                    width: SizeConfig.blockSizeHorizontal * 80,
                                    child: CupertinoButton(
                                        color: Theme.of(context).primaryColor,
                                        child: Text(
                                          'SignUp',
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5,
                                          ),
                                        ),
                                        onPressed: () => signUpButton())),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
                                Divider(
                                    thickness: 0.8,
                                    color: Colors.grey,
                                    indent: SizeConfig.blockSizeHorizontal * 7,
                                    endIndent:
                                        SizeConfig.blockSizeHorizontal * 7),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
                                GestureDetector(
                                  onTap: () => loginUser(),
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    color: Colors.blue,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                              'assets/images/google.png'),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4),
                                          Text('SignUp with Google',
                                              // textScaleFactor:
                                              //     MediaQuery.of(context)
                                              //             .textScaleFactor *
                                              //         1.3,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      5,
                                                  color: Colors.white))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _loginWithFacebook(),
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    margin: EdgeInsets.only(
                                        top:
                                            SizeConfig.blockSizeVertical * 1.5),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xff3A559F)),
                                        color: Colors.white),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Image.asset('assets/images/face.png'),
                                          SizedBox(
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4),
                                          Text('SignUp with Facebook',
                                              // textScaleFactor:
                                              //     MediaQuery.of(context)
                                              //             .textScaleFactor *
                                              //         1.3,
                                              style: TextStyle(
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      5,
                                                  color: Color(0xff3A559F)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (appleSignInAvailable.isAvailable)
                                  Container(
                                    width: SizeConfig.blockSizeHorizontal * 70,
                                    height: SizeConfig.blockSizeVertical * 6,
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: apple.AppleSignInButton(
                                      cornerRadius: 0.0,
                                      style: apple
                                          .ButtonStyle.black, // style as needed
                                      type: apple
                                          .ButtonType.signIn, // style as needed
                                      onPressed: () =>
                                          _signInWithApple(context),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Image.asset('assets/images/cizaro_logo2.png',
                      alignment: Alignment.center,
                      width: SizeConfig.blockSizeHorizontal * 75,
                      height: SizeConfig.blockSizeVertical * 23)),
              Text(
                'Welcome',
                // textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.7,
                style: TextStyle(
                    fontSize: SizeConfig.safeBlockHorizontal * 7,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700),
              ),
              tabsWidgets(),
            ],
          ),
        ),
      ),
    );
  }

  Future<int> getStatusCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('status_code');
  }

  Future signUpWithGoogleButton() async {
    final signUp = Provider.of<AuthViewModel>(context, listen: false);
    final signUpSocial = SignUp(
        email: gSignIn.currentUser.email,
        fullName: gSignIn.currentUser.displayName,
        username: gSignIn.currentUser.displayName,
        googleId: gSignIn.currentUser.id);
    setState(() => showSpinner = true);
    print(gSignIn.currentUser.email);
    saveGoogleId(gSignIn.currentUser.id);
    await signUp
        .signUpSocial(signUpSocial, 'en')
        .catchError((error) => print(error));
    int statusCode = await getStatusCode();
    setState(() => showSpinner = false);
    print('Status-Code : $statusCode');
    if (statusCode == 400) {
      loginWithGoogleButton();
    } else {
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: TabsScreen.routeName),
          screen: TabsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     TabsScreen.routeName, (Route<dynamic> route) => false);
    }
  }

  saveGoogleId(String googleId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('google_id', googleId);
  }
}
