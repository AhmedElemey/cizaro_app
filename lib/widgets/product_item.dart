import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final String productName, imgUrl, categoryName;
  final int productId;
  final double productPrice, productPriceAfter;
  final double stars;
  int isFav = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;

  ProductItem(
      {this.productId,
      this.productName,
      this.categoryName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.stars,
      this.isFav,
      this.onAddToCart,
      this.onAddToFavorite});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  FToast fToast;

  @override
  void initState() {
    //   Future.microtask(() => getHomeData());
    // Future.microtask(() => checkFavItems());
    super.initState();

    fToast = FToast();
    fToast.init(context);
    // de 3ashan awel lama aload el screen t7mel el data
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
    ScreenUtil.init(context,
        allowFontScaling: false,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    // TODO: implement build
    final fav = Provider.of<FavViewModel>(context, listen: false);
    //  List favProducts = fav.favProductModel;
    checkFavItems(context);
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: Column(
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
                Image.network(
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
                  width: ScreenUtil()
                      .setWidth(MediaQuery.of(context).size.width * .3),
                  height: ScreenUtil()
                      .setHeight(MediaQuery.of(context).size.height * .19),
                  fit: BoxFit.fill,
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(10),
                      right: ScreenUtil().setWidth(10),
                      left: ScreenUtil().setWidth(10)),
                  child: Text(
                    widget.productName,
                    textScaleFactor: ScreenUtil.textScaleFactor * 1.2,
                  ),
                ),
                widget.productPriceAfter == widget.productPrice
                    ? Container(
                        padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(5),
                            right: ScreenUtil().setWidth(10),
                            left: ScreenUtil().setWidth(10)),
                        child: Text(
                          widget.productPrice.toString() + ' LE',
                          textScaleFactor: ScreenUtil.textScaleFactor * 1,
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5),
                                  right: ScreenUtil().setWidth(10),
                                  left: ScreenUtil().setWidth(10)),
                              child: Text(
                                widget.productPrice.toString() + ' LE',
                                textScaleFactor: ScreenUtil.textScaleFactor * 1,
                                style: TextStyle(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(5),
                                  right: ScreenUtil().setWidth(10),
                                  left: ScreenUtil().setWidth(10)),
                              child: Text(
                                widget.productPriceAfter.toString() + ' LE',
                                textScaleFactor: ScreenUtil.textScaleFactor * 1,
                              ),
                            )
                          ],
                        ),
                      ),
                Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 5, left: ScreenUtil().setWidth(10)),
                    width: ScreenUtil()
                        .setWidth(MediaQuery.of(context).size.width * .3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        GestureDetector(
                          onTap: () {
                            widget.onAddToCart();
                            showCartToast();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(10)),
                            child: SvgPicture.asset('assets/images/cart.svg',
                                width: MediaQuery.of(context).size.width * 0.03,
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                color: Colors.grey[900]),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
