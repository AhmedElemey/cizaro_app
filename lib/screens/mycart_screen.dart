import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MycartScreen extends StatelessWidget {
  static final routeName = '/mycart-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              "assets/images/logo.png",
              height: MediaQuery.of(context).size.height * .1,
            )),
        title: Center(
          child: Text("My Cart"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, top: 5),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Cart",
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff515C6F)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .65,
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (ctx, index) => CartItem(
                  imgUrl: "assets/images/collection.png",
                  productName: "Treecode",
                  productCategory: "men fashion",
                  productPrice: 65,
                  totalPrice: 49.99,
                  productQuantity: 1,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .07,
                    child: Column(
                      children: [
                        Text(
                          "TOTAL",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * .9,
                        ),
                        Spacer(),
                        Container(
                          child: Text(
                            '\$' + "45454",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.4,
                            style: TextStyle(color: Color(0xff3A559F)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                        color: Color(0xff3A559F),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: new EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "CHECKOUT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Color(0xff3A559F),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
