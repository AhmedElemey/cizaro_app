import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ShopItem extends StatefulWidget {
  final String productName, imgUrl, productCategory;
  final double totalPrice, productPrice, productStars;
  final int productQuantity, productId;

  const ShopItem(
      {this.productName,
      this.productStars,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.totalPrice,
      this.productQuantity,
      this.productId});

  @override
  _ShopItemState createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  FToast fToast;

  @override
  void initState() {
    //   Future.microtask(() => getHomeData());
    super.initState();
    fToast = FToast();
    fToast.init(context); // de 3ashan awel lama aload el screen t7mel el data
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
    final fav = Provider.of<FavViewModel>(context, listen: false);

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .18,
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
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
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.productPrice.toString() + ' LE',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .25,
                              child: Row(
                                children: [
                                  Container(
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Icon(
                                          Icons.minimize,
                                          size: 20,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Container(
                                      child: Text(
                                        widget.productQuantity.toString(),
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
                                            1.5,
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: Colors.black12,
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 2),
                                        child: Icon(
                                          Icons.add,
                                          size: 20,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * .15,
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(right: 5, top: 5),
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          final productFav = ProductFav(
                                              id: widget.productId,
                                              name: widget.productName,
                                              mainImg: widget.imgUrl,
                                              price: widget.productPrice,
                                              categoryName:
                                                  widget.productCategory);
                                          showFavToast();
                                          fav.addProductToFav(productFav);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          size: 20,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    child: Container(
                                      padding: EdgeInsets.only(bottom: 2),
                                      child: Icon(
                                        Icons.shopping_cart,
                                        size: 20,
                                        color: Color(0xff707070),
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
