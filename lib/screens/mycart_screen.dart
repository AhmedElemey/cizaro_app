import 'package:cizaro_app/screens/checkout_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCartScreen extends StatefulWidget {
  static final routeName = '/my-cart-screen';

  @override
  _MyCartScreenState createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey9 = GlobalKey<ScaffoldState>();
  FToast fToast;
  bool isAvailable = true;
  getProductsOffer() async {
    await Provider.of<CartViewModel>(context, listen: false)
        .getCartItemsAfterOffer();
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getProductsOffer());
    fToast = FToast();
    fToast.init(context);
  }

  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, color: Colors.white),
          SizedBox(width: 12.0),
          Text("no_in_cart".tr(), style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showAvailabilityToast(BuildContext context) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.red,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, color: Colors.white),
          SizedBox(width: 12.0),
          Text("out_stock".tr(), style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  Widget cartProductsList() {
    final cart = Provider.of<CartViewModel>(context, listen: true);
    return cart.cartProductModel.length == 0
        ? Container(
            height: SizeConfig.blockSizeVertical * 70,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 3,
                horizontal: SizeConfig.blockSizeHorizontal * 3),
            child: Center(
                child: Text(
              'no_cart'.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontWeight: FontWeight.bold),
            )))
        : Container(
            height: SizeConfig.blockSizeVertical * 72,
            child: ListView.builder(
                padding:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * .5),
                shrinkWrap: true,
                itemCount: cart.cartProductModel?.length ?? 0,
                itemBuilder: (ctx, index) {
                  return CartItem(
                      item: cart.cartProductModel[index],
                      index: index,
                      cartProvider: cart);
                }));
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: true);
    return Scaffold(
        key: _scaffoldKey9,
        drawer: DrawerLayout(),
        appBar: PreferredSize(
          child: GradientAppBar('cart'.tr(), _scaffoldKey9, false),
          preferredSize: const Size(double.infinity, kToolbarHeight),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              cartProductsList(),
              Container(
                height: SizeConfig.blockSizeVertical * 9,
                padding: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal * 5,
                    left: SizeConfig.blockSizeHorizontal * 5,
                    bottom: SizeConfig.blockSizeVertical * 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'total'.tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                          ),
                          Text(
                            cart.totalPrice.toStringAsFixed(2) + ' le'.tr() ??
                                '00.00',
                            style: TextStyle(
                                color: Color(0xff3A559F),
                                fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                          )
                        ]),
                    GestureDetector(
                      onTap: () async {
                        String token = await getToken();
                        cart.cartProductModel.length == 0
                            ? showToast()
                            : token == null || token.isEmpty
                                ? pushNewScreenWithRouteSettings(context,
                                    settings: RouteSettings(
                                        name: LoginScreen.routeName),
                                    screen: LoginScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade)
                                : cart.cartProductModel.forEach((element) {
                                    if (element.availability == 0 ||
                                            element.quantity == 0
                                        // || element.availability < element.quantity
                                        ) {
                                      isAvailable = false;

                                      return;
                                    }
                                  });
                        if (isAvailable == false) {
                          showAvailabilityToast(context);
                          pushNewScreenWithRouteSettings(context,
                              settings:
                                  RouteSettings(name: MyCartScreen.routeName),
                              screen: MyCartScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade);
                        } else {
                          //showAvailabilityToast(context);
                          pushNewScreenWithRouteSettings(context,
                              settings:
                                  RouteSettings(name: CheckoutScreen.routeName),
                              screen: CheckoutScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade);
                        }
                      },
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        height: SizeConfig.blockSizeVertical * 10,
                        decoration: BoxDecoration(
                            color: Color(0xff3A559F),
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'checkout'.tr(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                                  fontWeight: FontWeight.bold),
                            ),
                            CircleAvatar(
                                radius: SizeConfig.blockSizeHorizontal * 3,
                                backgroundColor: Colors.white,
                                child: Icon(Icons.arrow_forward_ios_rounded,
                                    size: SizeConfig.blockSizeHorizontal * 4,
                                    color: Color(0xff3A559F)))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
