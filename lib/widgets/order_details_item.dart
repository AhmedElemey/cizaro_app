import 'package:cizaro_app/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3),
      child: Card(
        elevation: 5,
        child: Container(
          height: SizeConfig.blockSizeHorizontal * 20,
          width: SizeConfig.blockSizeHorizontal * 100,
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeHorizontal * 1,
              bottom: SizeConfig.blockSizeVertical * 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.blockSizeHorizontal * .2,
                      horizontal: SizeConfig.blockSizeHorizontal * .1),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          height: SizeConfig.blockSizeVertical * 30,
                          child: Image.network(widget.imgUrl,
                              fit: BoxFit.fitHeight)))),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.productName,
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1.3
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                          ),
                        ),
                        Spacer(),
                        Padding(
                            padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 3,
                                left: SizeConfig.blockSizeHorizontal * 2),
                            child: Text(
                              widget.productPriceAfterDiscount ==
                                      widget.productPrice
                                  ? widget.productPrice.toString() + ' LE'
                                  : widget.productPriceAfterDiscount == null
                                      ? widget.productPrice.toString() + ' LE'
                                      : widget.productPriceAfterDiscount
                                              .toString() +
                                          ' LE',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                              ),
                              // textScaleFactor:
                              //     MediaQuery.of(context).textScaleFactor * 1
                            ))
                      ],
                    ),
                    Container(
                      child: Text(widget.productCategory,
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1.1,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                          )),
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
                        Text(
                          'Qty :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                          ),
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 1),
                        Text(
                          widget.productQuantity.toString(),
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                        Text(
                          "Total : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                          ),
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1
                        ),
                        Text(
                          widget.productPrice.toString() + ' LE',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                          ),
                        )
                      ],
                    ),
                    widget.totalAvailability < widget.productQuantity
                        ? Center(
                            child: Text(
                                '${widget.totalAvailability}  items Available in Stock' ??
                                    '',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                                )))
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
