class ProductDetailsModel {
  int status;
  int statusCode;
  String message;
  Data data;

  ProductDetailsModel({this.status, this.statusCode, this.message, this.data});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
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

class MultiImages {
  String image;
  MultiImages({this.image});
  MultiImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Data {
  int id;
  String name;
  String mainImg;
  List<MultiImages> multiImages;
  double price;
  double stars;
  int reviews;
  int availability;
  Category category;
  Specs specs;
  String shortDescription;
  double weight;
  double volume;
  String sku;
  int brand;
  List<RelatedProducts> relatedProducts;
  List<Null> productReviews;
  String type;
  double discount;
  double afterPrice;

  Data(
      {this.id,
      this.name,
      this.mainImg,
      this.multiImages,
      this.price,
      this.stars,
      this.reviews,
      this.availability,
      this.category,
      this.specs,
      this.shortDescription,
      this.weight,
      this.volume,
      this.sku,
      this.brand,
      this.relatedProducts,
      this.productReviews,
      this.type,
      this.discount,
      this.afterPrice});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mainImg = json['main_img'];
    // if (json['multi_images'] != null) {
    //   multiImages = new List<Null>();
    //   json['multi_images'].forEach((v) {
    //     multiImages.add(new Null.fromJson(v));
    //   });
    // }
    price = json['price'];
    stars = json['stars'];
    reviews = json['reviews'];
    availability = json['availability'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    specs = json['specs'] != null ? new Specs.fromJson(json['specs']) : null;
    shortDescription = json['short_description'];
    weight = json['weight'];
    volume = json['volume'];
    sku = json['sku'];
    brand = json['brand'];
    if (json['related_products'] != null) {
      relatedProducts = new List<RelatedProducts>();
      json['related_products'].forEach((v) {
        relatedProducts.add(new RelatedProducts.fromJson(v));
      });
    }
    // if (json['product_reviews'] != null) {
    //   productReviews = new List<Null>();
    //   json['product_reviews'].forEach((v) {
    //     productReviews.add(new Null.fromJson(v));
    //   });
    // }
    type = json['type'];
    discount = json['discount'];
    afterPrice = json['after_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['main_img'] = this.mainImg;
    // if (this.multiImages != null) {
    //   data['multi_images'] = this.multiImages.map((v) => v.toJson()).toList();
    // }
    data['price'] = this.price;
    data['stars'] = this.stars;
    data['reviews'] = this.reviews;
    data['availability'] = this.availability;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.specs != null) {
      data['specs'] = this.specs.toJson();
    }
    data['short_description'] = this.shortDescription;
    data['weight'] = this.weight;
    data['volume'] = this.volume;
    data['sku'] = this.sku;
    data['brand'] = this.brand;
    if (this.relatedProducts != null) {
      data['related_products'] =
          this.relatedProducts.map((v) => v.toJson()).toList();
    }
    // if (this.productReviews != null) {
    //   data['product_reviews'] =
    //       this.productReviews.map((v) => v.toJson()).toList();
    // }
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['after_price'] = this.afterPrice;
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

class Specs {
  int id;
  String name;
  bool isColor;
  List<Values> values;

  Specs({this.id, this.name, this.isColor, this.values});

  Specs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isColor = json['is_color'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_color'] = this.isColor;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values{
  int id;
  String value;
  int quantity;
  bool hasRelatedSpecs;

  Values({this.id, this.value, this.quantity, this.hasRelatedSpecs});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    quantity = json['quantity'];
    hasRelatedSpecs = json['has_related_specs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['quantity'] = this.quantity;
    data['has_related_specs'] = this.hasRelatedSpecs;
    return data;
  }
}

class RelatedProducts {
  int id;
  Category category;
  String name;
  double price;
  String mainImg;
  double stars;
  Offer offer;
  int availability;

  RelatedProducts(
      {this.id,
      this.category,
      this.name,
      this.price,
      this.mainImg,
      this.stars,
      this.offer,
      this.availability});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    name = json['name'];
    price = json['price'];
    mainImg = json['main_img'];
    stars = json['stars'];
    offer = json['offer'];
    availability = json['availability'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    data['name'] = this.name;
    data['price'] = this.price;
    data['main_img'] = this.mainImg;
    data['stars'] = this.stars;
    data['offer'] = this.offer;
    data['availability'] = this.availability;
    return data;
  }
}

// class Offer {
//   String type;
//   double discount;
//   double afterPrice;
//
//   Offer({this.type, this.discount, this.afterPrice});
//
//   Offer.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     discount = json['discount'];
//     afterPrice = json['after_price'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['discount'] = this.discount;
//     data['after_price'] = this.afterPrice;
//     return data;
//   }
// }
class Offer {
  String type;
  double discount;
  double afterPrice;
  Offer({this.type, this.discount, this.afterPrice});

  Offer.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    discount = json['discount'];
    afterPrice = json['afterPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['afterPrice'] = this.afterPrice;
    return data;
  }
}

// class Type {
//   String name;
//
//   Type({this.name});
//
//   Type.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     return data;
//   }
// }
