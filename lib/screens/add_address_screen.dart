import 'package:cizaro_app/model/countries.dart' as country;
import 'package:cizaro_app/model/createAdressModel.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checkout_screen.dart';

class AddAddressScreen extends StatefulWidget {
  static final routeName = '/add-address-screen';

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  var _currentItemSelectedCountries, _currentItemSelectedCities;
  final _streetController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String token;
  final GlobalKey<ScaffoldState> _scaffoldKey4 = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _streetController.dispose();
    _zipCodeController.dispose();
    _regionController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    return token;
  }

  String validatePhone(String value) {
    if (value.isEmpty) {
      return 'Phone is Required';
    } else if (value.length < 8) {
      return 'PhoneNumber Must be at least 8';
    }
    return null;
  }

  String validateRegion(String value) {
    if (value.isEmpty) {
      return 'Region is Required';
    }
    return null;
  }

  String validateStreet(String value) {
    if (value.isEmpty) {
      return 'Street is Required';
    }
    return null;
  }

  String validateCountry(String value) {
    if (value.isEmpty) {
      return 'Country is Required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey4,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("Add New Address", _scaffoldKey4, true),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: Provider.of<ListViewModel>(context, listen: false)
                      .fetchCountries(
                          token ?? 'c4ce7da269c80455720be2c26c984d8828b88c5f'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<country.Data>> snapshot) {
                    if (snapshot.hasError)
                      return Text(snapshot.error.toString());
                    else
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 1,
                            top: SizeConfig.blockSizeVertical * 2),
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 70,
                          height: SizeConfig.blockSizeVertical * 7,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                                iconSize: SizeConfig.blockSizeHorizontal * 7,
                                iconEnabledColor: Colors.black,
                                dropdownColor: Colors.white,
                                validator: (value) =>
                                    value == null ? 'Country required' : null,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 4),
                                isExpanded: true,
                                hint: Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  child: Text('Country',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  5)),
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true),
                                items: snapshot.data?.map((country.Data data) {
                                      return DropdownMenuItem(
                                        value: data.id,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2),
                                          child: Text(
                                            data.name,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    4),
                                          ),
                                        ),
                                      );
                                    })?.toList() ??
                                    null,
                                onChanged: (newValueSelected) {
                                  setState(() => _currentItemSelectedCountries =
                                      newValueSelected);
                                },
                                value: _currentItemSelectedCountries),
                          ),
                        ),
                      );
                  }),
              FutureBuilder(
                  future: Provider.of<ListViewModel>(context, listen: false)
                      .fetchCountries(
                          token ?? 'c4ce7da269c80455720be2c26c984d8828b88c5f'),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<country.Data>> snapshot) {
                    if (snapshot.hasError)
                      return Text(snapshot.error.toString());
                    else
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 1,
                            top: SizeConfig.blockSizeVertical * 1),
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 70,
                          height: SizeConfig.blockSizeVertical * 6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                                iconSize: SizeConfig.blockSizeHorizontal * 7,
                                iconEnabledColor: Colors.black,
                                dropdownColor: Colors.white,
                                style: const TextStyle(color: Colors.black),
                                isExpanded: true,
                                validator: (value) =>
                                    value == null ? 'City required' : null,
                                hint: Padding(
                                  padding: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 2,
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  child: Text('City',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  5)),
                                ),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(0),
                                    isDense: true),
                                items: snapshot.data != null
                                    ? snapshot.data[0]?.cities
                                            ?.map((country.Cities data) {
                                          return DropdownMenuItem(
                                            value: data.id,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  right: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2,
                                                  left: SizeConfig
                                                          .blockSizeHorizontal *
                                                      2),
                                              child: Text(data.name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: SizeConfig
                                                              .safeBlockHorizontal *
                                                          5)),
                                            ),
                                          );
                                        })?.toList() ??
                                        []
                                    : [],
                                onChanged: (newValueSelected) {
                                  setState(() => _currentItemSelectedCities =
                                      newValueSelected);
                                },
                                value: _currentItemSelectedCities),
                          ),
                        ),
                      );
                  }),
              Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 10,
                padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 1,
                    top: SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: TextFieldBuild(
                    obscureText: false,
                    readOnly: false,
                    textInputType: TextInputType.text,
                    lineCount: 1,
                    hintText: "Street",
                    validator: validateStreet,
                    textStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    textEditingController: _streetController),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 10,
                padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 1,
                    top: SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: TextFieldBuild(
                    obscureText: false,
                    readOnly: false,
                    textInputType: TextInputType.number,
                    lineCount: 1,
                    hintText: "Zip-Code",
                    textStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    textEditingController: _zipCodeController),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 10,
                padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 1,
                    top: SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextFieldBuild(
                    obscureText: false,
                    readOnly: false,
                    textInputType: TextInputType.text,
                    lineCount: 1,
                    textStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    hintText: "Region",
                    validator: validateRegion,
                    textEditingController: _regionController),
              ),
              Container(
                width: SizeConfig.blockSizeHorizontal * 70,
                height: SizeConfig.blockSizeVertical * 10,
                padding: EdgeInsets.only(
                    bottom: SizeConfig.blockSizeVertical * 1,
                    top: SizeConfig.blockSizeVertical * 2),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: TextFieldBuild(
                    obscureText: false,
                    readOnly: false,
                    textInputType: TextInputType.number,
                    lineCount: 1,
                    hintText: "Phone Number",
                    validator: validatePhone,
                    textStyle: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    textEditingController: _phoneController),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 1,
                        right: SizeConfig.blockSizeHorizontal * 2),
                    width: SizeConfig.blockSizeHorizontal * 20,
                    height: SizeConfig.blockSizeVertical * 6,
                    decoration: BoxDecoration(
                        color: Color(0xff3A559F),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: GestureDetector(
                        onTap: () async {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }
                          _formKey.currentState.save();
                          final data = CreateAddress(
                              country: _currentItemSelectedCountries,
                              city: _currentItemSelectedCities,
                              streetAddress: _streetController?.text,
                              phone: _phoneController?.text,
                              region: _regionController?.text,
                              zipCode: _zipCodeController?.text);
                          final getData = Provider.of<ListViewModel>(context,
                              listen: false);
                          String token = await getToken();
                          await getData.fetchAddress(data, token);
                          final Map arguments =
                              ModalRoute.of(context).settings.arguments as Map;
                          bool fromCheckout = arguments['from_checkout'];
                          if (fromCheckout) {
                            pushNewScreenWithRouteSettings(context,
                                settings: RouteSettings(
                                    name: CheckoutScreen.routeName),
                                screen: CheckoutScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade);
                          } else {
                            pushNewScreenWithRouteSettings(context,
                                settings: RouteSettings(
                                    name: AddressBookScreen.routeName),
                                screen: AddressBookScreen(),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.fade);
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.blockSizeHorizontal * 1,
                                vertical: SizeConfig.blockSizeVertical * 1),
                            child: Center(
                                child: Text("ADD",
                                    style: TextStyle(
                                        color: Colors.white,
                                        // fontSize: 15,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4,
                                        fontWeight: FontWeight.bold))))),
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
