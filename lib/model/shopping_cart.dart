class ShoppingCartModel {
  int addressBookId;
  List<Items> items;

  ShoppingCartModel({this.addressBookId, this.items});

  ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    addressBookId = json['address_book_id'];
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_book_id'] = this.addressBookId;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int product;
  String specs;
  int quantity;

  Items({this.product, this.specs, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    product = json['product'];
    specs = json['specs'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product'] = this.product;
    data['specs'] = this.specs;
    data['quantity'] = this.quantity;
    return data;
  }
}
