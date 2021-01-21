class Home {
  int status;
  int statusCode;
  String message;
  Data data;

  Home({this.status, this.statusCode, this.message, this.data});

  Home.fromJson(Map<String, dynamic> json) {
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
  List<HotDeals> hotDeals;
  List<ProductOffers> productOffers;
  List<Collections> collections;
  List<NewArrivals> newArrivals;
  List<TopSelling> topSelling;

  Data(
      {this.hotDeals,
      this.productOffers,
      this.collections,
      this.newArrivals,
      this.topSelling});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hot_deals'] != null) {
      hotDeals = new List<HotDeals>();
      json['hot_deals'].forEach((v) {
        hotDeals.add(new HotDeals.fromJson(v));
      });
    }
    if (json['product_offers'] != null) {
      productOffers = new List<ProductOffers>();
      json['product_offers'].forEach((v) {
        productOffers.add(new ProductOffers.fromJson(v));
      });
    }
    if (json['collections'] != null) {
      collections = new List<Collections>();
      json['collections'].forEach((v) {
        collections.add(new Collections.fromJson(v));
      });
    }
    if (json['new_arrivals'] != null) {
      newArrivals = new List<NewArrivals>();
      json['new_arrivals'].forEach((v) {
        newArrivals.add(new NewArrivals.fromJson(v));
      });
    }
    if (json['top_selling'] != null) {
      topSelling = new List<TopSelling>();
      json['top_selling'].forEach((v) {
        topSelling.add(new TopSelling.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotDeals != null) {
      data['hot_deals'] = this.hotDeals.map((v) => v.toJson()).toList();
    }
    if (this.productOffers != null) {
      data['product_offers'] =
          this.productOffers.map((v) => v.toJson()).toList();
    }
    if (this.collections != null) {
      data['collections'] = this.collections.map((v) => v.toJson()).toList();
    }
    if (this.newArrivals != null) {
      data['new_arrivals'] = this.newArrivals.map((v) => v.toJson()).toList();
    }
    if (this.topSelling != null) {
      data['top_selling'] = this.topSelling.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotDeals {
  int id;
  String name;
  Offer offer;

  HotDeals({this.id, this.name, this.offer});

  HotDeals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    offer = json['offer'] != null ? new Offer.fromJson(json['offer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.offer != null) {
      data['offer'] = this.offer.toJson();
    }
    return data;
  }
}

class Offer {
  Type type;
  String description;
  String image;
  double discount;

  Offer({this.type, this.description, this.image, this.discount});

  Offer.fromJson(Map<String, dynamic> json) {
    // type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    description = json['description'];
    image = json['image'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.type != null) {
      data['type'] = this.type.toJson();
    }
    data['description'] = this.description;
    data['image'] = this.image;
    data['discount'] = this.discount;
    return data;
  }
}

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

class Collections {
  int id;
  String name;
  String imageBanner;

  Collections({this.id, this.name, this.imageBanner});

  Collections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageBanner = json['image_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_banner'] = this.imageBanner;
    return data;
  }
}

class NewArrivals {
  int id;
  String name;
  List<Products> products;

  NewArrivals({this.id, this.name, this.products});

  NewArrivals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TopSelling {
  int id;
  String name;
  List<Products> products;

  TopSelling({this.id, this.name, this.products});

  TopSelling.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductOffers {
  int id;
  String name;
  List<Products> products;

  ProductOffers({this.id, this.name, this.products});

  ProductOffers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int id;
  String name;
  String mainImg;
  double price;
  double stars;
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
