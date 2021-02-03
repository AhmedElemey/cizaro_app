class RelatedSpec {
  int status;
  int statusCode;
  String message;
  List<Data> data;

  RelatedSpec({this.status, this.statusCode, this.message, this.data});

  RelatedSpec.fromJson(Map<String, dynamic> json) {
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
  int id;
  String name;
  bool isColor;
  List<Values> values;

  Data({this.id, this.name, this.isColor, this.values});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isColor = json['is_color'];
    if (json['values'] != null) {
      values = new List<Values>();
      json['values'].forEach((v) {
        values.add(new Values.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['is_color'] = this.isColor;
    if (this.values != null) {
      data['values'] = this.values.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Values {
  int id;
  String value;
  int quantity;
  bool hasRelatedSpecs;

  Values({this.id, this.value, this.quantity, this.hasRelatedSpecs});

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    quantity = json['quantity'];
    hasRelatedSpecs = json['has_related_specs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['quantity'] = this.quantity;
    data['has_related_specs'] = this.hasRelatedSpecs;
    return data;
  }
}
