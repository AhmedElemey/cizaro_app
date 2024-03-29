import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchItem extends StatefulWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice, productPriceAfter;
  int productAvailability;
  String productQuantity;

  SearchItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.productCategory,
      this.iconAdd,
      this.iconMinus,
      this.totalPrice,
      this.productAvailability,
      this.productQuantity});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.productQuantity = quantityController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .18,
            width: MediaQuery.of(context).size.width * .1,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 10, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.network(
                      widget.imgUrl,
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
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          widget.productName,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.5,
                        ),
                      ),
                      Container(
                        child: Text(
                          widget.productCategory ?? '',
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                      ),

                      widget.productPriceAfter == widget.productPrice
                          ? Container(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                widget.productPrice.toString() + ' LE',
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1,
                              ),
                            )
                          : Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(top: 5, right: 10),
                                    child: Text(
                                      widget.productPrice.toString() + ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.1,
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 5, right: 10),
                                    child: Text(
                                      widget.productPriceAfter.toString() +
                                          ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.1,
                                    ),
                                  )
                                ],
                              ),
                            ),
                      // Container(
                      //   child: Text(
                      //     widget.productPrice.toString() + ' LE',
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //     textScaleFactor:
                      //         MediaQuery.of(context).textScaleFactor * 1.1,
                      //   ),
                      // ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .2,
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Icon(
                                        Icons.favorite,
                                        size: 25,
                                        color: Color(0xff707070),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: SvgPicture.asset(
                                        'assets/images/cart.svg',
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
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
