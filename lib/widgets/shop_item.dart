import 'dart:io';

import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ShopItem extends StatefulWidget {
  final String productName, imgUrl, productCategory;
  final double totalPrice, productPrice, productStars, productPriceAfter;
  final int productQuantity, productId;
  int isFav = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;
  ShopItem(
      {this.productName,
      this.productStars,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.totalPrice,
      this.productPriceAfter,
      this.onAddToCart,
      this.onAddToFavorite,
      this.productQuantity,
      this.productId});

  @override
  _ShopItemState createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  FToast fToast;
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
  void initState() {
    //   Future.microtask(() => getHomeData());
    super.initState();
    fToast = FToast();
    fToast.init(context); // de 3ashan awel lama aload el screen t7mel el data
  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavViewModel>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3,
          top: SizeConfig.blockSizeVertical * 1),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: SizeConfig.blockSizeVertical * 18,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 1,
                right: SizeConfig.blockSizeHorizontal * 1,
                top: SizeConfig.blockSizeVertical * 1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 1,
                      bottom: SizeConfig.blockSizeVertical * 1),
                  child: Container(
                    width: SizeConfig.blockSizeHorizontal * 30,
                    height: SizeConfig.blockSizeVertical * 20,
                    child: Image.network(
                      widget.imgUrl,
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
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 57,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 2),
                        child: Text(
                          widget.productName,
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1.5,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                            color: Color(0xff515C6F),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 2),
                        child: Text(
                          widget.productCategory ?? '',
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1.1,
                          style: GoogleFonts.poppins(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff515C6F),
                          ),
                        ),
                      ),
                      widget.productPriceAfter == widget.productPrice
                          ? Container(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * .5,
                                  left: SizeConfig.blockSizeHorizontal * 2),
                              child: Text(
                                widget.productPrice.toString() + ' le'.tr(),
                                // textScaleFactor:
                                //     MediaQuery.of(context).textScaleFactor *
                                //         1.15,
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
                                        top: SizeConfig.blockSizeVertical * .5,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Text(
                                      widget.productPrice.toString() +
                                          ' le'.tr(),
                                      // textScaleFactor: MediaQuery.of(context)
                                      //         .textScaleFactor *
                                      //     1.15,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  4,
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * .5,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Text(
                                      widget.productPriceAfter.toString() +
                                          ' le'.tr(),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4,
                                      ),
                                      // textScaleFactor: MediaQuery.of(context)
                                      //         .textScaleFactor *
                                      //     1.15,
                                    ),
                                  )
                                ],
                              ),
                            ),

                      // Container(
                      //   padding: EdgeInsets.only(top: 10, left: 10),
                      //   child: Text(
                      //     widget.productPrice.toString() + ' LE',
                      //     style: TextStyle(fontWeight: FontWeight.bold),
                      //     textScaleFactor:
                      //         MediaQuery.of(context).textScaleFactor * 1.1,
                      //   ),
                      // ),
                      Container(
                        // padding: EdgeInsets.only(
                        //   top: SizeConfig.blockSizeVertical * .5,
                        // ),
                        child: Row(
                          children: [
                            // Container(
                            //   width: MediaQuery.of(context).size.width * .25,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         child: CircleAvatar(
                            //           radius: 15,
                            //           backgroundColor: Colors.black12,
                            //           child: Container(
                            //             padding: EdgeInsets.only(bottom: 10),
                            //             child: Icon(
                            //               Icons.minimize,
                            //               size: 20,
                            //               color: Color(0xff707070),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Spacer(),
                            //       Container(
                            //         child: Container(
                            //           child: Text(
                            //             widget.productQuantity.toString(),
                            //             textScaleFactor: MediaQuery.of(context)
                            //                     .textScaleFactor *
                            //                 1.5,
                            //           ),
                            //         ),
                            //       ),
                            //       Spacer(),
                            //       Container(
                            //         padding: EdgeInsets.only(right: 5),
                            //         child: CircleAvatar(
                            //           radius: 15,
                            //           backgroundColor: Colors.black12,
                            //           child: Container(
                            //             padding: EdgeInsets.only(bottom: 2),
                            //             child: Icon(
                            //               Icons.add,
                            //               size: 20,
                            //               color: Color(0xff707070),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Spacer(),
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
                                        //  widget.isFav = 0;
                                        // final fav = Provider.of<FavViewModel>(context, listen: true);
                                        // fav.deleteFavProduct(
                                        //     index, fav.favProductModel[index].id);
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
                                          color: Color(0xffFF6969),
                                          size: SizeConfig.blockSizeHorizontal *
                                              3)
                                      : Icon(Icons.favorite_border_outlined,
                                          size: SizeConfig.blockSizeHorizontal *
                                              3),
                                ),
                                // GestureDetector(
                                //     onTap: () {
                                //       widget.onAddToFavorite();
                                //       showFavToast();
                                //     },
                                //     child: Icon(Icons.favorite_border,
                                //         size: 25, color: Color(0xff707070))),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 2),
                                GestureDetector(
                                    onTap: () {
                                      widget.onAddToCart();
                                      showCartToast();
                                    },
                                    child: SvgPicture.asset(
                                        'assets/images/cart.svg',
                                        width:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        height:
                                            SizeConfig.blockSizeVertical * 2))
                              ],
                            )
                            // Container(
                            //   width: SizeConfig.blockSizeHorizontal * 15,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         padding: EdgeInsets.only(
                            //             left:
                            //                 SizeConfig.blockSizeHorizontal * 1,
                            //             right:
                            //                 SizeConfig.blockSizeHorizontal * 1,
                            //             top: SizeConfig.blockSizeVertical * .5),
                            //         child: Container(
                            //           padding: EdgeInsets.only(
                            //               bottom: SizeConfig.blockSizeVertical *
                            //                   1.5),
                            //           child: GestureDetector(
                            //             onTap: () {
                            //               final productFav = ProductFav(
                            //                   id: widget.productId,
                            //                   name: widget.productName,
                            //                   mainImg: widget.imgUrl,
                            //                   price: widget.productPrice,
                            //                   categoryName:
                            //                       widget.productCategory);
                            //               showFavToast();
                            //               fav.addProductToFav(productFav);
                            //             },
                            //             child: Icon(
                            //               Icons.favorite,
                            //               size: SizeConfig.blockSizeHorizontal *
                            //                   5.5,
                            //               color: Color(0xff707070),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       Spacer(),
                            //       Container(
                            //         child: Container(
                            //           padding: EdgeInsets.only(bottom: 1.5),
                            //           child: Icon(
                            //             Icons.shopping_cart,
                            //             size:
                            //                 SizeConfig.blockSizeHorizontal * 6,
                            //             color: Color(0xff707070),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
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
