import 'dart:io';
import 'package:cizaro_app/model/addressBookModel.dart';
import 'package:cizaro_app/model/addressModel.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;
import 'package:cizaro_app/model/available_payments.dart';
import 'package:cizaro_app/model/checkout.dart';
import 'package:cizaro_app/model/result_ckeck_shopping_cart.dart';
import 'package:cizaro_app/model/shopping_cart.dart';
import 'package:cizaro_app/screens/add_address_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/finished_order_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
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
      selectedPaymentId;
  String addressName, countryName, cityName, regionName, productSpec;
  double totalOrder, shippingFees, totalCost, arrivalDate;
  bool _isLoading = false, isVerified = false, _selectedPromoCode = false;
  AddressModel addressModel;
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
    }).catchError((error) => pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: LoginScreen.routeName),
        screen: LoginScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade));
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
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: FinishedOrder.routeName),
          screen: FinishedOrder(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade);
    }).catchError(
        (error) => Platform.isIOS ? _showIosDialog() : _showAndroidDialog());
    if (this.mounted) setState(() => _isLoading = false);
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
    }).catchError((error) => pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: LoginScreen.routeName),
        screen: LoginScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade));
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
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Checkout",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 2,
                      style: TextStyle(
                          //   fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 20),
                    child: Row(
                      children: [
                        Text(
                          "SHIPPING ADDRESS",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1,
                          style: TextStyle(
                              //   fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              color: Color(0xff515C6F)),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 25,
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
                              padding: const EdgeInsets.only(left: 10),
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
                                  radius: 15,
                                  backgroundColor: Color(0xff9EA4AF),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
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
                          padding: EdgeInsets.only(left: 10),
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
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1.5,
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff515C6F))),
                                      Text(
                                          addressesList[index].region ??
                                              "Main Street\,",
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1.2,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                      Text(
                                          addressesList[index].city.name ??
                                              "City Name, Province\,",
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                      Text(
                                          addressesList[index].country.name ??
                                              "Country",
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1,
                                          style: TextStyle(
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ],
                                  )
                                : Container(),
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(arguments['street_name'] ?? "John Doe",
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1.5,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff515C6F))),
                              Text(
                                arguments['region_name'] ?? "Main Street\,",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor * 1,
                              ),
                              Text(
                                arguments['city_name'] ??
                                    "City Name, Province\,",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor * 1,
                              ),
                              Text(
                                arguments['country_name'] ?? "Country",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor * 1,
                              ),
                            ],
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      color: Color(0xff515C6F),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "PAYMENT METHOD",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .08,
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
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.5,
                            style: TextStyle(
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
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.5,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff515C6F))),
                      ],
                    ),
                  ),
                  selectedRadio == 1
                      ? Center(
                          child: _paymentList.isEmpty
                              ? Text('Not Available Now!.',
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1)
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Divider(
                      color: Color(0xff515C6F),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "ITEMS",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * .9,
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
                    width: MediaQuery.of(context).size.width * .9,
                    margin: const EdgeInsets.only(top: 23, bottom: 10),
                    child: _selectedPromoCode
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () =>
                                    setState(() => _selectedPromoCode = false),
                                child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.black26,
                                    child: Icon(Icons.close,
                                        size: 13, color: Colors.black45)),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: TextField(
                                  controller: _promoCodeController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      hintText: 'Promo Code',
                                      border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)))),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Text(
                                  "Add",
                                  style: TextStyle(color: Color(0xff3A559F)),
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1.4,
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () =>
                                setState(() => _selectedPromoCode = true),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.local_offer_rounded,
                                      color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 8),
                                  Text('Add Promo Code',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.2),
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Colors.black26,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        size: 10, color: Colors.black45),
                                  )
                                ],
                              ),
                            ),
                          ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .1,
                    padding: EdgeInsets.only(right: 20, left: 20, top: 10),
                    child: Row(
                      children: [
                        const SizedBox(height: 8),
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * .07,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Shipping Fess : ".toUpperCase(),
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  .9,
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          child: Text(
                                            shippingFees.toString() + ' LE' ??
                                                '00.00',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    1.3,
                                            style: TextStyle(
                                                color: Color(0xff3A559F)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "TOTAL : ",
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  .9,
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          child: Text(
                                            totalCost.toString() + ' LE' ??
                                                '00.00',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    1.3,
                                            style: TextStyle(
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
                                onTap: () => sendCheckOut(),
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.height * .058,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3A559F),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text(
                                          "PLACE ORDER",
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
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
                  const SizedBox(height: 20)
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
