import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/checkout_results.dart';
import 'package:cizaro_app/model/order.dart';
import 'package:cizaro_app/model/order_details.dart';
import 'package:cizaro_app/model/pendingShipment.dart';
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

  Future<CheckoutResult> checkOutMethod(String token, CheckOut checkOut) async {
    final result = await OrderServices().sendCheckOut(token, checkOut);
    notifyListeners();
    return result;
  }

  Future<OrderDetails> fetchOrderDetails(String token, int orderId) async {
    final result = await OrderServices().fetchOrderDetails(token, orderId);
    notifyListeners();
    return result;
  }
  Future<PendingShipments> fetchPendingShipmentsOrders(String token) async {
    final result = await OrderServices().fetchPendingShipment(token);
    notifyListeners();
    return result;
  }
}
