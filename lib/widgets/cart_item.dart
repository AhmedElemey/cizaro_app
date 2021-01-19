import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice;
  final int productQuantity;

  const CartItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.iconAdd,
      this.iconMinus,
      this.totalPrice,
      this.productQuantity});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .14,
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.asset(imgUrl),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              productName,
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.5,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              productPrice.toString() + ' LE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Text(
                          productCategory,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.minimize_outlined,
                                        size: 25,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: Icon(
                                        Icons.add,
                                        size: 25,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              height: MediaQuery.of(context).size.height * .06,
                              child: Column(
                                children: [
                                  Text(
                                    "TOTAL",
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            .7,
                                  ),
                                  Container(
                                    child: Text(
                                      totalPrice.toString() + ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.2,
                                      style:
                                          TextStyle(color: Color(0xff3A559F)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
