import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String productText, imgUrl;
  final int productId;
  final double productPrice;
  const ProductItem(
      {this.productId, this.productText, this.imgUrl, this.productPrice});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * .05,
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Icon(
                        Icons.favorite,
                        color: Color(0xffFF6969),
                      )
                    ],
                  )),
              Image.network(
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
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .2,
                fit: BoxFit.contain,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: Text(
                  productText,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.2,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5, right: 10),
                child: Text(
                  '\$' + productPrice.toString(),
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
