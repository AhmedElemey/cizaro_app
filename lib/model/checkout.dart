class CheckOut {
  int addressBookId;
  bool isCash;
  int paymentApiId;

  CheckOut({this.addressBookId, this.isCash, this.paymentApiId});

  CheckOut.fromJson(Map<String, dynamic> json) {
    addressBookId = json['address_book_id'];
    isCash = json['is_cash'];
    paymentApiId = json['payment_api_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_book_id'] = this.addressBookId;
    data['is_cash'] = this.isCash;
    data['payment_api_id'] = this.paymentApiId;
    return data;
  }
}
