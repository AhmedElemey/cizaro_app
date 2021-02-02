import 'package:cizaro_app/screens/add_address_screen.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/widgets/checkout_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  static final routeName = '/checkout-screen';

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedRadio;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context,listen: true);
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientAppBar("Complete order"),
            Container(
              padding: EdgeInsets.only(left: 10, top: 5),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Checkout",
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff515C6F)),
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
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                        icon : Icon(Icons.add),
                        iconSize : 25,
                        color: Color(0xff3EC429),
                        onPressed: () => Navigator.of(context).pushNamed(AddAddressScreen.routeName)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xff9EA4AF),
                          child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color: Color(0xff3A559F),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Doe",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.5,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F))),
                  Text(
                    "No 123, Sub Street\,",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1,
                  ),
                  Text(
                    "Main Street\,",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1,
                  ),
                  Text(
                    "City Name, Province\,",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1,
                  ),
                  Text(
                    "Country",
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
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
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
                textScaleFactor: MediaQuery.of(context).textScaleFactor * .9,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .35,
              child: ListView.builder(
                itemCount: cart.cartProductModel.length,
                itemBuilder: (ctx, index) => CheckoutItem(
                  imgUrl: cart.cartProductModel[index].mainImg ?? "assets/images/collection.png",
                  productName: cart.cartProductModel[index].name ?? "White Treecode",
                  productCategory: cart.cartProductModel[index].categoryName ?? "men fashion ",
                  productPrice: cart.cartProductModel[index].price ?? 65,
                  productSpecs: 34,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      "Add Promo Code",
                      style: TextStyle(color: Color(0xff3A559F)),
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.5,
                    ),
                  ),
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Color(0xff9EA4AF),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13,
                      color: Color(0xff3A559F),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .07,
                    child: Column(
                      children: [
                        Text(
                          "TOTAL",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * .9,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          child: Text(
                            '\$' + "45454",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.4,
                            style: TextStyle(color: Color(0xff3A559F)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .055,
                    decoration: BoxDecoration(
                        color: Color(0xff3A559F),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "PLACE ORDER",
                            textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
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
                ],
              ),
            ),
            const SizedBox(height: 25)
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
