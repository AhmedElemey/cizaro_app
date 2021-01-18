import 'package:cizaro_app/widgets/address_item.dart';
import 'package:flutter/material.dart';

class AddressBookScreen extends StatelessWidget {
  static final routeName = '/addressbook-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.only(left: 10),
            child: Container(
              color: Colors.white,
              child: Image.asset(
                "assets/images/cizaro_logo2.png",
              ),
            )),
        title: Center(
          child: Text("Address Book"),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: EdgeInsets.only(left: 5, top: 15),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Noha Hamza",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Nohahamza@email.com",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .6,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) => AddressItem(
                        strName: "John Doe",
                        strNumber: "No 123",
                        strMain: "Main Street",
                        cityName: "City Name",
                        countryName: "Country",
                      )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35), label: 'Home'),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 35,
              ),
              label: 'Search'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 35), label: 'Cart'),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
