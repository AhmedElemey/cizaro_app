import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartItem extends StatefulWidget {
  String productName,
      imgUrl,
      productCategory,
      iconAdd,
      iconMinus,
      productQuanitity;
  double totalPrice, productPrice;

  CartItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.iconAdd,
      this.iconMinus,
      this.totalPrice,
      this.productQuanitity});

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.productQuanitity = quantityController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          child: Container(
            height: MediaQuery.of(context).size.height * .15,
            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.asset(widget.imgUrl),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              widget.productName,
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.5,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              widget.productPrice.toString() + ' LE',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                          )
                        ],
                      ),
                      Container(
                        child: Text(
                          widget.productCategory,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        int value =
                                            int.parse(quantityController.text) -
                                                1;
                                        widget.productQuanitity =
                                            value.toString();
                                      });
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .07,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .07,
                                      padding:
                                          EdgeInsets.only(right: 5, bottom: 17),
                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Icon(
                                          Icons.minimize_outlined,
                                          size: 25,
                                          color: Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 5),
                                    width:
                                        MediaQuery.of(context).size.width * .1,
                                    child: TextField(
                                      controller: quantityController,
                                      keyboardType: TextInputType.number,
                                      autofocus: false,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(right: 5, left: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          int value = int.parse(
                                                  quantityController.text) +
                                              1;
                                          widget.productQuanitity =
                                              value.toString();
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 15,
                                        backgroundColor: Colors.black12,
                                        child: Icon(
                                          Icons.add,
                                          size: 25,
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
                              padding: EdgeInsets.only(top: 5),
                              height: MediaQuery.of(context).size.height * .06,
                              child: Column(
                                children: [
                                  Text(
                                    "TOTAL",
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            .7,
                                  ),
                                  Container(
                                    child: Text(
                                      widget.totalPrice.toString() + ' LE',
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.2,
                                      style:
                                          TextStyle(color: Color(0xff3A559F)),
                                    ),
                                  )
                                ],
                              ),
                            )
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
