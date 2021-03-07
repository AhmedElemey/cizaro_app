import 'dart:io';

import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/search_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
      appBar: PreferredSize(
        child: GradientAppBar("", _scaffoldKey),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                    height: SizeConfig.blockSizeVertical * 100,
                    child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: ProductDetails.routeName,
                              arguments: {'product_id': productList[index].id}),
                          screen: ProductDetails(),
                          withNavBar: true,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        ),
                        child: SearchItem(
                          productId: productList[index].id,
                          imgUrl: productList[index].mainImg,
                          productName: productList[index].name,
                          productPrice: productList[index].price ?? 0.0,
                          productPriceAfter:
                              productList[index]?.offer?.afterPrice ?? 0.0,
                          productCategory: productList[index].category.name,
                          onAddToFavorite: () {
                            final fav = Provider.of<FavViewModel>(context,
                                listen: false);
                            final productFav = ProductFav(
                                id: productList[index].id,
                                name: productList[index].name,
                                mainImg: productList[index].mainImg,
                                price: productList[index].price,
                                categoryName: productList[index].category.name,
                                isFav: 1);
                            fav.addProductToFav(productFav);
                          },
                          onAddToCart: () {
                            final cart = Provider.of<CartViewModel>(context,
                                listen: false);
                            final productCart = ProductCart(
                                id: productList[index].id,
                                name: productList[index].name,
                                mainImg: productList[index].mainImg,
                                price: productList[index].price,
                                priceAfterDiscount:
                                    productList[index].offer?.afterPrice ??
                                        productList[index].price,
                                categoryName: productList[index].category.name,
                                quantity: 1,
                                availability: productList[index].availability,
                                inCart: 1,
                                colorSpecValue: '',
                                sizeSpecValue: '');
                            cart.addProductToCart(productCart);
                          },
                          //  productQuantity: ,
                        ),
                        // ShopItem(
                        //   imgUrl: productList[index].mainImg,
                        //   productName: productList[index].name,
                        //   productPrice: productList[index].price,
                        //   productPriceAfter:
                        //       productList[index]?.offer?.afterPrice ?? 0.0,
                        //   productId: productList[index].id,
                        //   productCategory: productList[index].category.name,
                        //   productStars: productList[index].stars,
                        // ),
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
