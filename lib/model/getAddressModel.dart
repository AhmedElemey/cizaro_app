class GetCreateAddress {
  int status;
  int statusCode;
  String message;
  Data data;

  GetCreateAddress({this.status, this.statusCode, this.message, this.data});

  GetCreateAddress.fromJson(Map<String, dynamic> json) {
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
  int id;
  int country;
  int city;
  String streetAddress;
  String zipCode;
  String region;
  String phone;

  Data(
      {this.id,
      this.country,
      this.city,
      this.streetAddress,
      this.zipCode,
      this.region,
      this.phone});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    city = json['city'];
    streetAddress = json['street_address'];
    zipCode = json['zip_code'];
    region = json['region'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country'] = this.country;
    data['city'] = this.city;
    data['street_address'] = this.streetAddress;
    data['zip_code'] = this.zipCode;
    data['region'] = this.region;
    data['phone'] = this.phone;
    return data;
  }
}
