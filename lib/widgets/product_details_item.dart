import 'dart:io';
import 'dart:math';

import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailItem extends StatefulWidget {
  final String productName, imgUrl;
  final double productPrice, productPriceAfter, productStar, discount;
  final int productId;
  int isFav = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;
  ProductDetailItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.discount,
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
      padding: EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 3),
      child: Card(
        elevation: 3,
        child: Container(
          child: widget.discount == 0.0 || widget.discount == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.imgUrl,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Platform.isAndroid
                            ? Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                ),
                              )
                            : CupertinoActivityIndicator();
                      },
                      width: SizeConfig.blockSizeHorizontal * 33,
                      height: SizeConfig.blockSizeVertical * 16,
                    ),
                    Container(
                      width: SizeConfig.blockSizeHorizontal * 35,
                      height: SizeConfig.blockSizeVertical * 4,
                      padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * .3,
                          right: SizeConfig.blockSizeHorizontal * 2,
                          left: SizeConfig.blockSizeHorizontal * 2),
                      child: Text(
                        widget.productName,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.safeBlockHorizontal * 4,
                        ),
                      ),
                    ),
                    widget.productPriceAfter == widget.productPrice ||
                            widget.discount == 0
                        ? Container(
                            padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 1,
                                left: SizeConfig.blockSizeHorizontal * 2,
                                top: SizeConfig.blockSizeVertical * 1),
                            child: Text(
                              widget.productPrice.toString() + ' LE',
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                              ),
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
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 3,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 3),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 1),
                                  child: Text(
                                    widget.productPriceAfter.toString() + ' LE',
                                    style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 2,
                          top: SizeConfig.blockSizeHorizontal * 1),
                      width: SizeConfig.blockSizeHorizontal * 30,
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
                            height: SizeConfig.blockSizeVertical * 3,
                            width: SizeConfig.blockSizeHorizontal * 12,
                            decoration: BoxDecoration(
                                color: Color(0xffFF6969),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star,
                                      size: SizeConfig.blockSizeHorizontal * 4,
                                      color: Colors.white),
                                  SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * .3),
                                  Text(widget.productStar.toString() ?? 0.0,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 3,
                                      ),
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1)
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //   width: SizeConfig.blockSizeHorizontal * 12,
                          //   height: SizeConfig.blockSizeHorizontal * 3,
                          //   decoration: BoxDecoration(
                          //       color: Color(0xffFF6969),
                          //       borderRadius: BorderRadius.circular(20)),
                          //   child: Row(
                          //     children: [
                          //       Container(
                          //         child: Icon(
                          //           Icons.star,
                          //           size: SizeConfig.blockSizeHorizontal * 1,
                          //           color: Colors.white,
                          //         ),
                          //         padding: EdgeInsets.only(
                          //             left: SizeConfig.blockSizeHorizontal * 1),
                          //       ),
                          //       Text(
                          //         widget.productStar.toString(),
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: SizeConfig.safeBlockHorizontal * 3,
                          //         ),
                          //         textScaleFactor:
                          //             MediaQuery.of(context).textScaleFactor * 1,
                          //       )
                          //     ],
                          //   ),
                          // ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              widget.onAddToCart();
                              showCartToast();
                            },
                            child: Container(
                              child: SvgPicture.asset('assets/images/cart.svg',
                                  width: SizeConfig.blockSizeHorizontal * 3,
                                  height: SizeConfig.blockSizeVertical * 3,
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
                          width: SizeConfig.blockSizeHorizontal * 35,
                          height: SizeConfig.blockSizeVertical * 16,
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            );
                          },
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 35,
                          height: SizeConfig.blockSizeVertical * 4,
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * .2,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            widget.productName,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                          ),
                        ),
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 33,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.productPriceAfter == widget.productPrice
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.safeBlockHorizontal *
                                              2,
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                          top:
                                              SizeConfig.blockSizeVertical * 1),
                                      child: Text(
                                        widget.productPrice.toString() + ' LE',
                                        style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  3,
                                        ),
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
                                            .75,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.blockSizeVertical * 1,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Flexible(
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              widget.productPrice.toString() +
                                                  ' LE',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            SizedBox(
                                                width: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2),
                                            Text(
                                              widget.productPriceAfter
                                                      .toString() +
                                                  ' LE',
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    3,
                                              ),
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                          .textScaleFactor *
                                                      1.2,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          width: SizeConfig.blockSizeHorizontal * 30,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (widget.isFav == 1) {
                                    setState(() {
                                      showFavAlreadyToast();
                                    });
                                  } else {
                                    setState(() {
                                      widget.isFav = 1;
                                      widget.onAddToFavorite();
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
                                height: SizeConfig.blockSizeVertical * 3,
                                width: SizeConfig.blockSizeHorizontal * 12,
                                decoration: BoxDecoration(
                                    color: Color(0xffFF6969),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.star,
                                          size: SizeConfig.blockSizeHorizontal *
                                              4,
                                          color: Colors.white),
                                      SizedBox(
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  .3),
                                      Text(widget.productStar.toString() ?? 0.0,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3,
                                          ),
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1)
                                    ],
                                  ),
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
                                      width: SizeConfig.blockSizeHorizontal * 5,
                                      height:
                                          SizeConfig.blockSizeHorizontal * 5,
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
                        width: SizeConfig.blockSizeHorizontal * 11,
                        height: SizeConfig.blockSizeVertical * 11,
                      ),
                      top: -SizeConfig.blockSizeVertical * 1,
                      left: -SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Positioned(
                      child: Transform.rotate(
                        angle: -pi / 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * .4),
                          child: Text(
                            widget.discount.toString() + "%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: SizeConfig.safeBlockVertical * 2.3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      top: 1 * SizeConfig.blockSizeVertical,
                      left: 1 * SizeConfig.blockSizeHorizontal,
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
