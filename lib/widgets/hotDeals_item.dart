import 'package:flutter/material.dart';

class HotDealsItem extends StatelessWidget {
  final String itemText, imgUrl;
  final int id;
  const HotDealsItem({this.id, this.itemText, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
          padding: EdgeInsets.only(left: 1, right: 1),
          child: Image.network(
            imgUrl,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .3,
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
              width: MediaQuery.of(context).size.width * .35,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18.0)),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
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
      ]),
    );
  }
}
