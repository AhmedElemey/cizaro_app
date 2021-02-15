import 'package:cizaro_app/model/addressModel.dart';
import 'package:cizaro_app/screens/checkout_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/address_item.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cizaro_app/model/addressModel.dart' as address;

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

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future getAddressesData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getAddress = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    print(token);
    await getAddress.fetchAddresses(token).then((response) {
      addressModel = response;
      addressesList = addressModel.data;
    });
    if (this.mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getAddressesData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey5,
      drawer: DrawerLayout(),
      body: SingleChildScrollView(
        child: Container(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GradientAppBar("Select Address", _scaffoldKey5),
                    Container(
                      height: MediaQuery.of(context).size.height * .15,
                      padding: EdgeInsets.only(left: 5, top: 15),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                              "Noha Hamza",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff515C6F)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              "Nohahamza@email.com",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.3,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff515C6F)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .6,
                      child: addressesList.length == 0 || addressesList == null
                          ? Center(
                              child: Text(
                                  'No addresses Added yet, please Add One.'))
                          : ListView.builder(
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
                                                'city_name':
                                                    addressesList[index]
                                                        .city
                                                        .name,
                                                'region_name':
                                                    addressesList[index].region
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
                                      cityName:
                                          addressesList[index].city.name ??
                                              "City Name",
                                      countryName:
                                          addressesList[index].country.name ??
                                              "Country",
                                      bgColor: addressesList[index].id ==
                                              indexOfSelectedItemAddress
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                  )),
                    ),
                    Row(
                      children: [
                        SizedBox(),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 20, top: 10),
                          width: MediaQuery.of(context).size.width * .16,
                          height: MediaQuery.of(context).size.height * .06,
                          decoration: BoxDecoration(
                              color: Color(0xff3A559F),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Center(
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
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
