import 'dart:io';
import 'package:cizaro_app/model/pendingShipment.dart';
import 'package:cizaro_app/screens/order_details_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/orders_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/order_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingShipmentScreen extends StatefulWidget {
  static final routeName = '/pending-shipment-screen';
  @override
  _PendingShipmentScreenState createState() => _PendingShipmentScreenState();
}

class _PendingShipmentScreenState extends State<PendingShipmentScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  PendingShipments pendingShipments;
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
    await getOrders.fetchPendingShipmentsOrders(token).then((response) {
      pendingShipments = response;
      _ordersList = pendingShipments.data;
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
        child: GradientAppBar("My Pending Shipment", _scaffoldKey),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _ordersList == null || _ordersList.length == 0
                      ? Center(
                          child: Text(
                          'There is No Orders Yet!',
                          style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 5),
                        ))
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _ordersList.length,
                          itemBuilder: (ctx, index) => GestureDetector(
                                onTap: () => pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(
                                        name: OrderDetailsScreen.routeName,
                                        arguments: {
                                          'order_id': _ordersList[index].id
                                        }),
                                    screen: OrderDetailsScreen(),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade),
                                child: OrderItem(
                                    orderId: _ordersList[index].id,
                                    orderNumber: _ordersList[index].orderNumber,
                                    orderDate: _ordersList[index].deliveredDate,
                                    orderPaymentMethod:
                                        _ordersList[index].paymentMethod.value,
                                    orderStatusId:
                                        _ordersList[index].status.key,
                                    orderShippingAddress:
                                        _ordersList[index].address,
                                    orderStatus:
                                        _ordersList[index].status.value,
                                    orderTotal: _ordersList[index].cashAmount +
                                        _ordersList[index].shippingFees),
                              ))
                ],
              ),
            ),
    );
  }
}
