import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutItem extends StatelessWidget {
  final String productName, imgUrl, productCategory;
  final double productPrice;
  final String productSizeSpecs;
  final Color productColorSpecs;

  const CheckoutItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.productColorSpecs,
      this.productSizeSpecs});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Card(
        elevation: 2,
        child: Container(
          height: MediaQuery.of(context).size.height * .1,
          padding: EdgeInsets.only(left: 10, right: 10, top: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.network(imgUrl)),
              ),
              Flexible(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(productName ?? "",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor *
                                      1.25),
                        ),
                        Container(
                          child: Text(productCategory ?? "",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(productPrice.toString() + ' LE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.1),
                        Row(
                          children: [
                            Text(productSizeSpecs == "" ? '' : "Size: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1),
                            Text(
                                productSizeSpecs == ""
                                    ? ''
                                    : productSizeSpecs.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff3A559F)),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1),
                            Text(
                                productColorSpecs == Color(0x000000ff) ||
                                        productColorSpecs == null
                                    ? ''
                                    : " , Color: ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1),
                            productColorSpecs == null
                                ? Container()
                                : CircleAvatar(
                                    radius: 8,
                                    foregroundColor: productColorSpecs,
                                    backgroundColor: productColorSpecs)
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
    );
  }
}
