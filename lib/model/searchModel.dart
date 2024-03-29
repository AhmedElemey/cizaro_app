class SearchModel {
  int status;
  int statusCode;
  String message;
  Data data;

  SearchModel({this.status, this.statusCode, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
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
  List<SearchProducts> products;
  // List<Null> filterSpecs;

  Data({
    this.products,
    //this.filterSpecs
  });

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<SearchProducts>();
      json['products'].forEach((v) {
        products.add(new SearchProducts.fromJson(v));
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

class SearchProducts {
  int id;
  String name;
  String mainImg;
  double price;
  Null stars;
  Category category;
  bool specs;
  Offer offer;
  int availability;

  SearchProducts(
      {this.id,
      this.name,
      this.mainImg,
      this.price,
      this.stars,
      this.category,
      this.specs,
      // this.offer,
      this.availability});

  SearchProducts.fromJson(Map<String, dynamic> json) {
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

    //   data['offer'] = this.offer;

    // data['offer'] = this.offer;

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

// class Offer {
//   Type type;
//   String description;
//   String image;
//   double discount;
//
//   Offer({this.type, this.description, this.image, this.discount});
//
//   Offer.fromJson(Map<String, dynamic> json) {
//     // type = json['type'] != null ? new Type.fromJson(json['type']) : null;
//     description = json['description'];
//     image = json['image'];
//     discount = json['discount'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.type != null) {
//       data['type'] = this.type.toJson();
//     }
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['discount'] = this.discount;
//     return data;
//   }
// }

class Type {
  String name;

  Type({this.name});

  Type.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Offer {
  String type;
  double discount;
  double afterPrice;

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
    data['afterPrice'] = this.afterPrice;
    return data;
  }
}
