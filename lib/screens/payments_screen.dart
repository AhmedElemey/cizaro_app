import 'package:cizaro_app/model/checkPaymentModel.dart';
import 'package:cizaro_app/model/order_id_model.dart';
import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:cizaro_app/screens/tabs_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentsScreen extends StatefulWidget {
  static final routeName = '/payment-screen';

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  InAppWebViewController webView;
  String url = '';
  bool status;
  bool _isLoading = false;
  CheckPaymentModel payment;

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getPaymentData() async {
    if (this.mounted) setState(() => _isLoading = true);
    String token = await getToken();
    print(token);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    dynamic orderId = arguments['order_id'];
    final orderIdModel = OrderIdModel(orderId: orderId);
    final getPayment = Provider.of<ListViewModel>(context, listen: false);
    await getPayment.checkPayment(orderIdModel, token).then((response) {
      payment = response;
      status = response.data.success;
    });
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return WillPopScope(
      onWillPop: () async {
        String url = await webView.getUrl();
        await getPaymentData();
        if (status == true) {
          pushNewScreenWithRouteSettings(context,
              settings: RouteSettings(name: FinishedOrder.routeName),
              screen: FinishedOrder(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.fade);
          return false;
        }
        if (url == arguments['payment_url']) {
          return true;
        } else {
          webView.goBack();
          pushNewScreenWithRouteSettings(context,
              settings: RouteSettings(name: TabsScreen.routeName),
              screen: TabsScreen(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.fade);
          return false;
        }
      },
      child: Scaffold(
        body: Container(
          child: SafeArea(
            child: InAppWebView(
              initialUrl: arguments['payment_url'],
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    debuggingEnabled: true,
                  ),
                  android: AndroidInAppWebViewOptions(initialScale: 200)),
            ),
          ),
        ),
      ),
    );
  }
}
