import 'package:cizaro_app/model/order.dart';
import 'package:cizaro_app/view_model/orders_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreen extends StatefulWidget {
  static final routeName = '/orders-screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  Order order;
  List<Data> _ordersList = [];

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getOrdersData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getOrders = Provider.of<OrdersViewModel>(context, listen: false);
    String token = await getToken();
    print(token);
    await getOrders.fetchOrdersList(token).then((response) {
      order = response;
      _ordersList = order.data;
    });
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getOrdersData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        child: GradientAppBar("My Orders", _scaffoldKey),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  _ordersList == null || _ordersList.length == 0
                      ? Center(
                          child: Text('There is No Orders Yet!',
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.5))
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _ordersList.length,
                          itemBuilder: (ctx, index) => OrderItem(
                              orderId: _ordersList[index].orderNumber,
                              orderDate: _ordersList[index].deliveredDate,
                              orderPaymentMethod:
                                  _ordersList[index].paymentMethod.value,
                              orderStatusId: _ordersList[index].status.key,
                              orderShippingAddress: _ordersList[index].address,
                              orderStatus: _ordersList[index].status.value,
                              orderTotal: _ordersList[index].cashAmount +
                                  _ordersList[index].shippingFees))
                ],
              ),
            ),
    );
  }
}
