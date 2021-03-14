import 'dart:io';

import 'package:cizaro_app/model/addressBookModel.dart';
import 'package:cizaro_app/model/addressModel.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;
import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/checkout_results.dart';
import 'package:cizaro_app/model/otp_verification.dart';
import 'package:cizaro_app/model/promo.dart';
import 'package:cizaro_app/model/promoModel.dart';
import 'package:cizaro_app/model/result_ckeck_shopping_cart.dart';
import 'package:cizaro_app/model/shopping_cart.dart';
import 'package:cizaro_app/model/verification_result.dart';
import 'package:cizaro_app/screens/add_address_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:cizaro_app/screens/payments_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/auth_view_model.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/view_model/orders_view_model.dart';
import 'package:cizaro_app/widgets/checkout_item.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      selectedPaymentId;
  dynamic orderId;
  String addressName,
      countryName,
      cityName,
      regionName,
      productSpec,
      paymentUrl;
  double totalOrder,
      shippingFees,
      totalCost,
      arrivalDate,
      totalAfterPromo,
      shippingFeesAfterPromo;
  bool _isLoading = false,
      isVerified = false,
      usesPromo = false,
      _selectedPromoCode = false,
      fromCheckout = true,
      _checkOutDone = false,
      _checkMobileVerificationSend = false;
  AddressModel addressModel;
  CheckoutResult checkoutResult;
  VerificationResult verificationResult;
  Payments payments;
  List<AvailablePayments> _paymentList = [];
  ResultShoppingCartModel resultShoppingCartModel;
  AddressBookModel addressBookModel;
  List<address.Data> addressesList = [];
  TextEditingController _promoCodeController = TextEditingController();
  TextEditingController _verificationCodeController = TextEditingController();
  FToast fToast;
  PromoModel promoModel;

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

  _showAndroidErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Plz! Select Payment Method before Submit your Order',
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

  _showIosErrorDialog() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Error'),
            content:
                Text('Plz! Select Payment Method before Submit your Order'),
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

  sendPromoRequest() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getPromo = Provider.of<ListViewModel>(context, listen: false);
    final promo =
        Promo(addressId: addressId, promoCode: _promoCodeController.text);
    String token = await getToken();
    await getPromo.fetchPromo(promo, token).then((response) {
      promoModel = response;
      totalAfterPromo = promoModel.data.totalCost;
      shippingFeesAfterPromo = promoModel.data.shippingFees;
      usesPromo = true;
    }).catchError(
        (error) => Platform.isIOS ? _showIosDialog() : _showAndroidDialog());
    if (this.mounted) setState(() => _isLoading = false);
  }

  _showAndroidVerifiedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Container(
            height: SizeConfig.blockSizeVertical * 25,
            child: Column(
              children: [
                Text('Plz, Enter Your Verification Code.',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: SizeConfig.blockSizeVertical * 4),
                TextFieldBuild(
                    obscureText: false,
                    readOnly: false,
                    hintText: 'Ex : 123456',
                    textStyle:
                        TextStyle(fontSize: SizeConfig.safeBlockVertical * 2.3),
                    textInputType: TextInputType.number,
                    lineCount: 1,
                    textEditingController: _verificationCodeController),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 50,
                  height: SizeConfig.blockSizeVertical * 7,
                  margin:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 3),
                  child: CupertinoButton(
                      child: Center(
                          child: Text('Send',
                              style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.1))),
                      color: Theme.of(context).primaryColor,
                      onPressed: () => sendOtpVerification(false)),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Resend',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              onPressed: () {
                sendOtpVerification(true);
                _isLoading = false;
              },
            ),
            FlatButton(
              child: Text('Close',
                  style: TextStyle(color: Theme.of(context).primaryColor)),
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

  _showIosVerifiedDialog() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text('Verification',
                style: TextStyle(color: Theme.of(context).primaryColor)),
            content: Padding(
              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Plz, Enter Your Verification Code.',
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1.7),
                  CupertinoTextField(
                      placeholder: 'Ex : 123456',
                      controller: _verificationCodeController,
                      keyboardType: TextInputType.number),
                  Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      height: SizeConfig.blockSizeVertical * 5,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2),
                      child: CupertinoButton(
                          child: Center(
                              child: Text('Send',
                                  style: TextStyle(
                                      fontSize: SizeConfig.safeBlockHorizontal *
                                          4.1))),
                          color: Theme.of(context).primaryColor,
                          onPressed: () => sendOtpVerification(false)))
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Resend'),
                onPressed: () {
                  sendOtpVerification(true);
                  _isLoading = false;
                },
              ),
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

  sendOtpVerification(bool _resendCode) async {
    final verification = Provider.of<AuthViewModel>(context, listen: false);
    String token = await getToken();
    final otpVerification = OtpVerification(
        code: int.parse(_verificationCodeController.text),
        resend: _resendCode,
        addressBookId: addressId);
    await verification.otpVerification(otpVerification, token).then((response) {
      verificationResult = response;
      _checkMobileVerificationSend = verificationResult.data.done;
      _checkMobileVerificationSend == false
          ? showToast(
              title: "Wrong Code! Plz Try Again.",
              icon: CupertinoIcons.arrow_counterclockwise,
              background: Colors.red)
          : showToast(
              title: "Your Code Successfully Send.",
              icon: CupertinoIcons.checkmark_alt_circle,
              background: Color(0xff3A559F));
    }).catchError((error) => print(error));
  }

  sendCheckOut() async {
    if (selectedRadio == 0 || selectedRadio == null)
      return Platform.isIOS ? _showIosErrorDialog() : _showAndroidErrorDialog();
    if (isVerified == false)
      return Platform.isIOS
          ? _showIosVerifiedDialog()
          : _showAndroidVerifiedDialog();
    if (this.mounted) setState(() => _isLoading = true);
    final getCheckout = Provider.of<OrdersViewModel>(context, listen: false);
    String token = await getToken();
    final checkout = CheckOut(
        addressBookId: addressId,
        isCash: selectedRadio == 1 ? false : true,
        paymentApiId: selectedPaymentId);
    await getCheckout.checkOutMethod(token, checkout).then((response) {
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
              arguments: {'payment_url': paymentUrl, 'order_id': orderId}),
          screen: PaymentsScreen(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
    } else {
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: FinishedOrder.routeName),
          screen: FinishedOrder(),
          withNavBar: false,
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
    print(itemsList);
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
    fToast = FToast();
    fToast.init(context);
  }

  showToast({IconData icon, String title, Color background}) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: background),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12.0),
          Text(title, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: true);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    return Scaffold(
      key: _scaffoldKey6,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("complete_order".tr(), _scaffoldKey6, true),
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
                          "shipping_address".tr(),
                          style: TextStyle(
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
                                        name: AddAddressScreen.routeName,
                                        arguments: {
                                          'from_checkout': fromCheckout
                                        }),
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
                              left: SizeConfig.blockSizeHorizontal * 3,
                              right: SizeConfig.blockSizeHorizontal * 3),
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
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(arguments['street_name'] ?? "John Doe",
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
                        left: SizeConfig.blockSizeHorizontal * 3,
                        right: SizeConfig.blockSizeHorizontal * 3),
                    child: Text(
                      "payment_method".tr(),
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
                        Text("credit_card".tr(),
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
                        Text("cash".tr(),
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
                        right: SizeConfig.blockSizeHorizontal * 3,
                        bottom: SizeConfig.blockSizeVertical * 1),
                    child: Text(
                      "items".tr(),
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 4.1),
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: cart.cartProductModel.length,
                    itemBuilder: (ctx, index) => CheckoutItem(
                      imgUrl: cart.cartProductModel[index].mainImg ?? "",
                      productName: cart.cartProductModel[index].name ?? "",
                      productCategory:
                          cart.cartProductModel[index].categoryName ?? "",
                      productPrice: cart.cartProductModel[index].price ==
                              cart.cartProductModel[index].priceAfterDiscount
                          ? cart.cartProductModel[index].price
                          : cart.cartProductModel[index].priceAfterDiscount ==
                                      0.0 ||
                                  cart.cartProductModel[index]
                                          .priceAfterDiscount ==
                                      null
                              ? cart.cartProductModel[index].price
                              : cart.cartProductModel[index]
                                      .priceAfterDiscount ??
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
                                      hintText: 'promo_code'.tr(),
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
                                child: GestureDetector(
                                  onTap: () => sendPromoRequest(),
                                  child: Text(
                                    "add".tr(),
                                    style: TextStyle(
                                      color: Color(0xff3A559F),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPromoCode = true),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3,
                                  right: SizeConfig.blockSizeHorizontal * 3),
                              child: Row(
                                children: [
                                  Icon(Icons.local_offer_rounded,
                                      color: Theme.of(context).primaryColor),
                                  SizedBox(
                                      width:
                                          SizeConfig.blockSizeHorizontal * 10),
                                  Text(
                                    'add_promo'.tr(),
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 4.5,
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 5,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 5),
                                    child: CircleAvatar(
                                      radius:
                                          SizeConfig.blockSizeHorizontal * 3.4,
                                      backgroundColor: Colors.black26,
                                      child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: SizeConfig.blockSizeHorizontal *
                                              4.5,
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
                                          "shipping_fees".tr().toUpperCase() +
                                              " : ",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    5),
                                        usesPromo == false
                                            ? Container(
                                                child: Text(
                                                  shippingFees == null
                                                      ? '0.0'
                                                      : shippingFees
                                                                  .toString() +
                                                              ' LE' ??
                                                          '00.00',
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          5,
                                                      color: Color(0xff3A559F)),
                                                ),
                                              )
                                            : Container(
                                                child: Text(
                                                  shippingFeesAfterPromo == null
                                                      ? '0.0'
                                                      : shippingFeesAfterPromo
                                                                  .toString() +
                                                              ' LE' ??
                                                          '00.00',
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
                                          "total".tr() + " : ",
                                          style: TextStyle(
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    4,
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                SizeConfig.blockSizeVertical *
                                                    1),
                                        usesPromo == false
                                            ? Container(
                                                child: Text(
                                                  totalCost == null
                                                      ? "0.0"
                                                      : totalCost.toString() +
                                                              ' LE' ??
                                                          '00.00',
                                                  style: TextStyle(
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          5,
                                                      color: Color(0xff3A559F)),
                                                ),
                                              )
                                            : Container(
                                                child: Text(
                                                  totalAfterPromo == null
                                                      ? "0.0"
                                                      : totalAfterPromo
                                                                  .toString() +
                                                              ' LE' ??
                                                          '00.00',
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
                                          SizeConfig.blockSizeHorizontal * 2),
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
                                          "place_order".tr(),
                                          style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3.5,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    2),
                                        child: CircleAvatar(
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3.3,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    5,
                                            color: Color(0xff3A559F),
                                          ),
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
