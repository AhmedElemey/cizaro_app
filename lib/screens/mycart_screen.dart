import 'package:cizaro_app/screens/checkout_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/toast_build.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  }

  Widget cartProductsList() {
    final cart = Provider.of<CartViewModel>(context, listen: true);
    return cart.cartProductModel.length == 0
        ? Container(
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(25),
            child: Center(
                child: Text(
                    'Cart is Empty, please Search and Add your Product.',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.3)))
        : Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
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
    return Scaffold(
        key: _scaffoldKey9,
        drawer: DrawerLayout(),
        appBar: PreferredSize(
          child: GradientAppBar("My Cart", _scaffoldKey9),
          preferredSize: const Size(double.infinity, kToolbarHeight),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              cartProductsList(),
              Container(
                height: MediaQuery.of(context).size.height * .1,
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .07,
                      child: Column(children: [
                        Text("TOTAL",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * .9),
                        Spacer(),
                        Text(
                            total.totalPrice.toStringAsFixed(2) + ' LE' ??
                                '00.00',
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.4,
                            style: const TextStyle(color: Color(0xff3A559F))),
                      ]),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  String token = await getToken();
                  total.cartProductModel.length == 0
                      ? ToastBuild(
                          toastMessage: 'Please Add Products in Cart First!',
                          toastIcon: Icons.add,
                          bgColor: Color(0xff3A559F))
                      : token == null || token.isEmpty
                          ? pushNewScreenWithRouteSettings(context,
                              settings:
                                  RouteSettings(name: LoginScreen.routeName),
                              screen: LoginScreen(),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade)
                          : pushNewScreenWithRouteSettings(context,
                              settings:
                                  RouteSettings(name: CheckoutScreen.routeName),
                              screen: CheckoutScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade);
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                      color: Color(0xff3A559F),
                      borderRadius: BorderRadius.circular(25.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "CHECKOUT",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              size: 15, color: Color(0xff3A559F)))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
