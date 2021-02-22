import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  final String productName,
      imgUrl,
      productPrice,
      productStar,
      productCategory,
      favoriteIcon,
      removeIcon;
  final VoidCallback unFavorite;

  const FavoriteItem(
      {this.productName,
      this.imgUrl,
      this.productPrice,
      this.productStar,
      this.productCategory,
      this.favoriteIcon,
      this.removeIcon,
      this.unFavorite});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          elevation: 10,
          child: Container(
            height: MediaQuery.of(context).size.height * .17,
            padding: EdgeInsets.only(left: 5, right: 10, top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
                  child: Image.network(imgUrl),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          productName,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.5,
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.only(right: 5),
                        child: Text(
                          productCategory,
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 5, left: 15, right: 5),
                        child: Row(
                          children: [
                            Text(
                              productPrice + " LE",
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                            Spacer(),
                            Container(
                              width: MediaQuery.of(context).size.width * .1,
                              height: MediaQuery.of(context).size.height * .03,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF6969),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
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
                                      productStar ?? '0.0',
                                      style: TextStyle(color: Colors.white),
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: MediaQuery.of(context).size.width * 0.08,
                      color: Color(0xffFF6969),
                    ),
                    onPressed: unFavorite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
