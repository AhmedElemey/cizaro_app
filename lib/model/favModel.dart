import 'package:cizaro_app/helper/constants.dart';

class ProductFav {
  int id;
  String name;
  String mainImg;
  double price;

  String categoryName;
  double stars;
  int isFav;

  ProductFav({
    this.id,
    this.name,
    this.mainImg,
    this.price,
    this.categoryName,
    this.stars,
    this.isFav,
  });

  ProductFav.fromJson(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    mainImg = map[columnMainImag];
    price = map[columnPrice];
    categoryName = map[columnCategoryName];
    stars = map[columnStars];
    isFav = map[columnIsFav];
  }

  Map<String, dynamic> toJson() {
    return {
      columnId: id,
      columnName: name,
      columnMainImag: mainImg,
      columnPrice: price,
      columnCategoryName: categoryName,
      columnStars: stars,
      columnIsFav: isFav
    };
  }
}
