import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cizaro_app/model/addressModel.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;
import 'package:cizaro_app/screens/add_address_screen.dart';
import 'package:cizaro_app/screens/checkout_screen.dart';
import 'package:cizaro_app/screens/edit_address_screen.dart';
import 'package:cizaro_app/screens/profile_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/address_item.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressBookScreen extends StatefulWidget {
  static final routeName = '/address-book-screen';

  @override
  _AddressBookScreenState createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends State<AddressBookScreen> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey5 = GlobalKey<ScaffoldState>();
  AddressModel addressModel;
  List<address.Data> addressesList = [];
  int indexOfSelectedItemAddress = -1;
  bool fromCheckout = false;
  bool languageValue = false;
  bool fromAdded = false;

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  Future getAddressesData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getAddress = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    languageValue = await getLang();
    await getAddress
        .fetchAddresses(
            token,
            languageValue == null
                ? 'en'
                : languageValue == false
                    ? 'en'
                    : 'ar')
        .then((response) {
      addressModel = response;
      addressesList = addressModel.data;
    });
    if (this.mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future deleteAddressesData(int addressId) async {
    final getAddress = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    await getAddress.deleteAddress(token, addressId);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getAddressesData());
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //  print("BACK BUTTON!"); // Do some stuff.
    pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: ProfileScreen.routeName),
        screen: ProfileScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey5,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar('select_address'.tr(), _scaffoldKey5, true),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: _isLoading
              ? Center(
                  child: Platform.isIOS
                      ? CupertinoActivityIndicator()
                      : CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addressesList.length == 0 || addressesList == null
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 3),
                            child: Center(
                                child: Text(
                              'no_address'.tr(),
                              style: TextStyle(
                                  // color: Color(0xff3A559F),
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5),
                            )),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: addressesList.length,
                            itemBuilder: (ctx, index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      indexOfSelectedItemAddress =
                                          addressesList[index].id;
                                    });
                                    pushNewScreenWithRouteSettings(context,
                                        settings: RouteSettings(
                                            name: CheckoutScreen.routeName,
                                            arguments: {
                                              'address_id':
                                                  indexOfSelectedItemAddress,
                                              'street_name':
                                                  addressesList[index]
                                                      .streetAddress,
                                              'country_name':
                                                  addressesList[index]
                                                      .country
                                                      .name,
                                              'city_name': addressesList[index]
                                                  .city
                                                  .name,
                                              'region_name':
                                                  addressesList[index].region,
                                              'from_added': fromAdded
                                            }),
                                        screen: CheckoutScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade);
                                  },
                                  child: AddressItem(
                                    strName:
                                        addressesList[index].streetAddress ??
                                            "John Doe",
                                    strNumber: addressesList[index].zipCode ??
                                        "No 123",
                                    strMain: addressesList[index].region ??
                                        "Main Street",
                                    cityName: addressesList[index].city.name ??
                                        "City Name",
                                    countryName:
                                        addressesList[index].country.name ??
                                            "Country",
                                    bgColor: addressesList[index].id ==
                                            indexOfSelectedItemAddress
                                        ? Colors.blue
                                        : Colors.white,
                                    onEdit: () {
                                      setState(() {
                                        indexOfSelectedItemAddress =
                                            addressesList[index].id;
                                      });
                                      pushNewScreenWithRouteSettings(context,
                                          settings: RouteSettings(arguments: {
                                            'address_id':
                                                indexOfSelectedItemAddress,
                                            'street_name': addressesList[index]
                                                .streetAddress,
                                            'country_name': addressesList[index]
                                                .country
                                                .name,
                                            'city_name':
                                                addressesList[index].city.name,
                                            'region_name':
                                                addressesList[index].region,
                                            'phone_number':
                                                addressesList[index].phone,
                                            'zip_code':
                                                addressesList[index].zipCode
                                          }),
                                          screen: EditAddressScreen(),
                                          withNavBar: true,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.fade);
                                    },
                                    onDelete: () {
                                      deleteAddressesData(
                                          addressesList[index].id);
                                      setState(
                                          () => addressesList.removeAt(index));
                                    },
                                  ),
                                )),
                    Row(
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () => pushNewScreenWithRouteSettings(context,
                              settings: RouteSettings(
                                  name: AddAddressScreen.routeName,
                                  arguments: {'from_checkout': fromCheckout}),
                              screen: AddAddressScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade),
                          child: Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 2,
                                left: SizeConfig.blockSizeHorizontal * 2,
                                top: SizeConfig.blockSizeVertical * 1,
                                bottom: SizeConfig.blockSizeVertical * 3),
                            width: SizeConfig.blockSizeHorizontal * 16,
                            height: SizeConfig.blockSizeHorizontal * 7,
                            decoration: BoxDecoration(
                                color: Color(0xff3A559F),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Center(
                              child: Text(
                                'add'.tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 4.5,
                                  // fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
