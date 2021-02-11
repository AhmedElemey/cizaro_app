import 'dart:async';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');
    var _duration = new Duration(seconds: 3);
    if (firstTime != null && !firstTime) {
      // Not first time
      return new Timer(_duration, navigationPageHome);
    } else {
      prefs.setBool('first_time', false);
      return new Timer(_duration, navigationPageWel);
    }
  }

  void navigationPageHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        TabsScreen.routeName, (Route<dynamic> route) => false);
  }

  void navigationPageWel() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff05080F), Color(0xff395A9A)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft)),
        child: Center(
            child: Padding(
                padding: const EdgeInsets.only(left: 23),
                child: Image.asset('assets/images/cizaro_logo.png',
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.4))),
      ),
    );
  }
}
