class ProductOfferInCart {
  int status;
  int statusCode;
  String message;
  List<Data> data;

  ProductOfferInCart({this.status, this.statusCode, this.message, this.data});

  ProductOfferInCart.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int category;
  int product;
  int quantity;
  int newQuantity;
  int freeQuantity;
  int offerBuy;
  int offerGet;

  Data(
      {this.category,
        this.product,
        this.quantity,
        this.newQuantity,
        this.freeQuantity,
        this.offerBuy,
        this.offerGet});

  Data.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    product = json['product'];
    quantity = json['quantity'];
    newQuantity = json['new_quantity'];
    freeQuantity = json['free_quantity'];
    offerBuy = json['offer_buy'];
    offerGet = json['offer_get'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    data['new_quantity'] = this.newQuantity;
    data['free_quantity'] = this.freeQuantity;
    data['offer_buy'] = this.offerBuy;
    data['offer_get'] = this.offerGet;
    return data;
  }
}
