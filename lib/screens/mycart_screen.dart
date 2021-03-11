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
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Added to Cart", style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showAvailabilityToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("There is a Product out of Stock..",
              style: const TextStyle(color: Colors.white))
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
              'Cart is Empty, please Search and Add your Product.',
              style: TextStyle(fontSize: SizeConfig.safeBlockHorizontal * 4),
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
                      imgUrl: cart.cartProductModel[index].mainImg,
                      productName: cart.cartProductModel[index].name,
                      productCategory:
                          cart.cartProductModel[index].categoryName,
                      productPrice: cart.cartProductModel[index].price,
                      productPriceAfterDiscount:
                          cart.cartProductModel[index].priceAfterDiscount,
                      totalAvailability:
                          cart.cartProductModel[index].availability,
                      totalPrice: cart.cartProductModel[index].price ==
                              cart.cartProductModel[index]?.priceAfterDiscount
                          ? cart.cartProductModel[index].price *
                              cart.cartProductModel[index].quantity
                          : cart.cartProductModel[index].priceAfterDiscount ==
                                  null
                              ? cart.cartProductModel[index].price *
                                  cart.cartProductModel[index].quantity
                              : cart.cartProductModel[index]
                                      .priceAfterDiscount *
                                  cart.cartProductModel[index].quantity,
                      productQuantity:
                          cart.cartProductModel[index].quantity ?? 1,
                      sizeSpecValue:
                          cart.cartProductModel[index]?.sizeSpecValue ?? '',
                      colorSpecValue:
                          cart.cartProductModel[index]?.colorSpecValue ?? '',
                      myController: TextEditingController(
                          text:
                              cart.cartProductModel[index].quantity.toString()),
                      onDelete: () {
                        cart.deleteCartProduct(
                            index, cart.cartProductModel[index].id);
                        setState(() {
                          cart.cartProductModel?.removeAt(index);
                        });
                      },
                      index: index,
                      onUpdateQuantity: () => cart.updateQuantity(
                          index,
                          cart.cartProductModel[index].id,
                          cart.cartProductModel[index].quantity),
                      onPlusQuantity: () => cart.increaseQuantity(index),
                      onMinusQuantity: () => cart.decreaseQuantity(index));
                }));
  }

  @override
  Widget build(BuildContext context) {
    final total = Provider.of<CartViewModel>(context, listen: true);
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
                height: SizeConfig.blockSizeVertical * 8,
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
                            "TOTAL",
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                          ),
                          Text(
                            total.totalPrice.toStringAsFixed(2) + ' LE' ??
                                '00.00',
                            style: TextStyle(
                                color: Color(0xff3A559F),
                                fontSize: SizeConfig.safeBlockHorizontal * 3.5),
                          )
                        ]),
                    GestureDetector(
                      onTap: () async {
                        String token = await getToken();
                        total.cartProductModel.length == 0
                            ? showToast()
                            // ToastBuild(
                            //         toastMessage:
                            //             'Please Add Products in Cart First!',
                            //         toastIcon: Icons.add,
                            //         bgColor: Color(0xff3A559F))
                            : token == null || token.isEmpty
                                ? pushNewScreenWithRouteSettings(context,
                                    settings: RouteSettings(
                                        name: LoginScreen.routeName),
                                    screen: LoginScreen(),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade)
                                : cart.cartProductModel.forEach((element) {
                                    element.availability > 0
                                        ? pushNewScreenWithRouteSettings(
                                            context,
                                            settings: RouteSettings(
                                                name: CheckoutScreen.routeName),
                                            screen: CheckoutScreen(),
                                            withNavBar: true,
                                            pageTransitionAnimation:
                                                PageTransitionAnimation.fade)
                                        : showAvailabilityToast();
                                  });
                      },
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 40,
                        height: SizeConfig.blockSizeVertical * 30,
                        decoration: BoxDecoration(
                            color: Color(0xff3A559F),
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "CHECKOUT",
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
