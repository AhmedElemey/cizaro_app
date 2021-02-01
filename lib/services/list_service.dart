import 'dart:convert';
import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/model/checkOfferModel.dart';
import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/model/productOfferCart.dart' as productOffer;
import 'package:cizaro_app/model/searchFilter.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:http/http.dart' as http;

class ListServices {
  static const API = "http://cizaro.tree-code.com/api/v1";
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
      //  print(response.body);
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
      //  print(response.body);
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
      //print(response.body);
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

  Future<Specs> fetchSpaces(int specValueId) async {
    final response = await http.post(API + '/send-product-spec-value-id/',
        body: jsonEncode(specValueId));
    final body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200 || body['message'] == '') {
      return Specs.fromJson(body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<List<productOffer.Data>> checkOfferInCart(
      String token, CheckProductsOfferInCart checkProductsOfferInCart) async {
    final response = await http.post(API + '/shopping-cart-check-offer/',
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${'Token'} $token'
        },
        body: jsonEncode(checkProductsOfferInCart.toJson()));
    final body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200 || body['message'] == '') {
      final Iterable json = body['data'];
      return json
          .map<productOffer.Data>(
              (products) => productOffer.Data.fromJson(products))
          .toList();
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
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
