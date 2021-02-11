class ProfileModel {
  int status;
  int statusCode;
  String message;
  Data data;

  ProfileModel({this.status, this.statusCode, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
  String username;
  String email;
  String fullName;
  Gender gender;
  String birthDate;
  Null facebookId;
  Null googleId;

  Data(
      {this.id,
      this.username,
      this.email,
      this.fullName,
      this.gender,
      this.birthDate,
      this.facebookId,
      this.googleId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    fullName = json['full_name'];
    gender =
        json['gender'] != null ? new Gender.fromJson(json['gender']) : null;
    birthDate = json['birth_date'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    if (this.gender != null) {
      data['gender'] = this.gender.toJson();
    }
    data['birth_date'] = this.birthDate;
    data['facebook_id'] = this.facebookId;
    data['google_id'] = this.googleId;
    return data;
  }
}

class Gender {
  int key;
  String value;

  Gender({this.key, this.value});

  Gender.fromJson(Map<String, dynamic> json) {
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
