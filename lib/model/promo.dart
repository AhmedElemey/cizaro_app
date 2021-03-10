class Promo {
  int addressId;
  String promoCode;

  Promo({this.addressId, this.promoCode});

  Promo.fromJson(Map<String, dynamic> json) {
    addressId = json['address_book_id'];
    promoCode = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_book_id'] = this.addressId;
    data['code'] = this.promoCode;
    return data;
  }
}
