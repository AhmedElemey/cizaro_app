import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/services/list_service.dart';
import 'package:flutter/cupertino.dart';

class ListViewModel extends ChangeNotifier {
  Future<Home> fetchHomeList() async {
    final result = await ListServices().fetchHome();
    notifyListeners();
    return result;
  }

  Future<ProductDetailsModel> fetchProductDetailsList() async {
    final result = await ListServices().fetchProductDetails();
    notifyListeners();
    return result;
  }
}
