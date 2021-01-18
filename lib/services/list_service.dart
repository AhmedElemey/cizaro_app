import 'dart:convert';

import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:http/http.dart' as http;

class ListServices {
  static const API = "http://cizaro.net/api/v1";
  Future<Home> fetchHome() async {
    final response = await http.get(API + '/home/');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Home.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<ProductDetailsModel> fetchProductDetails() async {
    final response = await http.get(API + '/products/');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ProductDetailsModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }
}
