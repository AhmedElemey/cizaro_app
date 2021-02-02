class SocialLogin {
  String facebookGoogleId;
  String socialType;

  SocialLogin({this.facebookGoogleId, this.socialType});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    facebookGoogleId = json['facebook_google_id'];
    socialType = json['social_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['facebook_google_id'] = this.facebookGoogleId;
    data['social_type'] = this.socialType;
    return data;
  }
}
