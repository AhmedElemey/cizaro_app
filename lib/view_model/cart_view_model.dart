import 'package:cizaro_app/helper/database_helper.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/checkOfferModel.dart';
import 'package:cizaro_app/model/productOfferCart.dart' as productOffer;
import 'package:cizaro_app/services/list_service.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  List<ProductCart> _cartItemsList = [];
  List<productOffer.Data> _cartItemsAfterOffer = [];
  int productId, quantity;

  List<ProductCart> get cartProductModel => _cartItemsList;

  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;
  var dbHelper = DataBaseHelper.db;

  CartViewModel() {
    getCartProducts();
  }

  getCartProducts() async {
    _cartItemsList = await dbHelper.getCartItems();
    getTotalPrice();
    getCartItemsAfterOffer();
    notifyListeners();
  }

  getCartItemsAfterOffer() async {
    List<Items> itemsList = [];
    _cartItemsList.forEach((element) {
      productId = element.id;
      quantity = element.quantity;
      itemsList.add(Items(product: productId, quantity: quantity));
    });

    final checkProductsOfferInCart = CheckProductsOfferInCart(items: itemsList);
    _cartItemsAfterOffer =
        await ListServices().checkOfferInCart(checkProductsOfferInCart);
    print(_cartItemsAfterOffer);
    notifyListeners();
  }

  getTotalPrice() {
    if (_cartItemsList.length == 0 || _cartItemsList == null) {
      _totalPrice = 0.0;
    }
    for (int i = 0; i < _cartItemsList.length; i++) {
      if (_cartItemsList[i].price == _cartItemsList[i].priceAfterDiscount) {
        _totalPrice += _cartItemsList[i].price * _cartItemsList[i].quantity;
      } else {
        _cartItemsList[i].priceAfterDiscount == null
            ? _totalPrice +=
                _cartItemsList[i].price * _cartItemsList[i].quantity
            : _totalPrice += _cartItemsList[i].priceAfterDiscount *
                _cartItemsList[i].quantity;
      }
      notifyListeners();
    }
  }

  addProductToCart(ProductCart productCart) async {
    for (int i = 0; i < _cartItemsList.length; i++) {
      if (_cartItemsList[i].id == productCart.id &&
          _cartItemsList[i].colorSpecValue == productCart.colorSpecValue &&
          _cartItemsList[i].sizeSpecValue == productCart.sizeSpecValue) {
        return;
      }
    }
    await dbHelper.addProductToCart(productCart);
    _cartItemsList.add(productCart);
    productCart.price == productCart.priceAfterDiscount
        ? _totalPrice += productCart.price * productCart.quantity
        : _totalPrice += productCart.priceAfterDiscount == null
            ? productCart.price * productCart.quantity
            : productCart.priceAfterDiscount * productCart.quantity;
    notifyListeners();
  }

  increaseQuantity(int index) async {
    if (_cartItemsList[index].availability < _cartItemsList[index].quantity) {
      return;
    }
    _cartItemsList[index].quantity++;
    _cartItemsList[index].price == _cartItemsList[index].priceAfterDiscount
        ? _totalPrice += _cartItemsList[index].price
        : _totalPrice += _cartItemsList[index].priceAfterDiscount == null
            ? _cartItemsList[index].price
            : _cartItemsList[index].priceAfterDiscount;
    await dbHelper.updateProduct(_cartItemsList[index]);
    notifyListeners();
  }

  decreaseQuantity(int index) async {
    _cartItemsList[index].quantity <= 1
        ? _cartItemsList[index].quantity = 1
        : _cartItemsList[index].quantity--;
    ///////
    _cartItemsList[index].quantity <= 1
        ? _cartItemsList[index].price ==
                _cartItemsList[index].priceAfterDiscount
            ? _totalPrice = _cartItemsList[index].price
            : _totalPrice = _cartItemsList[index].priceAfterDiscount == null
                ? _cartItemsList[index].price
                : _cartItemsList[index].priceAfterDiscount
        : _cartItemsList[index].price ==
                _cartItemsList[index].priceAfterDiscount
            ? _totalPrice -= _cartItemsList[index].price
            : _totalPrice -= _cartItemsList[index].priceAfterDiscount == null
                ? _cartItemsList[index].price
                : _cartItemsList[index].priceAfterDiscount;
    await dbHelper.updateProduct(_cartItemsList[index]);
    notifyListeners();
  }

  // onUpdateQuantity(int index, int quantity) async {
  //   _cartItemsList[index].quantity = quantity;
  //   await dbHelper.updateProduct(_cartItemsList[index]);
  //   //  getTotalPrice();
  //   notifyListeners();
  // }

  deleteCartProduct(int index, int productId) async {
    dbHelper.deleteCartItem(productId);
    _cartItemsList[index].price == _cartItemsList[index].priceAfterDiscount
        ? _totalPrice -= _cartItemsList[index].price
        : _totalPrice -= _cartItemsList[index].priceAfterDiscount == null
            ? _cartItemsList[index].price
            : _cartItemsList[index].priceAfterDiscount;
    await dbHelper.updateProduct(_cartItemsList[index]);
    notifyListeners();
  }

  updateQuantity({int index, int productId, int quantity}) async {
    print("_cartItemsList[$index] - before: ${_cartItemsList[index].quantity}");
    _cartItemsList[index].quantity = quantity;
    print("_cartItemsList[$index] - after: ${_cartItemsList[index].quantity}");

    await dbHelper.updateProduct(_cartItemsList[index]);
    print(
        "dbHelper-_cartItemsList[$index] - after: ${_cartItemsList[index].quantity}");

    // getTotalPrice();
    notifyListeners();
  }

  // deleteTable() {
  //   return dbHelper.deleteTable;
  // }
}
