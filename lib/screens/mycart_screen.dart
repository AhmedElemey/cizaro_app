import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCartScreen extends StatefulWidget {
  static final routeName = '/my-cart-screen';

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      // positionedToastBuilder: (context, child) {
      //   return Positioned(
      //     child: child,
      //     bottom: 16.0,
      //     left: 16.0,
      //   );
      // } da law 3ayz tezbat el postion ele hayzhar feh
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("My Cart"),
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
                  productName: "TreeCode",
                  productCategory: "men fashion",
                  productPrice: 65,
                  totalPrice: 49.99,
                  productQuantity: 3.toString(),
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
                  GestureDetector(
                    onTap: () {
                      return showToast();
                      // Fluttertoast.showToast(
                      //   msg: "This is Center Short Toast",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM,
                      //   backgroundColor: Colors.red,
                      //   timeInSecForIosWeb: 1,
                      //   textColor: Colors.white,
                      //   fontSize: 16.0);
                    },
                    child: Container(
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
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
