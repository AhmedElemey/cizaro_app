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
    return Container(
      child: Card(
        elevation: 3,
        shadowColor: Colors.grey,
        child: Container(
          height:
              ScreenUtil().setHeight(MediaQuery.of(context).size.height * .2),
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imgUrl,
                width: ScreenUtil()
                    .setWidth(MediaQuery.of(context).size.width * .3),
                height: ScreenUtil()
                    .setHeight(MediaQuery.of(context).size.height * .2),
                fit: BoxFit.contain,
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
              Container(
                padding: EdgeInsets.only(
                    top: ScreenUtil().setHeight(10),
                    right: ScreenUtil().setWidth(10)),
                child: Text(
                  itemText,
                  textScaleFactor: ScreenUtil.textScaleFactor * 1,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
