import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class PaymentsScreen extends StatefulWidget {
  static final routeName = '/payment-screen';

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  InAppWebViewController webView;
  String url = '';
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return WillPopScope(
      onWillPop: () async {
        String url = await webView.getUrl();
        if (url == arguments['payment_url']) {
          return true;
        } else {
          webView.goBack();
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
