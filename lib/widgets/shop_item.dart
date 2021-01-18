import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopItem extends StatelessWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice;
  final int productQuantity;

  const ShopItem(
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
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .18,
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
                      Container(
                        child: Text(
                          productName,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.5,
                        ),
                      ),
                      Container(
                        child: Text(
                          productCategory,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          '\$' + productPrice.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.minimize,
                                          size: 20,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Container(
                                      child: Text(
                                        productQuantity.toString(),
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
                                            1.5,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * .15,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 20,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        size: 20,
                                        color: Color(0xff707070),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
