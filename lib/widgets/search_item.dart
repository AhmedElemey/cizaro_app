import 'dart:io';

import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice, productPriceAfter;
  final int productAvailability;
  String productQuantity;
  final int productId;
  int isFav = 0;
  int inCart = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;

  SearchItem(
      {this.productId,
      this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.productCategory,
      this.iconAdd,
      this.iconMinus,
      this.totalPrice,
      this.productAvailability,
      this.onAddToCart,
      this.onAddToFavorite,
      this.productQuantity});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  FToast fToast;
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    widget.productQuantity = quantityController.text;
    //  checkFavItems(context);
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

  showInCartAlreadyToast() {
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
          Text("Already In Cart", style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
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

  @override
  Widget build(BuildContext context) {
    checkFavItems(context);
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 5,
        right: SizeConfig.blockSizeHorizontal * 5,
      ),
      child: Card(
        elevation: 3,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 1,
                    horizontal: SizeConfig.blockSizeHorizontal * 1),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                        width: SizeConfig.blockSizeHorizontal * 20,
                        height: SizeConfig.blockSizeVertical * 17,
                        child: Image.network(widget.imgUrl, loadingBuilder:
                            (BuildContext context, Widget child,
                                ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Platform.isAndroid
                              ? Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes
                                        : null,
                                  ),
                                )
                              : CupertinoActivityIndicator();
                        }, fit: BoxFit.fitHeight)))),
            Container(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 3,
                  top: SizeConfig.blockSizeVertical * 1),
              width: SizeConfig.blockSizeHorizontal * 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * .5),
                  Text(
                    widget.productCategory ?? '',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * .5),
                  widget.productPriceAfter == widget.productPrice ||
                          widget.productPriceAfter == 0
                      ? Container(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * .10,
                              top: SizeConfig.blockSizeVertical * .10),
                          child: Text(
                            widget.productPrice.toString() + ' LE',
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            ),
                          ),
                        )
                      : Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * .05,
                                    right: SizeConfig.blockSizeHorizontal * 5),
                                child: Text(
                                    widget.productPrice.toString() + ' LE',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * .05,
                                    right:
                                        SizeConfig.blockSizeHorizontal * .05),
                                child: Text(
                                  widget.productPriceAfter.toString() + ' LE',
                                  style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                  SizedBox(height: SizeConfig.blockSizeVertical * .5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacer(),
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
                              //  print(" here");
                              showFavToast();
                            });
                          }
                        },
                        child: widget.isFav == 1
                            ? Icon(Icons.favorite,
                                color: Color(0xffFF6969),
                                size: SizeConfig.blockSizeHorizontal * 5)
                            : Icon(Icons.favorite_border_outlined,
                                size: SizeConfig.blockSizeHorizontal * 5),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
                      GestureDetector(
                        onTap: () async {
                          if (widget.inCart == 1) {
                            setState(() {
                              showInCartAlreadyToast();
                            });
                          } else {
                            setState(() {
                              widget.inCart = 1;
                              widget.onAddToCart();
                              showCartToast();
                            });
                          }
                        },
                        child: Container(
                          child: widget.inCart == 1
                              ? SvgPicture.asset('assets/images/cart.svg',
                                  width: SizeConfig.blockSizeHorizontal * 2.7,
                                  height: SizeConfig.blockSizeVertical * 2.6,
                                  color: Colors.green[900])
                              : SvgPicture.asset('assets/images/cart.svg',
                                  width: SizeConfig.blockSizeHorizontal * 2.7,
                                  height: SizeConfig.blockSizeVertical * 2.6,
                                  color: Colors.grey[900]),
                        ),
                      ),
                      // GestureDetector(
                      //     onTap: () {
                      //       widget.onAddToCart();
                      //       showCartToast();
                      //     },
                      //     child: SvgPicture.asset('assets/images/cart.svg',
                      //         width: SizeConfig.blockSizeHorizontal * 2.7,
                      //         height: SizeConfig.blockSizeVertical * 2.7))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
