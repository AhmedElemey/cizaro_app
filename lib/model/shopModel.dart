class ShopModel {
  int status;
  int statusCode;
  String message;
  Data data;

  ShopModel({this.status, this.statusCode, this.message, this.data});

  ShopModel.fromJson(Map<String, dynamic> json) {
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
  List<Products> products;
  // List<Null> filterSpecs;

  Data({this.products
      //  , this.filterSpecs
      });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    // if (json['filter_specs'] != null) {
    //   filterSpecs = new List<Null>();
    //   json['filter_specs'].forEach((v) {
    //     filterSpecs.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    // if (this.filterSpecs != null) {
    //   data['filter_specs'] = this.filterSpecs.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Products {
  int id;
  String name;
  String mainImg;
  double price;
  Null stars;
  Category category;
  bool specs;
  Offer offer;
  int availability;

  Products(
      {this.id,
      this.name,
      this.mainImg,
      this.price,
      this.stars,
      this.category,
      this.specs,
      this.offer,
      this.availability});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImg = json['main_img'];
    price = json['price'];
    stars = json['stars'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    specs = json['specs'];
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['main_img'] = this.mainImg;
    data['price'] = this.price;
    data['stars'] = this.stars;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['specs'] = this.specs;
    if (this.offer != null) {
      data['offer'] = this.offer.toJson();
    }
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

class Offer {
  String type;
  int discount;
  int afterPrice;

  Offer({this.type, this.discount, this.afterPrice});

  Offer.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    discount = json['discount'];
    afterPrice = json['after_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['after_price'] = this.afterPrice;
    return data;
  }
}
