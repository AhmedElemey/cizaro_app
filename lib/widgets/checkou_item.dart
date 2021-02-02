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
      padding: EdgeInsets.only(left: 8, right: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          elevation: 1.7,
          child: Container(
            height: MediaQuery.of(context).size.height * .1,
            padding: EdgeInsets.only(left: 10,right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: 10, top: 5, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.asset(imgUrl),
                  ),
                ),
                Flexible(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              productName ?? "",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.25,
                            ),
                          ),
                          Container(
                            child: Text(
                              productCategory ?? "",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            productPrice.toString() + ' LE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.1,
                          ),
                          Row(
                            children: [
                              Text(
                                "Size: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1,
                              ),
                              Text(
                                productSpecs.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3A559F)),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1,
                              ),
                            ],
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
