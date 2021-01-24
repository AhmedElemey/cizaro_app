class ContactUsModel {
  int status;
  int statusCode;
  String message;
  List<Data> data;

  ContactUsModel({this.status, this.statusCode, this.message, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
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
  String phone;
  String email;
  String address;
  String postalCode;
  String facebook;
  String twitter;
  String google;
  String youtube;
  String instagram;

  Data(
      {this.phone,
      this.email,
      this.address,
      this.postalCode,
      this.facebook,
      this.twitter,
      this.google,
      this.youtube,
      this.instagram});

  Data.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    postalCode = json['postal_code'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    google = json['google'];
    youtube = json['youtube'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['google'] = this.google;
    data['youtube'] = this.youtube;
    data['instagram'] = this.instagram;
    return data;
  }
}
