class OrderDetails {
  int status;
  int statusCode;
  String message;
  Data data;

  OrderDetails({this.status, this.statusCode, this.message, this.data});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String orderNumber;
  Status status;
  Status paymentMethod;
  List<Items> items;

  Data({this.orderNumber, this.status, this.paymentMethod, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    paymentMethod = json['payment_method'] != null
        ? new Status.fromJson(json['payment_method'])
        : null;
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Status {
  int key;
  String value;

  Status({this.key, this.value});

  Status.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Items {
  int id;
  Product product;
  double cashAmount;
  int quantity;

  Items({this.id, this.product, this.cashAmount, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    cashAmount = json['cash_amount'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['cash_amount'] = this.cashAmount;
    data['quantity'] = this.quantity;
    return data;
  }
}

class Product {
  int id;
  Category category;
  String name;
  String mainImg;
  double stars;
  int availability;

  Product(
      {this.id,
      this.category,
      this.name,
      this.mainImg,
      this.stars,
      this.availability});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    name = json['name'];
    mainImg = json['main_img'];
    stars = json['stars'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['name'] = this.name;
    data['main_img'] = this.mainImg;
    data['stars'] = this.stars;
    data['availability'] = this.availability;
    return data;
  }
}

class Category {
  int id;
  String name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
