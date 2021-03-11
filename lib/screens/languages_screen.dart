import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguagesScreen extends StatefulWidget {
  static const routeName = '/change-lang-screen';

  @override
  _ChangeLanguagesScreenState createState() => _ChangeLanguagesScreenState();
}

class _ChangeLanguagesScreenState extends State<ChangeLanguagesScreen> {
  checkArabic({bool isArabic}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isArabic', true);
    setState(() {
      EasyLocalization.of(context).locale = Locale('ar', 'EG');
    });
  }

  checkEnglish({bool isArabic}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isArabic', false);
    setState(() {
      EasyLocalization.of(context).locale = Locale('en', 'US');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Choose your language',
                textScaleFactor: MediaQuery.of(context).size.width * 0.0036,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  checkArabic(isArabic: true);
                  pushNewScreenWithRouteSettings(context,
                      settings: RouteSettings(name: TabsScreen.routeName),
                      screen: TabsScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: Card(
                  elevation: 1.5,
                  child: ListTile(
                    leading: Text('🇪🇬',
                        textScaleFactor:
                            MediaQuery.of(context).size.height * 0.003),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text('عربي',
                          textScaleFactor:
                              MediaQuery.of(context).size.width * 0.0036,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () {
                  checkEnglish(isArabic: false);
                  pushNewScreenWithRouteSettings(context,
                      settings: RouteSettings(name: TabsScreen.routeName),
                      screen: TabsScreen(),
                      withNavBar: false,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                },
                child: Card(
                  elevation: 1.5,
                  child: ListTile(
                    leading: Text('🇺🇸',
                        textScaleFactor:
                            MediaQuery.of(context).size.height * 0.003),
                    trailing: Text('English',
                        textScaleFactor:
                            MediaQuery.of(context).size.width * 0.0036,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
