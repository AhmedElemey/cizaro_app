import 'dart:io';
import 'dart:math';

import 'package:cizaro_app/main.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final String productName, imgUrl, categoryName, offerImg;
  final int productId;
  final double productPrice, productPriceAfter, discount;
  final double stars;
  int isFav = 0;
  int inCart = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;
  Offer offer;

  ProductItem(
      {Key key,
      this.productId,
      this.productName,
      this.categoryName,
      this.imgUrl,
      this.offerImg,
      this.discount,
      this.productPrice,
      this.productPriceAfter,
      this.stars,
      this.isFav,
      this.inCart,
      this.offer,
      this.onAddToCart,
      this.onAddToFavorite})
      : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> with WidgetsBindingObserver {
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    // de 3ashan awel lama aload el screen t7mel el data
  }

  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
  }

  showFavAlreadyToast(BuildContext context) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: Colors.white),
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

  checkCartItems(BuildContext context) async {
    final cart = Provider.of<CartViewModel>(context, listen: false);
    cart.cartProductModel.forEach((element) {
      if (widget.productId == element.id) {
        setState(() {
          widget.inCart = 1;
        });
      } else {
        setState(() {
          widget.inCart = 0;
        });
      }
    });
  }

  showFavToast(BuildContext context) {
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

  showInCartAlreadyToast(BuildContext context) {
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

  showCartToast(BuildContext context) {
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
    // checkFavItems(context);
    checkCartItems(context);

    return Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3,
        ),
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 33,
          child: Column(
            children: [
              widget.discount == 0.0 || widget.discount == null
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 10,
                      shadowColor: Colors.grey[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: Image.network(
                                widget.imgUrl,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Platform.isAndroid
                                      ? Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          ),
                                        )
                                      : CupertinoActivityIndicator();
                                },
                                width: SizeConfig.blockSizeHorizontal * 33,
                                height: SizeConfig.blockSizeVertical * 19,
                                fit: BoxFit.fill,
                              )),
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2,
                                left: SizeConfig.blockSizeHorizontal * 1),
                            width: SizeConfig.blockSizeHorizontal * 35,
                            height: SizeConfig.blockSizeVertical * 3,
                            child: Text(
                              widget.productName,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3),
                            ),
                          ),
                          widget.productPriceAfter == widget.productPrice ||
                                  widget.offer == null ||
                                  widget.productPriceAfter == 0
                              ? Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * .005,
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      left: SizeConfig.blockSizeHorizontal * 1),
                                  child: Text(
                                    widget.productPrice.toString() + ' le'.tr(),
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4),
                                  ),
                                )
                              : Container(
                                  width: SizeConfig.blockSizeHorizontal * 33,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1),
                                        child: Text(
                                          widget.productPrice.toString() +
                                              ' le'.tr(),
                                          style: TextStyle(
                                              fontFamily: 'NeusaNextStd',
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3,
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: SizeConfig.blockSizeVertical *
                                                .5,
                                            right:
                                                SizeConfig.blockSizeHorizontal *
                                                    2,
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1),
                                        child: Text(
                                          widget.productPriceAfter.toString() +
                                              ' le'.tr(),
                                          style: TextStyle(
                                            fontFamily: 'NeusaNextStd',
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          Container(
                              padding: EdgeInsets.only(
                                  bottom: SizeConfig.blockSizeVertical * .5,
                                  left: SizeConfig.blockSizeHorizontal * 1,
                                  right: SizeConfig.blockSizeHorizontal * 1),
                              width: SizeConfig.blockSizeHorizontal * 30,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //hager's work
                                  // Consumer<FavViewModel>(
                                  //     builder: (_, favProvider, child) {
                                  //   bool isAdded = favProvider
                                  //       .checkFavItems(widget.productId);
                                  //   return IconButton(
                                  //       onPressed: () {
                                  //         if (isAdded) {
                                  //           // favProvider.deleteFavProduct(index, productId)
                                  //         } else {
                                  //           final productFav = ProductFav(
                                  //               id: widget.productId,
                                  //               name: widget.productName,
                                  //               mainImg: widget.imgUrl,
                                  //               price: widget.productPrice,
                                  //               categoryName:
                                  //                   widget.categoryName,
                                  //               isFav: 1);
                                  //           favProvider
                                  //               .addProductToFav(productFav);
                                  //           showFavToast(globalScaffoldKey
                                  //               .currentContext);
                                  //           showFavToast(globalScaffoldKey
                                  //               .currentContext);
                                  //         }
                                  //       },
                                  //       icon: Icon(
                                  //         isAdded == false
                                  //             ? Icons.favorite_border
                                  //             : Icons.favorite,
                                  //         color: isAdded == true
                                  //             ? Colors.red
                                  //             : Colors.grey,
                                  //       ));
                                  // }),
                                  GestureDetector(
                                    onTap: () async {
                                      if (widget.isFav == 1) {
                                        setState(() {
                                          showFavAlreadyToast(context);
                                          // widget.isFav = 0;
                                          //print("already here");
                                        });
                                      } else {
                                        setState(() {
                                          widget.isFav = 1;
                                          widget.onAddToFavorite();
                                          //  print(" here");
                                          showFavToast(context);
                                        });
                                      }
                                    },
                                    child: widget.isFav == 1
                                        ? Icon(Icons.favorite,
                                            color: Color(0xffFF6969))
                                        : Icon(Icons.favorite_border_outlined),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      widget.onAddToCart();
                                      showCartToast(
                                          globalScaffoldKey.currentContext);
                                    },
                                    child: Container(
                                      child: SvgPicture.asset(
                                          'assets/images/cart.svg',
                                          width:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                          height:
                                              SizeConfig.blockSizeVertical * 3,
                                          color: Colors.grey[900]),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )
                  : Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 10,
                          shadowColor: Colors.grey[900],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.network(
                                    widget.imgUrl,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes
                                              : null,
                                        ),
                                      );
                                    },
                                    width: SizeConfig.blockSizeHorizontal * 33,
                                    height: SizeConfig.blockSizeVertical * 19,
                                    fit: BoxFit.fill,
                                  )),
                              Container(
                                width: SizeConfig.blockSizeHorizontal * 35,
                                height: SizeConfig.blockSizeVertical * 3,
                                padding: EdgeInsets.only(
                                    right: SizeConfig.blockSizeHorizontal * 2,
                                    left: SizeConfig.blockSizeHorizontal * 2),
                                child: Text(
                                  widget.productName,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                  ),
                                ),
                              ),
                              widget.productPriceAfter == widget.productPrice
                                  ? Container(
                                      padding: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                          left: SizeConfig.blockSizeHorizontal *
                                              2),
                                      child: Text(
                                        widget.productPrice.toString() +
                                            ' le'.tr(),
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  4,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2),
                                            child: Text(
                                              widget.productPrice.toString() +
                                                  ' le'.tr(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.red,
                                                  fontSize: SizeConfig
                                                          .safeBlockHorizontal *
                                                      3,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2,
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    2),
                                            child: Text(
                                              widget.productPriceAfter
                                                      .toString() +
                                                  ' le'.tr(),
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    3,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 1,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 1),
                                  width: SizeConfig.blockSizeHorizontal * 30,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Consumer<FavViewModel>(
                                      //     builder: (_, favProvider, child) {
                                      //   bool isAdded = favProvider
                                      //       .checkFavItems(widget.productId);
                                      //   return IconButton(
                                      //       onPressed: () {
                                      //         if (isAdded) {
                                      //           // favProvider.deleteFavProduct(index, productId)
                                      //         } else {
                                      //           final productFav = ProductFav(
                                      //               id: widget.productId,
                                      //               name: widget.productName,
                                      //               mainImg: widget.imgUrl,
                                      //               price: widget.productPrice,
                                      //               categoryName:
                                      //                   widget.categoryName,
                                      //               isFav: 1);
                                      //           favProvider.addProductToFav(
                                      //               productFav);
                                      //           showFavToast(globalScaffoldKey
                                      //               .currentContext);
                                      //         }
                                      //       },
                                      //       icon: Icon(
                                      //         isAdded == false
                                      //             ? Icons.favorite_border
                                      //             : Icons.favorite,
                                      //         color: isAdded == true
                                      //             ? Colors.red
                                      //             : Colors.grey,
                                      //       ));
                                      // }),
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.isFav == 1) {
                                            setState(() {
                                              showFavAlreadyToast(context);
                                            });
                                          } else {
                                            setState(() {
                                              widget.isFav = 1;
                                              widget.onAddToFavorite();
                                              showFavToast(context);
                                            });
                                          }
                                        },
                                        child: widget.isFav == 1
                                            ? Icon(Icons.favorite,
                                                color: Color(0xffFF6969))
                                            : Icon(
                                                Icons.favorite_border_outlined),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (widget.inCart == 1) {
                                            setState(() {
                                              showInCartAlreadyToast(
                                                  globalScaffoldKey
                                                      .currentContext);
                                            });
                                          } else {
                                            setState(() {
                                              widget.inCart = 1;
                                              widget.onAddToCart();
                                              showCartToast(globalScaffoldKey
                                                  .currentContext);
                                            });
                                          }
                                        },
                                        child: Container(
                                          child: widget.inCart == 1
                                              ? SvgPicture.asset(
                                                  'assets/images/cart.svg',
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2.7,
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      2.6,
                                                  color: Colors.green[900])
                                              : SvgPicture.asset(
                                                  'assets/images/cart.svg',
                                                  width: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2.7,
                                                  height: SizeConfig
                                                          .blockSizeVertical *
                                                      2.6,
                                                  color: Colors.grey[900]),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        Positioned(
                          child: SvgPicture.asset(
                            'assets/images/offer.svg',
                            width: SizeConfig.blockSizeHorizontal * 11,
                            height: SizeConfig.blockSizeVertical * 11,
                          ),
                          top: -1 * SizeConfig.blockSizeVertical,
                          left: -1 * SizeConfig.blockSizeHorizontal,
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
            ],
          ),
        ));
  }
}
