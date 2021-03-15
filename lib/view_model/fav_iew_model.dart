import 'package:cizaro_app/helper/favdatabase_helper.dart';
import 'package:cizaro_app/model/favModel.dart';
import 'package:flutter/material.dart';

class FavViewModel extends ChangeNotifier {
  List<ProductFav> _favItemsList = [];
  //List<productOffer.Data> _cartItemsAfterOffer = [];

  List<ProductFav> get favProductModel => _favItemsList;
  var dbHelper = FavDataBaseHelper.db;

  FavViewModel() {
    getFavProducts();
  }

  getFavProducts() async {
    _favItemsList = await dbHelper.getFavItems();
    notifyListeners();
  }

  addProductToFav(ProductFav productFav) async {
    for (int i = 0; i < _favItemsList.length; i++) {
      if (_favItemsList[i].id == productFav.id) {
        return;
      }
    }
    await dbHelper.addProductToFav(productFav);
    _favItemsList.add(productFav);
    notifyListeners();
  }

  deleteFavProduct(int index, int productId) async {
    dbHelper.deleteFavItem(productId);
    await dbHelper.updateProduct(_favItemsList[index]);
    notifyListeners();
  }

  bool checkFavItems(int id) {
    bool isFound = false;
    favProductModel.forEach((element) {
      if (id == element.id) {
        isFound = true;
      } else {
        isFound = false;
      }
    });
    return isFound;
  }
}
