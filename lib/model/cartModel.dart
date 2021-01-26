import 'package:cizaro_app/helper/constants.dart';

class ProductCart {
  int id;
  String name;
  String mainImg;
  double price;
  String categoryName;
  int availability;
  int quantity;

  ProductCart(
      {this.id,
        this.name,
        this.mainImg,
        this.price,
        this.categoryName,
        this.quantity,
        this.availability});

  ProductCart.fromJson(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    mainImg = map[columnMainImag];
    price = map[columnPrice];
    categoryName = map[columnCategoryName];
    quantity = map[columnQuantity];
    availability = map[columnAvailability];
  }

  Map<String, dynamic> toJson() {
    return {
      columnId : id,
      columnName :name,
      columnMainImag : mainImg,
      columnPrice : price,
      columnCategoryName : categoryName,
      columnQuantity : quantity,
      columnAvailability : availability
    };
  }
}
