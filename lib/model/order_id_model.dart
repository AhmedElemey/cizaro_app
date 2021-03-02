class OrderIdModel {
  String orderId;
  OrderIdModel({this.orderId});

  OrderIdModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    return data;
  }
}
