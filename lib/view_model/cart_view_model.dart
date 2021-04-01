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
    } else {
      _totalPrice = 0.0;
      for (int i = 0; i < _cartItemsList.length; i++) {
        print("index: $i - $_totalPrice");
        _totalPrice += getTotalPriceOfItem(_cartItemsList[i]);
        print("index: $i - after- $_totalPrice");
      }
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
    getTotalPrice();
    notifyListeners();
  }

  increaseQuantity(int index) async {
    if (_cartItemsList[index].availability < _cartItemsList[index].quantity) {
      return;
    } else {
      _cartItemsList[index].quantity++;
      print("quantity after: ${_cartItemsList[index].quantity}");
    }
    await dbHelper.updateProduct(_cartItemsList[index]);
    getTotalPrice();
    notifyListeners();
  }

  decreaseQuantity(int index) async {
    if (_cartItemsList[index].quantity <= 1) {
      _cartItemsList[index].quantity = 1;
    } else {
      _cartItemsList[index].quantity--;
    }
    await dbHelper.updateProduct(_cartItemsList[index]);
    getTotalPrice();
    notifyListeners();
  }

  deleteCartProduct({int index, int productId}) async {
    dbHelper.deleteCartItem(productId);
    await dbHelper.updateProduct(_cartItemsList[index]);
    _cartItemsList?.removeAt(index);
    getTotalPrice();
    notifyListeners();
  }

  updateQuantity({int index, int productId, int quantity}) async {
    _cartItemsList[index].quantity = quantity;
    await dbHelper.updateProduct(_cartItemsList[index]);
    getTotalPrice();
    notifyListeners();
  }

  double getTotalPriceOfItem(ProductCart item) {
    print("getTotalPriceOfItem: p:${item.price} q:${item.quantity}");
    double total = item.price == item?.priceAfterDiscount
        ? item.price * item.quantity
        : item.priceAfterDiscount == null || item.priceAfterDiscount == 0.0
            ? item.price * item.quantity
            : item.priceAfterDiscount * item.quantity;
    print("after: $total");
    return total;
  }
}
