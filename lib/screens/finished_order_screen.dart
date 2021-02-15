import 'package:cizaro_app/screens/orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class FinishedOrder extends StatelessWidget {
  static final routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Icon(Icons.check,
                  color: Theme.of(context).primaryColor,
                  size: MediaQuery.of(context).size.height * 0.06),
            ),
            Text('Order Placed!',
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.5,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                  'Your order was placed successfully. For more details, check All My Orders page under Profile tab.',
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3,
                  style: const TextStyle()),
            ),
            GestureDetector(
              onTap: () => pushNewScreenWithRouteSettings(context,
                  settings: RouteSettings(name: OrderScreen.routeName),
                  screen: OrderScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.fade),
              child: Container(
                padding: EdgeInsets.only(right: 10),
                width: MediaQuery.of(context).size.width * .4,
                height: MediaQuery.of(context).size.height * .058,
                decoration: BoxDecoration(
                    color: Color(0xff3A559F),
                    borderRadius: BorderRadius.circular(25.0)),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "MY ORDERS",
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 15,
                        color: Color(0xff3A559F),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
