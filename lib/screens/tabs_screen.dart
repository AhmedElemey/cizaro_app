import 'package:cizaro_app/screens/home_screen.dart';
import 'package:cizaro_app/screens/mycart_screen.dart';
import 'package:cizaro_app/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class TabsScreen extends StatefulWidget {
  static final routeName = '/tabs-screen';
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Widget> _pages = [
    HomeScreen(),
     // Put Here Search Screen and remove Container.
    Container(child: Center(child: Text('Search'))),
    MyCartScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffE8E8E8),
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(showSelectedLabels: true,showUnselectedLabels: true,
              selectedItemColor: Color(0xff3A559F),unselectedItemColor: Colors.grey,
            currentIndex: _selectedPageIndex,
            backgroundColor: Colors.white,
            selectedLabelStyle: TextStyle(color: Color(0xff3A559F)),
            unselectedLabelStyle: TextStyle(color:  Colors.grey),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(CupertinoIcons.house,
                    color: _selectedPageIndex == 0 ? Color(0xff3A559F) : Colors.grey)
              ),
              BottomNavigationBarItem(
                label: 'Search',
                  icon: Icon(CupertinoIcons.search,
                    color:
                    _selectedPageIndex == 1 ? Color(0xff3A559F) : Colors.grey)
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                  icon: SvgPicture.asset('assets/images/cart.svg',
                    width: MediaQuery.of(context).size.width * 0.03,
                    height: MediaQuery.of(context).size.height * 0.03,
                    color:
                    _selectedPageIndex == 2 ? Color(0xff3A559F) : Colors.grey)
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                  icon: Icon(CupertinoIcons.person_solid,
                      color:
                      _selectedPageIndex == 3 ? Color(0xff3A559F) : Colors.grey)
                ),
            ],
            onTap: (index) => setState(() => _selectedPageIndex = index)
          ),
        ),
      ),
    );
  }
}
