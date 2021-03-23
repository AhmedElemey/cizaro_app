import 'package:cizaro_app/screens/home_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/screens/mycart_screen.dart';
import 'package:cizaro_app/screens/profile_screen.dart';
import 'package:cizaro_app/screens/search_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class TabsScreen extends StatelessWidget {
  static final routeName = '/tabs-screen';
  const TabsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.simple, // Choose the nav bar style with this property.
    );
  }
}

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    SearchScreen(),
    MyCartScreen(),
    FutureBuilder<String>(
        future: getToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.data == '' || snapshot.data == null) {
            return LoginScreen();
          } else {
            return ProfileScreen();
          }
        }),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ('home'.tr()),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.search),
      title: ('search'.tr()),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.cart),
      title: ('cart'.tr()),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person_solid),
      title: ('profile'.tr()),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
  ];
}
