import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutItem extends StatelessWidget {
  final String productName, imgUrl, productCategory;
  final double productPrice;
  final int productSpecs;

  const CheckoutItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.productSpecs});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
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
                  width: MediaQuery.of(context).size.width * .6,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              productName ?? "",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.5,
                            ),
                          ),
                          Container(
                            child: Text(
                              productCategory ?? "",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              productPrice.toString() + ' LE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              productSpecs.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                          ),
                        ],
                      ),
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
