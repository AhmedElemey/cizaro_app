import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  static final routeName = '/tabs-screen';

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context ,index) => CupertinoPageScaffold(child: Center(child: index == 0 ? Text('Home') : Text('Search'))), tabBar: CupertinoTabBar(
      items: [
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.house),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: 'Search'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid),label: 'Profile')
      ],
    ),

    );
  }

}