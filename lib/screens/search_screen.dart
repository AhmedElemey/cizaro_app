import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/screens/searchBar_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/search_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = '/search-screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var valueCollection, valueCategory;
  Home home;
  List<Collections> collectionsList = [];
  List<NewArrivals> newArrivalsList = [];

  SearchModel searchModel;
  String productName, imgUrl;
  double productPrice;
  bool _isLoading = false;
  List<SearchProducts> productList;

  Future getShopData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    final getProducts = Provider.of<ListViewModel>(context, listen: false);
    // final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    await getProducts.fetchSearch().then((response) {
      searchModel = response;
      productList = searchModel.data.products;
      print(productList.length);
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  void initState() {
    Future.microtask(() => getShopData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  Future getHomeData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    await getHome.fetchHomeList().then((response) {
      home = response;
      collectionsList = home.data.collections;
      newArrivalsList = home.data.newArrivals;
    });
    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
    displayBottomSheet(context);
  }

  displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "Filter By :",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Filter By Collections :",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.3,
                        ),
                        Spacer(),
                        Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .5,
                          padding: EdgeInsets.only(top: 10, right: 40),
                          child: DropdownButton(
                            hint: Text("Select Collection "),
                            value: valueCollection,
                            dropdownColor: Colors.grey.shade400,
                            items: collectionsList.map((e) {
                              return DropdownMenuItem(
                                child: Text(e.name),
                                value: e.id,
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                valueCollection = value;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Filter By Category :",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.5,
                        ),
                        Spacer(),
                        Container(
                          height: MediaQuery.of(context).size.height * .1,
                          width: MediaQuery.of(context).size.width * .5,
                          padding: EdgeInsets.only(top: 10, right: 40),
                          child: DropdownButton(
                            hint: Text("Select Category"),
                            value: valueCategory,
                            dropdownColor: Colors.grey.shade400,
                            items: newArrivalsList.map((e) {
                              return DropdownMenuItem(
                                child: Text(e.name),
                                value: e.id,
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                valueCategory = newValue;
                              });
                            },
                            isExpanded: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30, left: 150),
                    child: Container(
                      width: MediaQuery.of(context).size.width * .3,
                      height: MediaQuery.of(context).size.height * .06,
                      decoration: BoxDecoration(
                          color: Color(0xff3A559F),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Container(
                        margin: new EdgeInsets.all(10),
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          "Filter",
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
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GradientAppBar(""),
                  Container(
                    height: MediaQuery.of(context).size.height * .1,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 5),
                              width: MediaQuery.of(context).size.width * .24,
                              child: Row(
                                children: [
                                  Text(
                                    productList?.length.toString() ?? '',
                                    style: TextStyle(color: Colors.red),
                                    textScaleFactor:
                                        MediaQuery.textScaleFactorOf(context) *
                                            1.5,
                                  ),
                                  Text(
                                    " Items",
                                    textScaleFactor:
                                        MediaQuery.textScaleFactorOf(context) *
                                            1.5,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 200),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        productList =
                                            productList.reversed.toList();
                                      });
                                    },
                                    child: SvgPicture.asset(
                                      'assets/images/arrow.svg',
                                      width: MediaQuery.of(context).size.width *
                                          0.035,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: GestureDetector(
                                      onTap: () => getHomeData(),
                                      child: Icon(
                                        Icons.filter_alt_outlined,
                                        size: 30,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: productList?.length ?? 0,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            ProductDetails.routeName,
                            arguments: {'product_id': productList[index].id}),
                        child: SearchItem(
                          imgUrl: productList[index].mainImg,
                          productName: productList[index].name,
                          productPrice: productList[index].price,
                          productCategory: productList[index].category.name,
                          //  productQuantity: ,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

// class Search extends SearchDelegate {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return <Widget>[
//       IconButton(
//           icon: Icon(Icons.close),
//           onPressed: () {
//             query = "";
//           })
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           Navigator.pop(context);
//         });
//   }
//
//   String selectedResult;
//   @override
//   Widget buildResults(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text(selectedResult),
//       ),
//     );
//   }
//
//   List<String> recentList = ["Amr", "Baiomey", "Ahmed", "Kareem"];
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     List<String> suggestionList = [];
//     query.isEmpty
//         ? suggestionList = recentList
//         : suggestionList
//             .addAll(recentList.where((element) => element.contains(query)));
//     return ListView.builder(
//       itemCount: suggestionList.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestionList[index]),
//           onTap: () {
//             selectedResult = suggestionList[index];
//             showResults(context);
//           },
//         );
//       },
//     );
//   }
// }
