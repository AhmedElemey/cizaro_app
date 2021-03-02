import 'package:cizaro_app/screens/orders_screen.dart';
import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class FinishedOrder extends StatefulWidget {
  static final routeName = '/orders-screen';

  @override
  _FinishedOrderState createState() => _FinishedOrderState();
}

class _FinishedOrderState extends State<FinishedOrder> {
  // Future<bool> _onBackPressed() {
  //   return showDialog(
  //         context: context,
  //         builder: (context) => new AlertDialog(
  //           title: new Text('Are you sure?'),
  //           content: new Text('Do you want to exit an App'),
  //           actions: <Widget>[
  //             new GestureDetector(
  //               onTap: () => Navigator.of(context).pop(false),
  //               child: Text("NO"),
  //             ),
  //             SizedBox(height: 16),
  //             new GestureDetector(
  //               onTap: () => Navigator.of(context).pop(true),
  //               child: Text("YES"),
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: false);
    cart.cartProductModel.removeRange(0, cart.cartProductModel.length);
    // cart.deleteTable();
    cart.getTotalPrice();
    return WillPopScope(
      onWillPop: () async {
        await pushNewScreenWithRouteSettings(context,
            settings: RouteSettings(
              name: TabsScreen.routeName,
            ),
            screen: TabsScreen(),
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.fade);
        return true;
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 15,
                height: SizeConfig.blockSizeVertical * 15,
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
                    size: SizeConfig.blockSizeVertical * 7),
              ),
              Text('Order Placed!',
                  // textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.5,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.safeBlockHorizontal * 5,
                  )),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 6,
                    vertical: SizeConfig.blockSizeVertical * 2),
                child: Text(
                    'Your order was placed successfully. For more details, check All My Orders page under Profile tab.',
                    // textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 5,
                    )),
              ),
              GestureDetector(
                onTap: () => pushNewScreenWithRouteSettings(context,
                    settings: RouteSettings(name: OrderScreen.routeName),
                    screen: OrderScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.fade),
                child: Container(
                  padding: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal * 4),
                  width: SizeConfig.blockSizeHorizontal * 40,
                  height: SizeConfig.blockSizeVertical * 6,
                  decoration: BoxDecoration(
                      color: Color(0xff3A559F),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 3),
                        child: Text(
                          "MY ORDERS",
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1,
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 3,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: SizeConfig.blockSizeHorizontal * 5,
                          color: Color(0xff3A559F),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 4)
            ],
          ),
        ),
      ),
    );
  }
}
