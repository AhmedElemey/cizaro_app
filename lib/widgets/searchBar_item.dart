import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarItem extends StatefulWidget {
  final String productName, imgUrl, productCategory, iconAdd, iconMinus;
  final double totalPrice, productPrice;
  int productAvailability;
  String productQuantity;
  SearchBarItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.iconAdd,
      this.iconMinus,
      this.totalPrice,
      this.productAvailability,
      this.productQuantity});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchBarItem> {
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.productQuantity = quantityController.text;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: Card(
          elevation: 4,
          child: Container(
            height: MediaQuery.of(context).size.height * .15,
            padding: const EdgeInsets.only(top: 5, right: 8, left: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  widget.imgUrl,
                  height: MediaQuery.of(context).size.height * 0.135,
                  width: MediaQuery.of(context).size.width * 0.23,
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
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName,
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.5,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
