import 'package:cizaro_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
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
          height: SizeConfig.blockSizeHorizontal * 37,
          width: SizeConfig.blockSizeHorizontal * 100,
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeHorizontal * 1,
              bottom: SizeConfig.blockSizeVertical * 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 1,
                      right: SizeConfig.blockSizeHorizontal * 1),
                  // padding: EdgeInsets.symmetric(
                  //     vertical: SizeConfig.blockSizeHorizontal * .2,
                  //     horizontal: SizeConfig.blockSizeHorizontal * .1),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          width: SizeConfig.blockSizeHorizontal * 20,
                          height: SizeConfig.blockSizeVertical * 30,
                          child: Image.network(widget.imgUrl,
                              fit: BoxFit.fitHeight)))),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 2,
                      right: SizeConfig.blockSizeHorizontal * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: SizeConfig.blockSizeHorizontal * 40,
                            child: Text(
                              widget.productName,
                              // textScaleFactor:
                              //     MediaQuery.of(context).textScaleFactor * 1.3
                              style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5,
                              ),
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
                                    ? widget.productPrice.toString() +
                                        ' le'.tr()
                                    : widget.productPriceAfterDiscount == null
                                        ? widget.productPrice.toString() +
                                            ' le'.tr()
                                        : widget.productPriceAfterDiscount == 0
                                            ? widget.productPrice
                                            : widget.productPriceAfterDiscount
                                                    .toString() +
                                                ' le'.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5,
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'qty'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
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
                            "total".tr() + " :",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                          ),
                          Text(
                            widget.productPrice.toString() + ' le'.tr(),
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            ),
                          )
                        ],
                      ),
                      widget.totalAvailability < widget.productQuantity
                          ? Center(
                              child: Text(
                                  "${widget.totalAvailability}" +
                                          "available".tr() ??
                                      '',
                                  // '${widget.totalAvailability}  items Available in Stock' ??
                                  //     '',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                  )))
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
