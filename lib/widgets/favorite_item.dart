import 'package:cizaro_app/size_config.dart';
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
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5,
          top: SizeConfig.blockSizeVertical * 2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Card(
          elevation: 10,
          child: Container(
            height: SizeConfig.blockSizeVertical * 20,
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 1,
                right: SizeConfig.blockSizeHorizontal * 4,
                top: SizeConfig.blockSizeVertical * 1,
                bottom: SizeConfig.blockSizeVertical * 1.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 1,
                      top: SizeConfig.blockSizeVertical * 1,
                      bottom: SizeConfig.blockSizeVertical * .5),
                  child: Image.network(imgUrl),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 40,
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * .05,
                      left: SizeConfig.blockSizeHorizontal * 7),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 50,
                        child: Text(
                          productName,
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          productCategory,
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              productPrice + " LE",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 3,
                              ),
                            ),
                            Spacer(),
                            Container(
                              width: SizeConfig.blockSizeVertical * 9,
                              height: SizeConfig.blockSizeVertical * 3,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF6969),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.star,
                                      size: SizeConfig.safeBlockHorizontal * 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * 1,
                                  ),
                                  Text(
                                    productStar ?? '0.0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4,
                                    ),
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
                Spacer(),
                Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      size: SizeConfig.blockSizeHorizontal * 7,
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
