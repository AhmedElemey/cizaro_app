class Spec {
  int specValueId;

  Spec({this.specValueId});

  Spec.fromJson(Map<String, dynamic> json) {
    specValueId = json['spec_value_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec_value_id'] = this.specValueId;
    return data;
  }
}
