import 'package:cizaro_app/model/addressBookModel.dart';
import 'package:cizaro_app/model/createAdressModel.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/model/countries.dart' as country;
import 'package:shared_preferences/shared_preferences.dart';

import 'checkout_screen.dart';

class EditAddressScreen extends StatefulWidget {
  static final routeName = '/edit-address-screen';

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  var _currentItemSelectedCountries, _currentItemSelectedCities;
  final _streetController = TextEditingController();
  String addressName, countryName, cityName, regionName, zipCode;
  int phoneNumber, addressId;
  bool _isLoading = false;
  FToast fToast;
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  String token;
  AddressBookModel addressBookModel;
  final GlobalKey<ScaffoldState> _scaffoldKey4 = GlobalKey<ScaffoldState>();

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

  showUpdatedToast() {
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
          Text("Your Address Updated",
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

  // fetchSelectedShippingAddress() async {
  //   if (this.mounted) setState(() => _isLoading = true);
  //   final getAddress = Provider.of<ListViewModel>(context, listen: false);
  //   String token = await getToken();
  //   final Map arguments = ModalRoute.of(context).settings.arguments as Map;
  //   addressId = arguments['address_id'];
  //   await getAddress.fetchShippingAddress(token, addressId).then((response) {
  //     addressBookModel = response;
  //     addressName = addressBookModel.data.streetAddress;
  //     countryName = addressBookModel.data.country.name;
  //     cityName = addressBookModel.data.city.name;
  //     regionName = addressBookModel.data.region;
  //     zipCode = addressBookModel.data.zipCode;
  //     phoneNumber = addressBookModel.data.phone;
  //   }).catchError((error) => pushNewScreenWithRouteSettings(context,
  //       settings: RouteSettings(name: LoginScreen.routeName),
  //       screen: LoginScreen(),
  //       withNavBar: true,
  //       pageTransitionAnimation: PageTransitionAnimation.fade));
  //   if (this.mounted) setState(() => _isLoading = false);
  // }

  @override
  void initState() {
    super.initState();
    // Future.microtask(() => fetchSelectedShippingAddress());
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      key: _scaffoldKey4,
      drawer: DrawerLayout(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("Add New Address", _scaffoldKey4),
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
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              iconSize: 35,
                              iconEnabledColor: Colors.black,
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              isExpanded: true,
                              hint: Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 12),
                                child: Text(
                                    arguments['country_name'] ?? 'Country',
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true),
                              items: snapshot.data?.map((country.Data data) {
                                    return DropdownMenuItem(
                                      value: data.id,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, left: 12),
                                        child: Text(data.name),
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
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              iconSize: 35,
                              iconEnabledColor: Colors.black,
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              isExpanded: true,
                              hint: Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 12),
                                child: Text(arguments['city_name'] ?? 'City',
                                    style:
                                        const TextStyle(color: Colors.black)),
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
                                            padding: const EdgeInsets.only(
                                                right: 12, left: 12),
                                            child: Text(data.name),
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
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.text,
                  lineCount: 1,
                  hintText: arguments['street_name'] ?? "Street",
                  textEditingController: _streetController),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.number,
                  lineCount: 1,
                  hintText: arguments['zip_code'] ?? "Zip-Code",
                  textEditingController: _zipCodeController),
              // TextFieldBuild(
              //   textInputType: TextInputType.number,
              //   textEditingController: _zipCodeController,
              //   // decoration: InputDecoration(
              //   //   hintText: "Zip Code",
              //   //   hintStyle: const TextStyle(color: Colors.black),
              //   //   border: OutlineInputBorder(borderSide: BorderSide()),
              //   // ),
              //   // onClick: (value) {
              //   //   setState(() {
              //   //     _zipCodeController.text = value;
              //   //   });
              //   // },
              // )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.text,
                  lineCount: 1,
                  hintText: arguments['region_name'] ?? "Region",
                  textEditingController: _regionController),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.number,
                  lineCount: 1,
                  hintText: arguments['phone_number'] ?? "Phone Number",
                  textEditingController: _phoneController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 20),
                  width: MediaQuery.of(context).size.width * .2,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                      color: Color(0xff3A559F),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GestureDetector(
                    onTap: () async {
                      final data = CreateAddress(
                          country: _currentItemSelectedCountries ?? 1,
                          city: _currentItemSelectedCities ?? 1,
                          streetAddress: _streetController?.text ??
                              arguments['street_name'],
                          phone: _phoneController?.text == ""
                              ? arguments['phone_number']
                              : _phoneController?.text ??
                                  arguments['phone_number'],
                          region: _regionController?.text == ""
                              ? arguments['region_name']
                              : _regionController?.text ??
                                  arguments['region_name'],
                          zipCode: _zipCodeController?.text == ""
                              ? arguments['zip_code']
                              : _zipCodeController?.text ??
                                  arguments['zip_code']);
                      final getData =
                          Provider.of<ListViewModel>(context, listen: false);
                      String token = await getToken();
                      await getData.updateAddress(
                          data, token, arguments['address_id']);
                      showUpdatedToast();
                    },
                    child: Center(
                        child: Text("Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
