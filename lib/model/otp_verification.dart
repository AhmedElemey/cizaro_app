class OtpVerification {
  int code;
  int addressBookId;
  bool resend;

  OtpVerification({this.code, this.addressBookId, this.resend});

  OtpVerification.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    addressBookId = json['address_book_id'];
    resend = json['resend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['address_book_id'] = this.addressBookId;
    data['resend'] = this.resend;
    return data;
  }
}
