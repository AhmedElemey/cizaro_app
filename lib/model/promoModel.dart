class PromoModel {
  int status;
  int statusCode;
  String message;
  Data data;

  PromoModel({this.status, this.statusCode, this.message, this.data});

  PromoModel.fromJson(Map<String, dynamic> json) {
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
  double totalCostBefore;
  double priceDiscount;
  double totalCost;

  Data(
      {this.totalOrder,
      this.shippingFees,
      this.totalCostBefore,
      this.priceDiscount,
      this.totalCost});

  Data.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    shippingFees = json['shipping_fees'];
    totalCostBefore = json['total_cost_before'];
    priceDiscount = json['price_discount'];
    totalCost = json['total_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_order'] = this.totalOrder;
    data['shipping_fees'] = this.shippingFees;
    data['total_cost_before'] = this.totalCostBefore;
    data['price_discount'] = this.priceDiscount;
    data['total_cost'] = this.totalCost;
    return data;
  }
}
