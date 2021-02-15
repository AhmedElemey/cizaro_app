class Order {
  int status;
  int statusCode;
  String message;
  List<Data> data;

  Order({this.status, this.statusCode, this.message, this.data});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String orderNumber;
  int buyer;
  int product;
  int quantity;
  Status status;
  String country;
  String region;
  String state;
  String address;
  Status paymentMethod;
  double cashAmount;
  double shippingFees;
  String specification;
  String arrivalDate;
  String deliveredDate;
  String cancellationReason;

  Data(
      {this.id,
      this.orderNumber,
      this.buyer,
      this.product,
      this.quantity,
      this.status,
      this.country,
      this.region,
      this.state,
      this.address,
      this.paymentMethod,
      this.cashAmount,
      this.shippingFees,
      this.specification,
      this.arrivalDate,
      this.deliveredDate,
      this.cancellationReason});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    buyer = json['buyer'];
    product = json['product'];
    quantity = json['quantity'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    country = json['country'];
    region = json['region'];
    state = json['state'];
    address = json['address'];
    paymentMethod = json['payment_method'] != null
        ? new Status.fromJson(json['payment_method'])
        : null;
    cashAmount = json['cash_amount'];
    shippingFees = json['shipping_fees'];
    specification = json['specification'];
    arrivalDate = json['arrival_date'];
    deliveredDate = json['delivered_date'];
    cancellationReason = json['cancellation_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['buyer'] = this.buyer;
    data['product'] = this.product;
    data['quantity'] = this.quantity;
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    data['country'] = this.country;
    data['region'] = this.region;
    data['state'] = this.state;
    data['address'] = this.address;
    if (this.paymentMethod != null) {
      data['payment_method'] = this.paymentMethod.toJson();
    }
    data['cash_amount'] = this.cashAmount;
    data['shipping_fees'] = this.shippingFees;
    data['specification'] = this.specification;
    data['arrival_date'] = this.arrivalDate;
    data['delivered_date'] = this.deliveredDate;
    data['cancellation_reason'] = this.cancellationReason;
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
