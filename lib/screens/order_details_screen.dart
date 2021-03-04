import 'dart:io';

import 'package:cizaro_app/model/order_details.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/orders_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/order_details_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderDetailsScreen extends StatefulWidget {
  static final routeName = '/order-details-screen';

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey57 = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  OrderDetails order;
  List<Items> _ordersList = [];

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getOrdersData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final getOrders = Provider.of<OrdersViewModel>(context, listen: false);
    String token = await getToken();
    print(token);
    await getOrders
        .fetchOrderDetails(token, arguments['order_id'])
        .then((response) {
      order = response;
      _ordersList = order.data.items;
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
      key: _scaffoldKey57,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("Order Details", _scaffoldKey57),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: _ordersList == null || _ordersList.length == 0
                  ? Center(
                      child: Text(
                      'There is No Orders Yet!',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                      ),
                    ))
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _ordersList.length,
                      padding: const EdgeInsets.only(top: 8),
                      itemBuilder: (ctx, index) => OrderDetailsItem(
                            productName: _ordersList[index].product.name,
                            imgUrl: _ordersList[index].product.mainImg,
                            productCategory:
                                _ordersList[index].product.category.name,
                            totalAvailability:
                                _ordersList[index].product.availability,
                            productQuantity: _ordersList[index].quantity,
                            productPrice: _ordersList[index].cashAmount,
                          )),
            ),
    );
  }
}
