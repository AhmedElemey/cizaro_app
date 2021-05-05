import 'dart:io';

import 'package:cizaro_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HotDealsItem extends StatelessWidget {
  final String itemText, imgUrl;
  final int id;
  const HotDealsItem({this.id, this.itemText, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(left: 1, right: 1),
        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2),
        child: Image.network(
          imgUrl,
          width: SizeConfig.blockSizeHorizontal * 100,
          height: SizeConfig.blockSizeVertical * 30,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Platform.isAndroid
                ? Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  )
                : CupertinoActivityIndicator();
          },
        ),
      ),
      Positioned(
          bottom: SizeConfig.blockSizeVertical * 0.5,
          right: SizeConfig.blockSizeHorizontal * 4,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 41,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1.5,
                blurRadius: 2,
                offset: Offset(0, 0), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(18.0)),
            child: Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      margin: new EdgeInsets.all(10),
                      child: Text(
                        'see_more'.tr(),
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical * 2.1,
                            fontWeight: FontWeight.bold),
                      )),
                  CircleAvatar(
                    radius: SizeConfig.safeBlockVertical * 2,
                    backgroundColor: Colors.blue.shade900,
                    child: Icon(Icons.arrow_forward_ios_rounded,
                        size: SizeConfig.safeBlockVertical * 2),
                  )
                ],
              ),
            ),
          ))
    ]);
  }
}
