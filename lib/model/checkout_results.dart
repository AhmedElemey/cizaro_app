class CheckoutResult {
  int status;
  int statusCode;
  String message;
  Data data;

  CheckoutResult({this.status, this.statusCode, this.message, this.data});

  CheckoutResult.fromJson(Map<String, dynamic> json) {
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
  String paymentUrl;
  bool done;
  int orderId;

  Data({this.paymentUrl, this.done, this.orderId});

  Data.fromJson(Map<String, dynamic> json) {
    paymentUrl = json['payment_url'];
    done = json['done'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_url'] = this.paymentUrl;
    data['done'] = this.done;
    data['order_id'] = this.orderId;
    return data;
  }
}
