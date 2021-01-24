import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/services/list_service.dart';
import 'package:flutter/cupertino.dart';

class ListViewModel extends ChangeNotifier {
  Future<Home> fetchHomeList() async {
    final result = await ListServices().fetchHome();
    notifyListeners();
    return result;
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

  Future<SearchModel> fetchSearch(String txt) async {
    final result = await ListServices().fetchSearch(txt);
    notifyListeners();
    return result;
  }
}
