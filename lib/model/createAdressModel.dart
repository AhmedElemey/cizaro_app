class CreateAddress {
  int country;
  int city;
  String streetAddress;
  String zipCode;
  String region;
  String phone;

  CreateAddress(
      {this.country,
      this.city,
      this.streetAddress,
      this.zipCode,
      this.region,
      this.phone});

  CreateAddress.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    streetAddress = json['street_address'];
    zipCode = json['zip_code'];
    region = json['region'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['city'] = this.city;
    data['street_address'] = this.streetAddress;
    data['zip_code'] = this.zipCode;
    data['region'] = this.region;
    data['phone'] = this.phone;
    return data;
  }
}
