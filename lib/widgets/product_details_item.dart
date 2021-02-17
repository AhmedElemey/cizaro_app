import 'dart:math';

import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetailItem extends StatefulWidget {
  final String productName, imgUrl;
  final double productPrice, productPriceAfter, productStar;
  final int productId;
  int isFav = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;
  Offer offer;
  ProductDetailItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.offer,
      this.isFav,
      this.onAddToCart,
      this.productId,
      this.onAddToFavorite,
      this.productStar});

  @override
  _ProductDetailItemState createState() => _ProductDetailItemState();
}

class _ProductDetailItemState extends State<ProductDetailItem> {
  FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    // de 3ashan awel lama aload el screen t7mel el data
  }

  checkFavItems(BuildContext context) async {
    final fav = Provider.of<FavViewModel>(context, listen: false);
    fav.favProductModel.forEach((element) {
      if (widget.productId == element.id) {
        setState(() {
          widget.isFav = 1;
        });
      } else {
        setState(() {
          widget.isFav = 0;
        });
      }
    });
  }

  showFavToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Added to Favorite", style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showFavAlreadyToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Already in Favorites",
              style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showCartToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Added to Cart", style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Card(
      elevation: 1,
      child: Container(
        height: MediaQuery.of(context).size.height * .95,
        padding: EdgeInsets.only(left: 15),
        child: widget.offer.discount == 0.0 || widget.offer.discount == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    widget.imgUrl,
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
                      widget.productName,
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .33,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.productPriceAfter == widget.productPrice
                            ? Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  widget.productPrice.toString() + ' LE',
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          0.85,
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
                                        widget.productPrice.toString() + ' LE',
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
                                            0.85,
                                        style: TextStyle(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 5, left: 5),
                                      child: Text(
                                        widget.productPriceAfter.toString() +
                                            ' LE',
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
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
                        GestureDetector(
                          onTap: () async {
                            if (widget.isFav == 1) {
                              setState(() {
                                showFavAlreadyToast();
                                // widget.isFav = 0;
                                //print("already here");
                              });
                            } else {
                              setState(() {
                                widget.isFav = 1;
                                widget.onAddToFavorite();
                                //  print(" here");
                                showFavToast();
                              });
                            }
                          },
                          child: widget.isFav == 1
                              ? Icon(Icons.favorite, color: Color(0xffFF6969))
                              : Icon(Icons.favorite_border_outlined),
                        ),
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
                                widget.productStar.toString(),
                                style: TextStyle(color: Colors.white),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor * 1,
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            widget.onAddToCart();
                            showCartToast();
                          },
                          child: Container(
                            child: SvgPicture.asset('assets/images/cart.svg',
                                width: MediaQuery.of(context).size.width * 0.03,
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: Colors.grey[900]),
                          ),
                        ),
                        // SvgPicture.asset('assets/images/cart.svg',
                        //     width: MediaQuery.of(context).size.width * 0.028,
                        //     height: MediaQuery.of(context).size.height * 0.028,
                        //     color: Colors.grey),
                      ],
                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.imgUrl,
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
                          widget.productName,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .33,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            widget.productPriceAfter == widget.productPrice
                                ? Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text(
                                      widget.productPrice.toString() + ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          0.85,
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
                                            widget.productPrice.toString() +
                                                ' LE',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    0.85,
                                            style: TextStyle(
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              EdgeInsets.only(top: 5, left: 5),
                                          child: Text(
                                            widget.productPriceAfter
                                                    .toString() +
                                                ' LE',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
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
                            GestureDetector(
                              onTap: () async {
                                if (widget.isFav == 1) {
                                  setState(() {
                                    showFavAlreadyToast();
                                    // widget.isFav = 0;
                                    //print("already here");
                                  });
                                } else {
                                  setState(() {
                                    widget.isFav = 1;
                                    widget.onAddToFavorite();
                                    //  print(" here");
                                    showFavToast();
                                  });
                                }
                              },
                              child: widget.isFav == 1
                                  ? Icon(Icons.favorite,
                                      color: Color(0xffFF6969))
                                  : Icon(Icons.favorite_border_outlined),
                            ),
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
                                    widget.productStar.toString(),
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            1,
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                widget.onAddToCart();
                                showCartToast();
                              },
                              child: Container(
                                child: SvgPicture.asset(
                                    'assets/images/cart.svg',
                                    width: MediaQuery.of(context).size.width *
                                        0.03,
                                    height: MediaQuery.of(context).size.height *
                                        0.03,
                                    color: Colors.grey[900]),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    child: SvgPicture.asset(
                      'assets/images/offer.svg',
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    top: -3,
                    left: -3,
                  ),
                  Positioned(
                    child: Transform.rotate(
                      angle: -pi / 4,
                      child: Text(
                        widget.offer.discount.toString() + "%",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    top: 12,
                    left: 4,
                  )
                ],
              ),
      ),
    ));
  }
}
