import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/model/createAdressModel.dart';
import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/model/searchFilter.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/services/list_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:cizaro_app/model/countries.dart' as country;

class ListViewModel extends ChangeNotifier {
  Future<Home> fetchHomeList() async {
    final result = await ListServices().fetchHome();
    notifyListeners();
    return result;
  }

  Future<ShopModel> fetchFilter(int categoryId, int collectionId) async {
    final results =
        await ListServices().fetchFilterItems(categoryId, collectionId);
    notifyListeners();
    return results;
  }

  Future<ProductDetailsModel> fetchProductDetailsList(int productId) async {
    final result = await ListServices().fetchProductDetails(productId);
    notifyListeners();
    return result;
  }

  Future<ShopModel> fetchShop(int collectionId) async {
    final result = await ListServices().fetchShop(collectionId);
    notifyListeners();
    return result;
  }

  Future<SearchModel> fetchSearch() async {
    final result = await ListServices().fetchSearch();
    notifyListeners();
    return result;
  }

  Future<SearchModel> fetchSearchBar(String searchTxt) async {
    final result = await ListServices().fetchSearchBar(searchTxt);
    notifyListeners();
    return result;
  }

  Future<ContactUsModel> fetchContacts() async {
    final result = await ListServices().fetchContacts();
    notifyListeners();
    return result;
  }

  Future<AboutUsModel> fetchAboutUs() async {
    final result = await ListServices().fetchAboutUs();
    notifyListeners();
    return result;
  }

  Future<Specs> fetchSpecValues(int specValueId) async {
    final result = await ListServices().fetchSpaces(specValueId);
    notifyListeners();
    return result;
  }

  Future<PolicesTermsModel> fetchPolicy() async {
    final result = await ListServices().fetchPolicy();
    notifyListeners();
    return result;
  }

  Future<List<country.Data>> fetchCountries(String token) async {
    final results = await ListServices().fetchCountries(token);
    notifyListeners();
    return results;
  }

  Future fetchAddress(CreateAddress address, String token) async {
    final results = await ListServices().createAddress(address, token);
    notifyListeners();
    return results;
  }
}
