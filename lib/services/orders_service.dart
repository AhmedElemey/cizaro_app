import 'dart:convert';
import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/order.dart';
import 'package:cizaro_app/model/order_details.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  static const API = 'http://cizaro.tree-code.com/api/v1';

  Future<Order> fetchAllOrders(String token) async {
    final response = await http.get(API + '/orders/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token'
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
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

  Future<OrderDetails> fetchOrderDetails(String token, int orderId) async {
    final response = await http.get(API + '/orders/$orderId/', headers: {
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': '${'Token'} $token'
    });
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(response.body);
      return OrderDetails.fromJson(body);
    } else {
      throw Exception("Unable to perform Request");
    }
  }

  Future<CheckOut> sendCheckOut(String token, CheckOut checkOut) async {
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
      return CheckOut.fromJson(body);
    } else {
      print(response.body);
      throw Exception("Unable to perform request .. Try again!");
    }
  }
}
