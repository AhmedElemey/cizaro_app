import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchBarItem extends StatefulWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice;
  int productAvailability;
  String productQuantity;
  final int productId;
  int isFav = 0;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;
  SearchBarItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.iconAdd,
      this.iconMinus,
      this.totalPrice,
      this.productAvailability,
      this.onAddToFavorite,
      this.onAddToCart,
      this.isFav,
      this.productId,
      this.productQuantity});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchBarItem> {
  FToast fToast;
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    widget.productQuantity = quantityController.text;
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
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .2,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
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
                Container(
                  padding: EdgeInsets.only(left: 15),
                  width: MediaQuery.of(context).size.width * .6,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            widget.productName,
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.5,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color: Color(0xffFF6969))
                                  : Icon(Icons.favorite_border_outlined),
                            ),
                            // GestureDetector(
                            //     onTap: () {
                            //       widget.onAddToFavorite();
                            //       showFavToast();
                            //     },
                            //     child: Icon(Icons.favorite_border,
                            //         size: 25, color: Color(0xff707070))),
                            const SizedBox(width: 10),
                            GestureDetector(
                                onTap: () {
                                  widget.onAddToCart();
                                  showCartToast();
                                },
                                child: SvgPicture.asset(
                                  'assets/images/cart.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
                                  height: MediaQuery.of(context).size.height *
                                      0.035,
                                  color: Colors.grey[900],
                                ))
                          ],
                        )
                        // Container(
                        //   padding: EdgeInsets.only(top: 10),
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         width: MediaQuery.of(context).size.width * .3,
                        //         child: Row(
                        //           children: [
                        //             Container(
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     int value = int.parse(
                        //                             quantityController.text) -
                        //                         1;
                        //                     widget.productQuantity =
                        //                         value.toString();
                        //                   });
                        //                 },
                        //                 child: CircleAvatar(
                        //                   radius: 15,
                        //                   backgroundColor: Colors.black12,
                        //                   child: Container(
                        //                     padding: EdgeInsets.only(bottom: 10),
                        //                     child: Icon(
                        //                       Icons.minimize,
                        //                       size: 20,
                        //                       color: Color(0xff707070),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               child: Container(
                        //                 padding: EdgeInsets.only(left: 2),
                        //                 width: MediaQuery.of(context).size.width *
                        //                     .1,
                        //                 child: TextField(
                        //                   controller: quantityController,
                        //                   keyboardType: TextInputType.number,
                        //                 ),
                        //               ),
                        //             ),
                        //             Container(
                        //               padding: EdgeInsets.only(right: 5),
                        //               child: GestureDetector(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     int value = int.parse(
                        //                             quantityController.text) +
                        //                         1;
                        //                     widget.productQuantity =
                        //                         value.toString();
                        //                   });
                        //                 },
                        //                 child: CircleAvatar(
                        //                   radius: 15,
                        //                   backgroundColor: Colors.black12,
                        //                   child: Container(
                        //                     padding: EdgeInsets.only(bottom: 2),
                        //                     child: Icon(
                        //                       Icons.add,
                        //                       size: 20,
                        //                       color: Color(0xff707070),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       Container(
                        //         width: MediaQuery.of(context).size.width * .2,
                        //         padding: EdgeInsets.only(left: 30),
                        //         child: Row(
                        //           children: [
                        //             Container(
                        //               padding: EdgeInsets.only(top: 5),
                        //               child: Container(
                        //                 padding: EdgeInsets.only(bottom: 10),
                        //                 child: Icon(
                        //                   Icons.favorite,
                        //                   size: 25,
                        //                   color: Color(0xff707070),
                        //                 ),
                        //               ),
                        //             ),
                        //             Spacer(),
                        //             Container(
                        //               child: Container(
                        //                 padding: EdgeInsets.only(bottom: 2),
                        //                 child: SvgPicture.asset(
                        //                   'assets/images/cart.svg',
                        //                   width:
                        //                       MediaQuery.of(context).size.width *
                        //                           0.03,
                        //                   height:
                        //                       MediaQuery.of(context).size.height *
                        //                           0.03,
                        //                 ),
                        //               ),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // )
                      ],
                    ),
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
