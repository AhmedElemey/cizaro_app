import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/shop_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  static final routeName = '/product-screen';

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ShopModel shopModel;
  String productName, imgUrl, productDescription;
  double productPrice, productStar;
  bool _isLoading = false;
  List<Products> productList = [];

  Future getShopData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    final getProducts = Provider.of<ListViewModel>(context, listen: false);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    await getProducts.fetchShop(arguments['collection_id']).then((response) {
      shopModel = response;
      productList = shopModel.data.products;
      print(productList.length);
      // print(productList.data.relatedProducts.length);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerLayout(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GradientAppBar("", _scaffoldKey),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            ProductDetails.routeName,
                            arguments: {'product_id': productList[index].id}),
                        child: ShopItem(
                          imgUrl: productList[index].mainImg,
                          productName: productList[index].name,
                          productPrice: productList[index].price,
                          productPriceAfter:
                              productList[index]?.offer?.afterPrice ?? 0.0,
                          productId: productList[index].id,
                          productCategory: productList[index].category.name,
                          productStars: productList[index].stars,
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
