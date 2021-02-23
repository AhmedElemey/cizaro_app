import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentsScreen extends StatefulWidget {
  static final routeName = '/payment-screen';
  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  WebViewController controller;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return WillPopScope(
      onWillPop: () async {
        String url = await controller.currentUrl();
        if (url == arguments['payment_url']) {
          return true;
        } else {
          controller.goBack();
          pushNewScreenWithRouteSettings(context,
              settings: RouteSettings(name: FinishedOrder.routeName),
              screen: FinishedOrder(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.fade);
          return false;
        }
      },
      child: Scaffold(
        body: Container(
          child: SafeArea(
            child: WebView(
              initialUrl: arguments['payment_url'],
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController wc) {
                controller = wc;
              },
            ),
          ),
        ),
      ),
    );
  }
}
