import 'dart:async';

import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
    pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: TabsScreen.routeName),
        screen: TabsScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  void navigationPageWel() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: LoginScreen.routeName),
        screen: LoginScreen(),
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.fade);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff05080F), Color(0xff395A9A)],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft)),
        child: Center(
            child: Padding(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
                child: Image.asset('assets/images/cizaro_logo.png',
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 80,
                    height: SizeConfig.blockSizeVertical * 40))),
      ),
    );
  }
}
