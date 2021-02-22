import 'package:cizaro_app/size_config.dart';
import 'package:flutter/material.dart';

class HotDealsItem extends StatelessWidget {
  final String itemText, imgUrl;
  final int id;
  const HotDealsItem({this.id, this.itemText, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    //   SizeConfig().init(context);
    // ScreenUtil.init(context,
    //     allowFontScaling: false,
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height);
    // return InfoWidget(
    //   builder: (context, deviceInfo) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(left: 1, right: 1),
        child: Image.network(
          imgUrl,
          width: SizeConfig.blockSizeHorizontal * 100,
          fit: BoxFit.fitWidth,
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
      ),
      // Positioned(top: 1, left: 10, child: Image.network(imgUrl)),
      Positioned(
          bottom: 1,
          right: 10,
          child: Container(
            width: SizeConfig.blockSizeHorizontal * 41,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(18.0)),
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: new EdgeInsets.all(10),
                      child: Text(
                        "SEE MORE",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue.shade900,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    ),
                  )
                ],
              ),
            ),
          ))
    ]);
  }
}
