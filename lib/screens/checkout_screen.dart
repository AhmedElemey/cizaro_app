import 'dart:io';

import 'package:cizaro_app/model/addressBookModel.dart';
import 'package:cizaro_app/model/addressModel.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;
import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/checkout_results.dart';
import 'package:cizaro_app/model/result_ckeck_shopping_cart.dart';
import 'package:cizaro_app/model/shopping_cart.dart';
import 'package:cizaro_app/screens/add_address_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/screens/payments_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/view_model/orders_view_model.dart';
import 'package:cizaro_app/widgets/checkout_item.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutScreen extends StatefulWidget {
  static final routeName = '/checkout-screen';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey6 = GlobalKey<ScaffoldState>();
  int selectedRadio,
      addressId,
      productId,
      productQuantity,
      selectedPaymentRadio,
      selectedPaymentId,
      orderId;
  String addressName,
      countryName,
      cityName,
      regionName,
      productSpec,
      paymentUrl;
  double totalOrder, shippingFees, totalCost, arrivalDate;
  bool _isLoading = false,
      isVerified = false,
      _selectedPromoCode = false,
      _checkOutDone = false;
  AddressModel addressModel;
  CheckoutResult checkoutResult;
  Payments payments;
  List<AvailablePayments> _paymentList = [];
  ResultShoppingCartModel resultShoppingCartModel;
  AddressBookModel addressBookModel;
  List<address.Data> addressesList = [];
  TextEditingController _promoCodeController = TextEditingController();

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  setSelectedRadio(int val) {
    setState(() => selectedRadio = val);
  }

  setSelectedPaymentRadio(int val) {
    setState(() => selectedPaymentRadio = val);
  }

  fetchLastShippingAddress() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getAddress = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    print(token);
    await getAddress.fetchAddresses(token).then((response) {
      addressModel = response;
      addressesList = addressModel.data;
      addressId = addressModel.data[0].id;
    }).catchError((error) => print(error));
    // pushNewScreenWithRouteSettings(context,
    // settings: RouteSettings(name: LoginScreen.routeName),
    // screen: LoginScreen(),
    // withNavBar: true,
    // pageTransitionAnimation: PageTransitionAnimation.fade));
    fetchTotalOrder();
    if (this.mounted) {
      setState(() => _isLoading = false);
    }
  }

  fetchPaymentsList() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getAddress = Provider.of<OrdersViewModel>(context, listen: false);
    String token = await getToken();
    await getAddress.fetchAvailablePaymentsList(token).then((response) {
      payments = response;
      _paymentList = payments.data.availablePayments;
    });
    fetchTotalOrder();
    if (this.mounted) setState(() => _isLoading = false);
  }

  _showAndroidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Mobile Number not Verified!',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            FlatButton(
              child: Text('Close',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                _isLoading = false;
              },
            ),
          ],
        );
      },
    );
  }

  _showIosDialog() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content: Text('Mobile Number not Verified!'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _isLoading = false;
                },
              ),
            ],
          );
        });
  }

  sendCheckOut() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getAddress = Provider.of<OrdersViewModel>(context, listen: false);
    String token = await getToken();
    final checkout = CheckOut(
        addressBookId: addressId,
        isCash: selectedRadio == 1 ? false : true,
        paymentApiId: selectedPaymentId);
    await getAddress.checkOutMethod(token, checkout).then((response) {
      checkoutResult = response;
      paymentUrl = checkoutResult.data.paymentUrl;
      orderId = checkoutResult.data.orderId;
      _checkOutDone = checkoutResult.data.done;
      checkPaymentsOptions();
    }).catchError(
        (error) => Platform.isIOS ? _showIosDialog() : _showAndroidDialog());
    if (this.mounted) setState(() => _isLoading = false);
  }

  checkPaymentsOptions() {
    // online payments
    if (paymentUrl != null) {
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(
              name: PaymentsScreen.routeName,
              arguments: {'payment_url': paymentUrl}),
          screen: PaymentsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
    } else {
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: FinishedOrder.routeName),
          screen: FinishedOrder(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.fade);
    }
  }

  fetchSelectedShippingAddress() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getAddress = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    addressId = arguments['address_id'];
    await getAddress.fetchShippingAddress(token, addressId).then((response) {
      addressBookModel = response;
      addressName = addressBookModel.data.streetAddress;
      countryName = addressBookModel.data.country.name;
      cityName = addressBookModel.data.city.name;
      regionName = addressBookModel.data.region;
    }).catchError((error) => print(error));
    // pushNewScreenWithRouteSettings(context,
    // settings: RouteSettings(name: LoginScreen.routeName),
    // screen: LoginScreen(),
    // withNavBar: true,
    // pageTransitionAnimation: PageTransitionAnimation.fade));
    fetchTotalOrder();
    if (this.mounted) setState(() => _isLoading = false);
  }

  fetchTotalOrder() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getTotalOrder = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    List<Items> itemsList = [];
    Provider.of<CartViewModel>(context, listen: false)
        .cartProductModel
        .forEach((element) {
      productId = element.id;
      productQuantity = element.quantity;
      productSpec = element.sizeSpecValue == null
          ? ''
          : element.sizeSpecValue + ',' + element.colorSpecValue == null
              ? ''
              : element.colorSpecValue;
      itemsList.add(Items(
          product: productId,
          quantity: productQuantity,
          specs: productSpec ?? ''));
    });
    final shoppingCart =
        ShoppingCartModel(addressBookId: addressId, items: itemsList);
    await getTotalOrder
        .fetchResultOfShippingCart(shoppingCart, token)
        .then((response) {
      resultShoppingCartModel = response;
      totalOrder = resultShoppingCartModel.data.totalOrder;
      shippingFees = resultShoppingCartModel.data.shippingFees;
      totalCost = resultShoppingCartModel.data.totalCost;
      isVerified = resultShoppingCartModel.data.verified;
    }).catchError((error) => print(error));
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    Future.microtask(() => addressId == null
        ? fetchLastShippingAddress()
        : fetchSelectedShippingAddress());
    Future.microtask(() => fetchPaymentsList());
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: true);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      key: _scaffoldKey6,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("Complete Order", _scaffoldKey6),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3,
                        right: SizeConfig.blockSizeHorizontal * 3),
                    child: Row(
                      children: [
                        Text(
                          "SHIPPING ADDRESS",
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1,
                          style: TextStyle(
                              //   fontWeight: FontWeight.bold,
                              // fontSize: 15,
                              fontSize: SizeConfig.safeBlockHorizontal * 4.5,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff515C6F)),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.add),
                                iconSize: SizeConfig.blockSizeHorizontal * 7,
                                color: Color(0xff3EC429),
                                onPressed: () => pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(
                                        name: AddAddressScreen.routeName),
                                    screen: AddAddressScreen(),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade)),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 1),
                              child: GestureDetector(
                                onTap: () => pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(
                                        name: AddressBookScreen.routeName),
                                    screen: AddressBookScreen(),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade),
                                child: CircleAvatar(
                                  radius: SizeConfig.blockSizeHorizontal * 3,
                                  backgroundColor: Color(0xff9EA4AF),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: SizeConfig.blockSizeHorizontal * 5,
                                    color: Color(0xff3A559F),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  arguments == null
                      ? Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3),
                          child: ListView.builder(
                            itemCount: addressesList.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => index == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          addressesList[index].streetAddress ??
                                              "John Doe",
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         1.5,
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                              color: Color(0xff515C6F))),
                                      Text(
                                          addressesList[index].region ??
                                              "Main Street\,",
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         1.2,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                      Text(
                                          addressesList[index].city.name ??
                                              "City Name, Province\,",
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         1,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                      Text(
                                          addressesList[index].country.name ??
                                              "Country",
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         1,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  )
                                : Container(),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(arguments['street_name'] ?? "John Doe",
                                  // textScaleFactor:
                                  //     MediaQuery.of(context).textScaleFactor *
                                  //         1.5,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff515C6F))),
                              Text(
                                arguments['region_name'] ?? "Main Street\,",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4),
                                // textScaleFactor:
                                //     MediaQuery.of(context).textScaleFactor * 1,
                              ),
                              Text(
                                arguments['city_name'] ??
                                    "City Name, Province\,",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4),
                              ),
                              Text(
                                arguments['country_name'] ?? "Country",
                                style: TextStyle(
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4),
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3,
                        right: SizeConfig.blockSizeHorizontal * 3),
                    child: Divider(
                      color: Color(0xff515C6F),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3),
                    child: Text(
                      "PAYMENT METHOD",
                      // textScaleFactor:
                      //     MediaQuery.of(context).textScaleFactor * 1,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.1),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    height: SizeConfig.blockSizeVertical * 10,
                    child: ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            setSelectedRadio(val);
                          },
                        ),
                        Text("Credit Card  ",
                            // textScaleFactor:
                            //     MediaQuery.of(context).textScaleFactor * 1.5,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff515C6F))),
                        Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (val) {
                            setSelectedRadio(val);
                          },
                        ),
                        Text("Cash",
                            // textScaleFactor:
                            //     MediaQuery.of(context).textScaleFactor * 1.5,
                            style: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 5.5,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff515C6F))),
                      ],
                    ),
                  ),
                  selectedRadio == 1
                      ? Center(
                          child: _paymentList.isEmpty
                              ? Text(
                                  'Not Available Now!.',
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5),
                                  // textScaleFactor:
                                  //     MediaQuery.of(context).textScaleFactor *
                                  //         1
                                )
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _paymentList.length,
                                  itemBuilder: (ctx, index) => RadioListTile(
                                        value: index,
                                        activeColor:
                                            Theme.of(context).primaryColor,
                                        secondary: Image.network(
                                            _paymentList[index].logo),
                                        groupValue: selectedPaymentRadio,
                                        onChanged: (val) {
                                          setSelectedPaymentRadio(val);
                                          selectedPaymentId =
                                              _paymentList[index].id;
                                          print(selectedPaymentId);
                                        },
                                        title: Text(_paymentList[index].name),
                                      )))
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3,
                        right: SizeConfig.blockSizeHorizontal * 3),
                    child: Divider(
                      color: Color(0xff515C6F),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 3,
                        bottom: SizeConfig.blockSizeVertical * 1),
                    child: Text(
                      "ITEMS",
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.1),
                      // textScaleFactor:
                      //     MediaQuery.of(context).textScaleFactor * .9,
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cart.cartProductModel.length,
                    itemBuilder: (ctx, index) => CheckoutItem(
                      imgUrl: cart.cartProductModel[index].mainImg ??
                          "assets/images/collection.png",
                      productName:
                          cart.cartProductModel[index].name ?? "White Treecode",
                      productCategory:
                          cart.cartProductModel[index].categoryName ??
                              "men fashion ",
                      productPrice: cart.cartProductModel[index].price ==
                              cart.cartProductModel[index].priceAfterDiscount
                          ? cart.cartProductModel[index].price
                          : cart.cartProductModel[index].priceAfterDiscount ??
                              0.0,
                      productSizeSpecs:
                          cart.cartProductModel[index].sizeSpecValue ?? '',
                      productColorSpecs:
                          cart.cartProductModel[index].colorSpecValue == null
                              ? Colors.white
                              : Color(int.parse('0xff' +
                                      cart.cartProductModel[index]
                                          .colorSpecValue
                                          .split('#')
                                          .last) ??
                                  ''),
                    ),
                  ),
                  Container(
                    width: SizeConfig.blockSizeHorizontal * 100,
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        bottom: SizeConfig.blockSizeVertical * 1),
                    child: _selectedPromoCode
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedPromoCode = false),
                                child: CircleAvatar(
                                    radius: SizeConfig.blockSizeHorizontal * 3,
                                    backgroundColor: Colors.black26,
                                    child: Icon(Icons.close,
                                        size: SizeConfig.blockSizeHorizontal *
                                            4.5,
                                        color: Colors.black45)),
                              ),
                              Container(
                                height: SizeConfig.blockSizeVertical * 6,
                                width: SizeConfig.blockSizeHorizontal * 50,
                                child: TextField(
                                  controller: _promoCodeController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(
                                          right:
                                              SizeConfig.blockSizeHorizontal *
                                                  1,
                                          left: SizeConfig.blockSizeHorizontal *
                                              4),
                                      hintText: 'Promo Code',
                                      hintStyle: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(SizeConfig
                                                      .blockSizeHorizontal *
                                                  4)))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 3,
                                    right: SizeConfig.blockSizeHorizontal * 3),
                                child: Text(
                                  "Add",
                                  style: TextStyle(
                                    color: Color(0xff3A559F),
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5,
                                  ),

                                  // textScaleFactor:
                                  //     MediaQuery.of(context).textScaleFactor *
                                  //         1.4,
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPromoCode = true),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3),
                              child: Row(
                                children: [
                                  Icon(Icons.local_offer_rounded,
                                      color: Theme.of(context).primaryColor),
                                  SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 10),
                                  Text(
                                    'Add Promo Code',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5,
                                    ),

                                    // textScaleFactor: MediaQuery.of(context)
                                    //         .textScaleFactor *
                                    //     1.2
                                  ),
                                  SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 20),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 5),
                                    child: CircleAvatar(
                                      radius:
                                          SizeConfig.blockSizeHorizontal * 4,
                                      backgroundColor: Colors.black26,
                                      child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: SizeConfig.blockSizeHorizontal *
                                              5,
                                          color: Colors.black45),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                  Container(
                    height: SizeConfig.blockSizeVertical * 15,
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 3,
                        left: SizeConfig.blockSizeHorizontal * 3,
                        top: SizeConfig.blockSizeVertical * 1),
                    child: Row(
                      children: [
                        SizedBox(height: SizeConfig.blockSizeVertical * 1),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height: SizeConfig.blockSizeVertical * 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Shipping Fess : ".toUpperCase(),
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                          ),
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         .9,
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    5),
                                        Container(
                                          child: Text(
                                            shippingFees == null
                                                ? '0.0'
                                                : shippingFees.toString() +
                                                        ' LE' ??
                                                    '00.00',
                                            // textScaleFactor:
                                            //     MediaQuery.of(context)
                                            //             .textScaleFactor *
                                            //         1.3,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    5,
                                                color: Color(0xff3A559F)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "TOTAL : ",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                          ),
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         .9,
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    1),
                                        Container(
                                          child: Text(
                                            totalCost == null
                                                ? "0.0"
                                                : totalCost.toString() +
                                                        ' LE' ??
                                                    '00.00',
                                            // textScaleFactor:
                                            //     MediaQuery.of(context)
                                            //             .textScaleFactor *
                                            //         1.3,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    5,
                                                color: Color(0xff3A559F)),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  sendCheckOut();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right:
                                          SizeConfig.blockSizeHorizontal * 3),
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  height: SizeConfig.blockSizeVertical * 6,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3A559F),
                                      borderRadius: BorderRadius.circular(
                                          SizeConfig.blockSizeHorizontal * 7)),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    4.5),
                                        child: Text(
                                          "PLACE ORDER",
                                          // textScaleFactor:
                                          //     MediaQuery.of(context)
                                          //             .textScaleFactor *
                                          //         1,
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        radius: SizeConfig.blockSizeHorizontal *
                                            3.3,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: SizeConfig.blockSizeHorizontal *
                                              5,
                                          color: Color(0xff3A559F),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 5)
                ],
              ),
            ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  List<String> recentList = ["Amr", "Baiomey", "Ahmed", "Kareem"];
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList
            .addAll(recentList.where((element) => element.contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
