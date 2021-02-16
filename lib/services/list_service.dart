import 'dart:convert';

import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/model/addressBookModel.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;
import 'package:cizaro_app/model/brandModel.dart';
import 'package:cizaro_app/model/changePasswordModel.dart';
import 'package:cizaro_app/model/checkOfferModel.dart';
import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/model/countries.dart' as country;
import 'package:cizaro_app/model/createAdressModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/model/productOfferCart.dart' as productOffer;
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/profileEditModel.dart';
import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/model/related_spec.dart';
import 'package:cizaro_app/model/result_ckeck_shopping_cart.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/model/shopping_cart.dart';
import 'package:cizaro_app/model/specMdel.dart';
import 'package:http/http.dart' as http;

class ListServices {
  static const API = 'http://cizaro.tree-code.com/api/v1';

  Future<Home> fetchHome() async {
    final response = await http.get(API + '/home/');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return Home.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<BrandModel> fetchBrand() async {
    final response = await http.get(API + '/brands');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      //  print(response.body);
      return BrandModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<ShopModel> fetchFilterItems(
      var minimum, var maximum, var brand) async {
    final response = await http.get(
        API + '/products/?min_price=$minimum&max_price=$maximum&brand=$brand');
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print(response.body);
      return ShopModel.fromJson(body);
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
      // print(response.body);
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

  Future<RelatedSpec> fetchSpecs(Spec spec) async {
    final response = await http.post(API + '/send-product-spec-value-id/',
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(spec.toJson()));
    final body = jsonDecode(response.body);
    // print(response.body);
    if (response.statusCode == 200 || body['message'] == '') {
      return RelatedSpec.fromJson(body);
    } else {
      //   print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<List<productOffer.Data>> checkOfferInCart(
      CheckProductsOfferInCart checkProductsOfferInCart) async {
    final response = await http.post(API + '/shopping-cart-check-offer/',
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(checkProductsOfferInCart.toJson()));
    final body = jsonDecode(response.body);
    // print(response.body);
    if (response.statusCode == 200 || body['message'] == '') {
      final Iterable json = body['data'];
      return json
          .map<productOffer.Data>(
              (products) => productOffer.Data.fromJson(products))
          .toList();
    } else {
      // print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<ProfileModel> fetchProfile(int id, String token) async {
    final response = await http.get(API + '/users/$id/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token'
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print(response.body);
      return ProfileModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<List<country.Data>> fetchCountries(String token) async {
    final response = await http.get(API + '/countries/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token'
    });

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body['data'];
      return json
          .map<country.Data>((countries) => country.Data.fromJson(countries))
          .toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }

//patch

  Future<ProfileEditingModel> updateProfile(
      int id, ProfileEditingModel profileEditingModel, String token) async {
    final response = await http.patch(API + '/users/$id/',
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${'Token'} $token'
        },
        body: jsonEncode(profileEditingModel.toJson()));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // print(response.body);
      return ProfileEditingModel.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  // POST
  Future createAddress(CreateAddress address, String token) async {
    final response = await http.post(
      API + '/address-book/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${'Token'} $token'
      },
      body: jsonEncode(address.toJson()),
    );
    var data = json.decode(response.body);
    //print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future changePassword(
      ChangePasswordModel changePasswordModel, String token) async {
    final response = await http.post(
      API + '/password_change/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${'Token'} $token'
      },
      body: jsonEncode(changePasswordModel.toJson()),
    );
    var data = json.decode(response.body);
    //print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<ResultShoppingCartModel> checkShoppingCart(
      ShoppingCartModel shoppingCartModel, String token) async {
    final response = await http.post(
      API + '/shopping-cart/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${'Token'} $token'
      },
      body: jsonEncode(shoppingCartModel.toJson()),
    );
    var data = json.decode(response.body);
    // print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      final body = jsonDecode(response.body);
      return ResultShoppingCartModel.fromJson(body);
    } else {
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<address.AddressModel> fetchAddresses(String token) async {
    final response = await http.get(
      API + '/address-book/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${'Token'} $token'
      },
    );
    var data = json.decode(response.body);
    // print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      final body = jsonDecode(response.body);
      return address.AddressModel.fromJson(body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future deleteAddress(String token, int addressId) async {
    final response = await http.delete(
      API + '/address-book/$addressId/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${'Token'} $token'
      },
    );
    var data = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future updateAddress(
      CreateAddress createAddress, String token, int addressId) async {
    final response = await http.patch(API + '/address-book/$addressId/',
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${'Token'} $token'
        },
        body: jsonEncode(createAddress.toJson()));
    var data = json.decode(response.body);
    print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      return jsonDecode(response.body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }

  Future<AddressBookModel> fetchShippingAddress(
      String token, int addressId) async {
    final response = await http.get(
      API + '/address-book/$addressId/',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${'Token'} $token'
      },
    );
    var data = json.decode(response.body);
    // print(response.body);
    if (response.statusCode == 200 || data['message'] == '') {
      final body = jsonDecode(response.body);
      return AddressBookModel.fromJson(body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }
}
