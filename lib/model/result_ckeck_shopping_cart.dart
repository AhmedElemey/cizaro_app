class ResultShoppingCartModel {
  int status;
  int statusCode;
  String message;
  Data data;

  ResultShoppingCartModel(
      {this.status, this.statusCode, this.message, this.data});

  ResultShoppingCartModel.fromJson(Map<String, dynamic> json) {
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
  double totalOrder;
  double shippingFees;
  double totalCost;
  String arrivalDate;
  int addressBookId;
  bool verified;

  Data(
      {this.totalOrder,
      this.shippingFees,
      this.totalCost,
      this.arrivalDate,
      this.addressBookId,
      this.verified});

  Data.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    shippingFees = json['shipping_fees'];
    totalCost = json['total_cost'];
    arrivalDate = json['arrival_date'];
    addressBookId = json['address_book_id'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_order'] = this.totalOrder;
    data['shipping_fees'] = this.shippingFees;
    data['total_cost'] = this.totalCost;
    data['arrival_date'] = this.arrivalDate;
    data['address_book_id'] = this.addressBookId;
    data['verified'] = this.verified;
    return data;
  }
}
