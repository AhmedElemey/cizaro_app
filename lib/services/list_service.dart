import 'dart:convert';

import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/model/searchFilter.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:http/http.dart' as http;

class ListServices {
  static const API = "https://cizaro.net/api/v1";
  Future<Home> fetchHome() async {
    final response = await http.get(API + '/home/');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Home.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<ProductDetailsModel> fetchProductDetails(int productId) async {
    final response = await http.get(API + '/products/$productId');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
      return ProductDetailsModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<ShopModel> fetchShop(int collectionId) async {
    final response =
        await http.get(API + '/products/?collection=$collectionId');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return ShopModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<SearchModel> fetchSearch() async {
    final response = await http.get(API + '/products/?search');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return SearchModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<SearchModel> fetchSearchBar(String searchTxt) async {
    final response = await http.get(API + '/products/?search=$searchTxt');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
      return SearchModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<ContactUsModel> fetchContacts() async {
    final response = await http.get(API + '/contact-us/');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //  print(response.body);
      return ContactUsModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<AboutUsModel> fetchAboutUs() async {
    final response = await http.get(API + '/more/?model=AboutUs');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //print(response.body);
      return AboutUsModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<PolicesTermsModel> fetchPolicy() async {
    final response = await http.get(API + '/more/?model=PrivacyPolicy');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //print(response.body);
      return PolicesTermsModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  // POST

  Future<SearchFilterModel> fetchFilterItems(
      SearchFilterModel searchFilterModel) async {
    final response = await http.post(API + '/send-filter/',
        body: jsonEncode(searchFilterModel.toJson()));
    if (response.statusCode == 200) {
    } else {
      Exception("");
    }
  }
}
