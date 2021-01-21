import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDetailItem extends StatelessWidget {
  final String productName, imgUrl;
  final double productPrice, productStar;
  const ProductDetailItem(
      {this.productName, this.imgUrl, this.productPrice, this.productStar});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        elevation: 1,
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .2,
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
                padding: EdgeInsets.only(right: 15, top: 5),
                child: Text(
                  productName,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$' + productPrice.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.2,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .1,
                      height: MediaQuery.of(context).size.height * .03,
                      decoration: BoxDecoration(
                          color: Color(0xffFF6969),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.only(left: 5),
                          ),
                          Text(
                            productStar.toString(),
                            style: TextStyle(color: Colors.white),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          )
                        ],
                      ),
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
