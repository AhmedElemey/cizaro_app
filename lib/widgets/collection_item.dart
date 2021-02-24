import 'dart:io';

import 'package:cizaro_app/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionItem extends StatelessWidget {
  final String itemText, imgUrl;
  final int id;

  // double width, height;
  CollectionItem({this.id, this.itemText, this.imgUrl
      // ,
      // this.height, this.width
      });
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // var mediaQueryData = MediaQuery.of(context);
    // ScreenUtil.init(context,
    //     allowFontScaling: false,
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height);
    // TODO: implement build
    return Container(
      // width: MediaQuery.of(context).size.width * .3,
      // height: MediaQuery.of(context).size.height * .19,
      width: SizeConfig.blockSizeHorizontal * 30,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        elevation: 10,
        shadowColor: Colors.grey[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.network(
            //   imgUrl,
            //   width: ScreenUtil()
            //       .setWidth(MediaQuery.of(context).size.width * .3),
            //   height: ScreenUtil()
            //       .setHeight(MediaQuery.of(context).size.height * .2),
            //   fit: BoxFit.contain,
            //   loadingBuilder: (BuildContext context, Widget child,
            //       ImageChunkEvent loadingProgress) {
            //     if (loadingProgress == null) return child;
            //     return Center(
            //       child: CircularProgressIndicator(
            //         value: loadingProgress.expectedTotalBytes != null
            //             ? loadingProgress.cumulativeBytesLoaded /
            //                 loadingProgress.expectedTotalBytes
            //             : null,
            //       ),
            //     );
            //   },
            // ),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              child: Image.network(
                imgUrl,
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
                width: SizeConfig.blockSizeHorizontal * 100,
                height: SizeConfig.blockSizeVertical * 16,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 1,
                  top: SizeConfig.blockSizeVertical * .2),
              child: Text(
                itemText,
                // textScaleFactor: mediaQueryData.textScaleFactor * 1.3,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                    color: Color(0xff515C6F)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
