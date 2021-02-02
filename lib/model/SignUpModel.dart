class SignUp {
  String username;
  String email;
  int gender;
  String birthDate;
  String newPassword1;
  String newPassword2;
  String fullName;
  String facebookId;
  String googleId;
  String appleId;

  SignUp(
      {this.username,
        this.email,
        this.gender,
        this.birthDate,
        this.newPassword1,
        this.newPassword2,
        this.fullName,
        this.facebookId,
        this.googleId,
      this.appleId});

  SignUp.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    newPassword1 = json['new_password1'];
    newPassword2 = json['new_password2'];
    fullName = json['full_name'];
    facebookId = json['facebook_id'];
    googleId = json['google_id'];
    appleId = json['apple_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['birth_date'] = this.birthDate;
    data['new_password1'] = this.newPassword1;
    data['new_password2'] = this.newPassword2;
    data['full_name'] = this.fullName;
    data['facebook_id'] = this.facebookId;
    data['google_id'] = this.googleId;
    data['apple_id'] = this.appleId;
    return data;
  }
}
