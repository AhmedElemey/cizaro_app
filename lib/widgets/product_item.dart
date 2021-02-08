import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final String productName, imgUrl, categoryName;
  final int productId;
  final double productPrice, productPriceAfter;
  double stars;
  int isFav;

  ProductItem(
      {this.productId,
      this.productName,
      this.categoryName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfter,
      this.stars,
      this.isFav});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  FToast fToast;
  int productId;

  @override
  void initState() {
    //   Future.microtask(() => getHomeData());
    super.initState();
    fToast = FToast();
    fToast.init(context);
    // de 3ashan awel lama aload el screen t7mel el data
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final fav = Provider.of<FavViewModel>(context, listen: false);
    //  List favProducts = fav.favProductModel;

    return Container(
      child: Card(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * .05,
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          final productFav = ProductFav(
                              id: widget.productId,
                              name: widget.productName,
                              mainImg: widget.imgUrl,
                              price: widget.productPrice,
                              categoryName: widget.categoryName,
                              isFav: 1);

                          fav.addProductToFav(productFav);
                          showFavToast();
                        },
                        child: widget.isFav == 1
                            ? Icon(
                                Icons.favorite,
                                color: Color(0xffFF6969),
                              )
                            : Icon(Icons.favorite_border_outlined),
                      )
                    ],
                  )),
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
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .19,
                fit: BoxFit.contain,
              ),
              Container(
                padding: EdgeInsets.only(top: 5, right: 10),
                child: Text(
                  widget.productName,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.2,
                ),
              ),
              widget.productPriceAfter == widget.productPrice
                  ? Container(
                      padding: EdgeInsets.only(top: 5, right: 10),
                      child: Text(
                        widget.productPrice.toString() + ' LE',
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1.1,
                      ),
                    )
                  : Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 5, right: 10),
                            child: Text(
                              widget.productPrice.toString() + ' LE',
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                              style: TextStyle(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, right: 10),
                            child: Text(
                              widget.productPriceAfter.toString() + ' LE',
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                          )
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
