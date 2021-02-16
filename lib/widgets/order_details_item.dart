import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OrderDetailsItem extends StatefulWidget {
  final String productName,
      imgUrl,
      colorSpecValue,
      sizeSpecValue,
      productCategory;
  int productQuantity, totalAvailability;
  final double totalPrice, productPrice, productPriceAfterDiscount;

  OrderDetailsItem(
      {Key key,
      this.productName,
      this.imgUrl,
      this.productPrice,
      this.productPriceAfterDiscount,
      this.productCategory,
      this.totalAvailability,
      this.totalPrice,
      this.productQuantity,
      this.colorSpecValue,
      this.sizeSpecValue})
      : super(key: key);

  @override
  _OrderDetailsItemState createState() => _OrderDetailsItemState();
}

class _OrderDetailsItemState extends State<OrderDetailsItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * .15,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: Image.network(widget.imgUrl,
                              fit: BoxFit.fitHeight)))),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(widget.productName,
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.3),
                        Spacer(),
                        Padding(
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            child: Text(
                                widget.productPriceAfterDiscount ==
                                        widget.productPrice
                                    ? widget.productPrice.toString() + ' LE'
                                    : widget.productPriceAfterDiscount == null
                                        ? widget.productPrice.toString() + ' LE'
                                        : widget.productPriceAfterDiscount
                                                .toString() +
                                            ' LE',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor * 1))
                      ],
                    ),
                    Container(
                      child: Text(widget.productCategory,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                          style: const TextStyle(color: Colors.blueGrey)),
                    ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       widget.sizeSpecValue == ""
                    //           ? ''
                    //           : 'Size : ${widget.sizeSpecValue}',
                    //       style: const TextStyle(color: Colors.black),
                    //     ),
                    //     Text(widget.colorSpecValue == "" ? '' : ' , ',
                    //         style: const TextStyle(color: Colors.black)),
                    //     Text(widget.colorSpecValue == "" ? '' : 'Color : ',
                    //         style: const TextStyle(color: Colors.black)),
                    //     widget.colorSpecValue == ""
                    //         ? Container()
                    //         : CircleAvatar(
                    //             radius: 10,
                    //             backgroundColor: Color(
                    //                 int.parse('0xff${widget.colorSpecValue}')),
                    //             foregroundColor: Color(
                    //                 int.parse('0xff${widget.colorSpecValue}'))),
                    //   ],
                    // ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Qty :',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1),
                        const SizedBox(width: 5),
                        Text(widget.productQuantity.toString()),
                        const SizedBox(width: 25),
                        Text("Total : ",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1),
                        Text(widget.productPrice.toString() + ' LE')
                      ],
                    ),
                    widget.totalAvailability < widget.productQuantity
                        ? Center(
                            child: Text(
                                '${widget.totalAvailability}  items Available in Stock' ??
                                    '',
                                style: const TextStyle(
                                    color: Colors.red, fontSize: 10)))
                        : Container()
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
