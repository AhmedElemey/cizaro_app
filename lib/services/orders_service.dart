import 'dart:convert';

import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/checkout_results.dart';
import 'package:cizaro_app/model/order.dart';
import 'package:cizaro_app/model/order_details.dart';
import 'package:cizaro_app/model/pendingShipment.dart';
import 'package:cizaro_app/widgets/json_util.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  static const API = 'http://cizaro.net/api/v1';

  Future<Order> fetchAllOrders(String token, String lang) async {
    final response = await http.get(API + '/orders/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token',
      'Accept-Language': '$lang'
    });
    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body);
      // print(response.body);
      final body = jsonDecodeUtf8(response.bodyBytes);
      return Order.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<Payments> fetchAllPayments(String token) async {
    final response = await http.get(API + '/payments-api/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token'
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
      return Payments.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<OrderDetails> fetchOrderDetails(
      String token, int orderId, String lang) async {
    final response = await http.get(API + '/orders/$orderId/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token',
      'Accept-Language': '$lang'
    });
    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body);
      // print(response.body);
      final body = jsonDecodeUtf8(response.bodyBytes);
      return OrderDetails.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<PendingShipments> fetchPendingShipment(
      String token, String lang) async {
    final response = await http.get(API + '/pending-shipment/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token',
      'Accept-Language': '$lang'
    });
    if (response.statusCode == 200) {
      // final body = jsonDecode(response.body);
      // print(response.body);
      final body = jsonDecodeUtf8(response.bodyBytes);
      return PendingShipments.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<CheckoutResult> sendCheckOut(String token, CheckOut checkOut) async {
    final response = await http.post(API + '/check-out/',
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': '${'Token'} $token'
        },
        body: jsonEncode(checkOut.toJson()));
    final body = jsonDecode(response.body);
    print(response.body);
    if (response.statusCode == 200 || body['message'] == '') {
      return CheckoutResult.fromJson(body);
    } else {
      throw Exception("Unable to perform request .. Try again!");
    }
  }
}
