import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/order.dart';
import 'package:cizaro_app/services/orders_service.dart';
import 'package:flutter/material.dart';

class OrdersViewModel extends ChangeNotifier {
  Future<Order> fetchOrdersList(String token) async {
    final result = await OrderServices().fetchAllOrders(token);
    notifyListeners();
    return result;
  }

  Future<Payments> fetchAvailablePaymentsList(String token) async {
    final result = await OrderServices().fetchAllPayments(token);
    notifyListeners();
    return result;
  }

  Future<CheckOut> checkOutMethod(String token, CheckOut checkOut) async {
    final result = await OrderServices().sendCheckOut(token, checkOut);
    notifyListeners();
    return result;
  }
}
