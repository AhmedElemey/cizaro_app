import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearchItem extends StatefulWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice, productPriceAfter;
  final int productAvailability;
  String productQuantity;
  final VoidCallback onAddToCart;
  final VoidCallback onAddToFavorite;

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

  showToast() {
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
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * .18,
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          //width: MediaQuery.of(context).size.width * .1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.network(
                  widget.imgUrl,
                  width: MediaQuery.of(context).size.width * 0.3,
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
                padding: const EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width * .57,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.5,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.productCategory ?? '',
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.1,
                    ),

                    widget.productPriceAfter == widget.productPrice
                        ? Container(
                            padding: EdgeInsets.only(right: 10, top: 10),
                            child: Text(widget.productPrice.toString() + ' LE',
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor * 1),
                          )
                        : Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 5, right: 5),
                                  child: Text(
                                      widget.productPrice.toString() + ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5, right: 5),
                                  child: Text(
                                      widget.productPriceAfter.toString() +
                                          ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1),
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
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              widget.onAddToFavorite();
                              showFavToast();
                            },
                            child: Icon(Icons.favorite_border,
                                size: 25, color: Color(0xff707070))),
                        const SizedBox(width: 8),
                        GestureDetector(
                            onTap: () {
                              widget.onAddToCart();
                              showToast();
                            },
                            child: SvgPicture.asset('assets/images/cart.svg',
                                width: MediaQuery.of(context).size.width * 0.04,
                                height:
                                    MediaQuery.of(context).size.height * 0.035))
                      ],
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
