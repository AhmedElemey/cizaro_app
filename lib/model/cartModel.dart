import 'package:cizaro_app/helper/constants.dart';

class ProductCart {
  int id;
  String name;
  String mainImg;
  double priceAfterDiscount;
  double price;
  String categoryName;
  int availability;
  int quantity;
  int inCart;
  double totalPrice;
  String colorSpecValue;
  String sizeSpecValue;

  ProductCart(
      {this.id,
      this.name,
      this.mainImg,
      this.priceAfterDiscount,
      this.price,
      this.categoryName,
      this.quantity,
      this.totalPrice,
      this.inCart,
      this.availability,
      this.colorSpecValue,
      this.sizeSpecValue});

  ProductCart.fromJson(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    mainImg = map[columnMainImag];
    price = map[columnPrice];
    priceAfterDiscount = map[columnPriceAfterDiscount];
    totalPrice = map[columnTotalPrice];
    categoryName = map[columnCategoryName];
    quantity = map[columnQuantity];
    availability = map[columnAvailability];
    colorSpecValue = map[columnColorSpecs];
    sizeSpecValue = map[columnSizeSpecs];
    inCart = map[columnInCart];
  }

  Map<String, dynamic> toJson() {
    return {
      columnId: id,
      columnName: name,
      columnMainImag: mainImg,
      columnPrice: price,
      columnPriceAfterDiscount: priceAfterDiscount,
      columnTotalPrice: totalPrice,
      columnCategoryName: categoryName,
      columnQuantity: quantity,
      columnAvailability: availability,
      columnColorSpecs: colorSpecValue,
      columnSizeSpecs: sizeSpecValue,
      columnInCart: inCart
    };
  }
}
