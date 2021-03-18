import 'package:cizaro_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutItem extends StatelessWidget {
  final String productName, imgUrl, productCategory;
  final double productPrice;
  final String productSizeSpecs;
  final Color productColorSpecs;
  final int productQuantity;

  const CheckoutItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productCategory,
      this.productColorSpecs,
      this.productQuantity,
      this.productSizeSpecs});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3),
      child: Card(
        elevation: 2,
        child: Container(
          height: SizeConfig.blockSizeVertical * 17,
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              top: SizeConfig.blockSizeVertical * .2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 1,
                    left: SizeConfig.blockSizeHorizontal * 3,
                    top: SizeConfig.blockSizeVertical * .2,
                    bottom: SizeConfig.blockSizeVertical * .2),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 2),
                    child: Image.network(imgUrl)),
              ),
              Flexible(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: SizeConfig.blockSizeHorizontal * 30,
                          child: Text(
                            productName ?? "",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            child: Text(
                              productCategory ?? "",
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3.5),
                              // textScaleFactor:
                              //     MediaQuery.of(context).textScaleFactor * 1
                            ),
                          ),
                        ),
                        Container(
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal * 30,
                            child: Row(
                              children: [
                                Text(
                                  'qty'.tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4,
                                  ),
                                ),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1),
                                Text(
                                  productQuantity.toString() ?? 0,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.5),
                                  // textScaleFactor:
                                  //     MediaQuery.of(context).textScaleFactor * 1
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          productPrice.toString() + ' le'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 4),
                        ),
                        Column(
                          children: [
                            Text(
                              productSizeSpecs == "" ? '' : "Size: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.3),
                            ),
                            Text(
                              productSizeSpecs == ""
                                  ? ''
                                  : productSizeSpecs.toString(),
                              style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 3,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff3A559F)),
                            ),
                            Text(
                              productColorSpecs == Color(0x000000ff) ||
                                      productColorSpecs == Color(0xffffffff)
                                  ? ''
                                  : " , Color: ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.safeBlockHorizontal * 3),
                              // textScaleFactor:
                              //     MediaQuery.of(context).textScaleFactor *
                              //         1.1
                            ),
                            productColorSpecs == null
                                ? Container()
                                : CircleAvatar(
                                    radius: SizeConfig.blockSizeHorizontal * 3,
                                    foregroundColor: productColorSpecs,
                                    backgroundColor: productColorSpecs)
                          ],
                        ),
                      ],
                    ),
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
