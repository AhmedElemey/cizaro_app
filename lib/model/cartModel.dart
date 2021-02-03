import 'package:cizaro_app/helper/constants.dart';

class ProductCart {
  int id;
  String name;
  String mainImg;
  double price;
  String categoryName;
  int availability;
  int quantity;
  double totalPrice;
  String colorSpecValue;
  String sizeSpecValue;

  ProductCart(
      {this.id,
        this.name,
        this.mainImg,
        this.price,
        this.categoryName,
        this.quantity,
        this.totalPrice,
        this.availability,
      this.colorSpecValue,
      this.sizeSpecValue});

  ProductCart.fromJson(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    mainImg = map[columnMainImag];
    price = map[columnPrice];
    totalPrice = map[columnTotalPrice];
    categoryName = map[columnCategoryName];
    quantity = map[columnQuantity];
    availability = map[columnAvailability];
    colorSpecValue = map[columnColorSpecs];
    sizeSpecValue = map[columnSizeSpecs];
  }

  Map<String, dynamic> toJson() {
    return {
      columnId : id,
      columnName :name,
      columnMainImag : mainImg,
      columnPrice : price,
      columnTotalPrice : totalPrice,
      columnCategoryName : categoryName,
      columnQuantity : quantity,
      columnAvailability : availability,
      columnColorSpecs : colorSpecValue,
      columnSizeSpecs : sizeSpecValue
    };
  }
}
