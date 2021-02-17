import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductDetailItem extends StatelessWidget {
  final String productName, imgUrl;
  final double productPrice, productPriceAfter, productStar;
  const ProductDetailItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.productStar});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        elevation: 1,
        child: Container(
          height: MediaQuery.of(context).size.height * .95,
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .18,
                fit: BoxFit.contain,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.only(right: 15, top: 5),
                child: Text(
                  productName,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
                ),
              ),
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    productPriceAfter == productPrice
                        ? Container(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              productPrice.toString() + ' LE',
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 0.85,
                            ),
                          )
                        : Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: Text(
                                    productPrice.toString() + ' LE',
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            0.85,
                                    style: TextStyle(
                                        color: Colors.red,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5, left: 5),
                                  child: Text(
                                    productPriceAfter.toString() + ' LE',
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            0.85,
                                  ),
                                )
                              ],
                            ),
                          ),
                    // Text(
                    //   productPrice.toString() + " LE",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    //   textScaleFactor:
                    //       MediaQuery.of(context).textScaleFactor * 1,
                    // ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                width: MediaQuery.of(context).size.width * .3,
                child: Row(
                  children: [
                    Icon(Icons.favorite_border_outlined),
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width * .12,
                      height: MediaQuery.of(context).size.height * .03,
                      decoration: BoxDecoration(
                          color: Color(0xffFF6969),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.only(left: 5),
                          ),
                          Text(
                            productStar.toString(),
                            style: TextStyle(color: Colors.white),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset('assets/images/cart.svg',
                        width: MediaQuery.of(context).size.width * 0.028,
                        height: MediaQuery.of(context).size.height * 0.028,
                        color: Colors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
