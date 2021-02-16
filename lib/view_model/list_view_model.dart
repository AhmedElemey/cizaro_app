import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;
import 'package:cizaro_app/model/brandModel.dart';
import 'package:cizaro_app/model/changePasswordModel.dart';
import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/model/countries.dart' as country;
import 'package:cizaro_app/model/createAdressModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/profileEditModel.dart';
import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/model/related_spec.dart';
import 'package:cizaro_app/model/result_ckeck_shopping_cart.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/model/shopping_cart.dart';
import 'package:cizaro_app/model/specMdel.dart';
import 'package:cizaro_app/services/list_service.dart';
import 'package:flutter/cupertino.dart';

class ListViewModel extends ChangeNotifier {
  Future<Home> fetchHomeList() async {
    final result = await ListServices().fetchHome();
    notifyListeners();
    return result;
  }

  Future<BrandModel> fetchBrandList() async {
    final result = await ListServices().fetchBrand();
    notifyListeners();
    return result;
  }

  Future<ShopModel> fetchFilter(var minimum, var maximum, var brand) async {
    final results =
        await ListServices().fetchFilterItems(minimum, maximum, brand);
    notifyListeners();
    return results;
  }

  Future<ProfileEditingModel> updateProfile(
      int id, ProfileEditingModel profileEditingModel, String token) async {
    final results =
        await ListServices().updateProfile(id, profileEditingModel, token);
    notifyListeners();
    return results;
  }

  Future<ChangePasswordModel> changePassword(
      ChangePasswordModel changePasswordModel, String token) async {
    final results =
        await ListServices().changePassword(changePasswordModel, token);
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

  Future<RelatedSpec> fetchSpecValues(Spec spec) async {
    final result = await ListServices().fetchSpecs(spec);
    notifyListeners();
    return result;
  }

  Future<ResultShoppingCartModel> fetchResultOfShippingCart(
      ShoppingCartModel shoppingCartModel, String token) async {
    final result =
        await ListServices().checkShoppingCart(shoppingCartModel, token);
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

  Future<ProfileModel> fetchProfile(int id, String token) async {
    final results = await ListServices().fetchProfile(id, token);
    notifyListeners();
    return results;
  }

  Future<address.AddressModel> fetchAddresses(String token) async {
    final results = await ListServices().fetchAddresses(token);
    notifyListeners();
    return results;
  }

  Future deleteAddress(String token, int addressId) async {
    final results = await ListServices().deleteAddress(token, addressId);
    notifyListeners();
    return results;
  }

  Future updateAddress(
      CreateAddress createAddress, String token, int addressId) async {
    final results =
        await ListServices().updateAddress(createAddress, token, addressId);
    notifyListeners();
    return results;
  }

  Future fetchAddress(CreateAddress address, String token) async {
    final results = await ListServices().createAddress(address, token);
    notifyListeners();
    return results;
  }

  Future fetchShippingAddress(String token, int addressId) async {
    final results = await ListServices().fetchShippingAddress(token, addressId);
    notifyListeners();
    return results;
  }
}
