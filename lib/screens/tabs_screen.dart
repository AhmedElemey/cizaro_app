import 'package:cizaro_app/screens/home_screen.dart';
import 'package:cizaro_app/screens/mycart_screen.dart';
import 'package:cizaro_app/screens/profile_screen.dart';
import 'package:cizaro_app/screens/search_screen.dart';
import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
// Ios Version
// class TabsScreen extends StatelessWidget {
//   static final routeName = '/tabs-screen';
//
//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//       tabBuilder: (context ,index) => CupertinoPageScaffold(child: Center(child: index == 0 ? Text('Home') : Text('Search'))), tabBar: CupertinoTabBar(
//       items: [
//         BottomNavigationBarItem(icon: Icon(CupertinoIcons.house),label: 'Home'),
//         BottomNavigationBarItem(icon: Icon(CupertinoIcons.search),label: 'Search'),
//         BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart),label: 'Cart'),
//         BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid),label: 'Profile')
//       ],
//     ),
//
//     );
//   }
//
// }

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
      popAllScreensOnTapOfSelectedTab: true,
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

List<Widget> _buildScreens() {
  return [
    HomeScreen(),
    SearchScreen(),
    MyCartScreen(),
    ProfileScreen(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.search),
      title: ("Search"),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.cart),
      title: ("Cart"),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person_solid),
      title: ("Profile"),
      activeColor: Color(0xff3A559F),
      inactiveColor: CupertinoColors.systemGrey,
    ),
  ];
}

// class TabsScreen extends StatefulWidget {
//   static final routeName = '/tabs-screen';
//   @override
//   _TabsScreenState createState() => _TabsScreenState();
// }
//
// Future<String> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('token');
// }
//
// class _TabsScreenState extends State<TabsScreen> {
//   GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   int _selectedPageIndex = 0;
//   final List<Widget> _pages = [
//     HomeScreen(),
//     SearchScreen(),
//     MyCartScreen(),
//     ProfileScreen(),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomNavigator(
//         navigatorKey: navigatorKey,
//         home: IndexedStack(
//           index: _selectedPageIndex,
//           children: <Widget>[..._pages],
//         ),
//         //Specify your page route [PageRoutes.materialPageRoute] or [PageRoutes.cupertinoPageRoute]
//         pageRoute: PageRoutes.materialPageRoute,
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: Color(0xffE8E8E8),
//           ),
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(20.0),
//             topLeft: Radius.circular(20.0),
//           ),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(20.0),
//             topLeft: Radius.circular(20.0),
//           ),
//           child: BottomNavigationBar(
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               selectedItemColor: Color(0xff3A559F),
//               unselectedItemColor: Colors.grey,
//               currentIndex: _selectedPageIndex,
//               backgroundColor: Colors.white,
//               selectedLabelStyle: TextStyle(color: Color(0xff3A559F)),
//               unselectedLabelStyle: TextStyle(color: Colors.grey),
//               type: BottomNavigationBarType.fixed,
//               items: [
//                 BottomNavigationBarItem(
//                     label: 'Home',
//                     icon: Icon(CupertinoIcons.house,
//                         color: _selectedPageIndex == 0
//                             ? Color(0xff3A559F)
//                             : Colors.grey)),
//                 BottomNavigationBarItem(
//                     label: 'Search',
//                     icon: Icon(CupertinoIcons.search,
//                         color: _selectedPageIndex == 1
//                             ? Color(0xff3A559F)
//                             : Colors.grey)),
//                 BottomNavigationBarItem(
//                     label: 'Cart',
//                     icon: SvgPicture.asset('assets/images/cart.svg',
//                         width: MediaQuery.of(context).size.width * 0.03,
//                         height: MediaQuery.of(context).size.height * 0.03,
//                         color: _selectedPageIndex == 2
//                             ? Color(0xff3A559F)
//                             : Colors.grey)),
//                 BottomNavigationBarItem(
//                     label: 'Profile',
//                     icon: Icon(CupertinoIcons.person_solid,
//                         color: _selectedPageIndex == 3
//                             ? Color(0xff3A559F)
//                             : Colors.grey)),
//               ],
//               onTap: (index) {
//                 navigatorKey.currentState.maybePop();
//                 setState(() => _selectedPageIndex = index);
//               }),
//         ),
//       ),
//     );
//   }
// }
