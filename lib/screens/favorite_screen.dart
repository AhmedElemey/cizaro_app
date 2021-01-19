import 'package:cizaro_app/widgets/favorite_item.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  static final routeName = '/favorite-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.only(left: 10),
            child: Image.asset(
              "assets/images/logo.png",
            )),
        title: Center(
          child: Text("Wishlist"),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * .8,
              child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (ctx, index) => FavoriteItem(
                        imgUrl: "assets/images/collection.png",
                        productName: "Treecode T-shirt",
                        productCategory: "men fashion",
                        productStar: "4.9",
                        productPrice: "4.45",
                      )),
            )
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
