class Login {
  String usernameEmail;
  String password;

  Login({this.usernameEmail, this.password});

  Login.fromJson(Map<String, dynamic> json) {
    usernameEmail = json['username_email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username_email'] = this.usernameEmail;
    data['password'] = this.password;
    return data;
  }
}
