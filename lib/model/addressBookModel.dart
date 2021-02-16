class AddressBookModel {
  int status;
  int statusCode;
  String message;
  Data data;

  AddressBookModel({this.status, this.statusCode, this.message, this.data});

  AddressBookModel.fromJson(Map<String, dynamic> json) {
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
  Country country;
  Country city;
  String streetAddress;
  String zipCode;
  String region;
  int phone;

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
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new Country.fromJson(json['city']) : null;
    streetAddress = json['street_address'];
    zipCode = json['zip_code'];
    region = json['region'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['street_address'] = this.streetAddress;
    data['zip_code'] = this.zipCode;
    data['region'] = this.region;
    data['phone'] = this.phone;
    return data;
  }
}

class Country {
  String name;

  Country({this.name});

  Country.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}
