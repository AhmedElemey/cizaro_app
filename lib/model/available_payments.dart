class Payments {
  int status;
  int statusCode;
  String message;
  Data data;

  Payments({this.status, this.statusCode, this.message, this.data});

  Payments.fromJson(Map<String, dynamic> json) {
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
  List<AvailablePayments> availablePayments;

  Data({this.availablePayments});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['available_payments'] != null) {
      availablePayments = new List<AvailablePayments>();
      json['available_payments'].forEach((v) {
        availablePayments.add(new AvailablePayments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.availablePayments != null) {
      data['available_payments'] =
          this.availablePayments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AvailablePayments {
  int id;
  String name;
  String logo;

  AvailablePayments({this.id, this.name, this.logo});

  AvailablePayments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}
