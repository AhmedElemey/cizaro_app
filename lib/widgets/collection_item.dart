import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CollectionItem extends StatelessWidget {
  final String itemText, imgUrl;
  final int id;
  const CollectionItem({this.id, this.itemText, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        allowFontScaling: false,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    // TODO: implement build
    return Card(
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
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
              width: ScreenUtil()
                  .setWidth(MediaQuery.of(context).size.width * .34),
              height: ScreenUtil()
                  .setHeight(MediaQuery.of(context).size.height * .19),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.only(
                top: ScreenUtil().setHeight(10),
                left: ScreenUtil().setWidth(20)),
            child: Text(
              itemText,
              textScaleFactor: ScreenUtil.textScaleFactor * 1.5,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff515C6F)),
            ),
          ),
        ],
      ),
    );
  }
}
