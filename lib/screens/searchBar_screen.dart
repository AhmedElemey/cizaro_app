import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/search_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBarScreen extends StatefulWidget {
  static final routeName = '/searchBar-screen';
  @override
  _SearchBarItemState createState() => _SearchBarItemState();
}

class _SearchBarItemState extends State<SearchBarScreen> {
  List<SearchProducts> productList;
  SearchModel searchBarModel;
  bool _isLoading = false;
  static const historyLength = 5;
  FloatingSearchBarController controller;

  // The "raw" history that we don't access from the UI, prefilled with values
  List<String> _searchHistory = [];
// The filtered & ordered history that's accessed from the UI
  List<String> filteredSearchHistory;

// The currently searched-for term
  String selectedTerm;

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      // This method will be implemented soon
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }
    // Changes in _searchHistory mean that we have to update the filteredSearchHistory
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  Future getSearchData(String query) async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    final getProducts = Provider.of<ListViewModel>(context, listen: false);
    bool languageValue = await getLang();
    await getProducts
        .fetchSearchBar(
            query,
            languageValue == null
                ? 'en'
                : languageValue == false
                    ? 'en'
                    : 'ar')
        .then((response) {
      searchBarModel = response;
      productList = searchBarModel.data.products;
      print(productList.length);

      // print(productList.data.relatedProducts.length);
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
  }

  List<String> filterSearchTerms({
    @required String filter,
  }) {
    if (filter != null && filter.isNotEmpty) {
      // Reversed because we want the last added items to appear first in the UI
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(filter: null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: FloatingSearchBar(
        transition: CircularFloatingSearchBarTransition(),
// Bouncing physics for the search history
        physics: BouncingScrollPhysics(),
// Title is displayed on an unopened (inactive) search bar
        title: Text(
          selectedTerm ?? 'the_search'.tr(),
          style: Theme.of(context).textTheme.headline6,
        ),
// Hint gets displayed once the search bar is tapped and opened
        hint: 'search_find'.tr(),
        controller: controller,
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(filter: query);
          });
        },
        onSubmitted: (query) {
          getSearchData(query);
          controller.close();
        },

        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(
                builder: (context) {
                  if (filteredSearchHistory.isEmpty &&
                      controller.query.isEmpty) {
                    return Container(
                      height: 56,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'start_search'.tr(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else if (filteredSearchHistory.isEmpty) {
                    return ListTile(
                      title: Text(controller.query),
                      leading: const Icon(Icons.search),
                      onTap: () {
                        setState(() {
                          addSearchTerm(controller.query);
                          selectedTerm = controller.query;
                        });
                        controller.close();
                      },
                    );
                  } else {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: filteredSearchHistory
                          .map(
                            (term) => ListTile(
                              title: Text(
                                term,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: const Icon(Icons.history),
                              trailing: IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    deleteSearchTerm(term);
                                  });
                                },
                              ),
                              onTap: () {
                                setState(() {
                                  putSearchTermFirst(term);
                                  selectedTerm = term;
                                });
                                controller.close();
                              },
                            ),
                          )
                          .toList(),
                    );
                  }
                },
              ),
            ),
          );
        },
        body: FloatingSearchBarScrollNotifier(
          child: SearchResultsListView(
            searchTerm: selectedTerm,
            productList: productList,
          ),
        ),
      ),
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  final String searchTerm;
  final List<SearchProducts> productList;
  SearchResultsListView({Key key, @required this.searchTerm, this.productList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fsb = FloatingSearchBar.of(context);

    if (searchTerm == null && productList == null || productList?.length == 0) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search,
              size: 64,
            ),
            Text(
              'start_search'.tr(),
              style: Theme.of(context).textTheme.headline5,
            )
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: fsb.height + fsb.margins.vertical),
      child: Container(
        height: SizeConfig.blockSizeVertical * 100,
        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 3),
        width: double.infinity,
        child: ListView.builder(
          itemCount: productList?.length ?? 0,
          itemBuilder: (ctx, index) => GestureDetector(
            onTap: () => pushNewScreenWithRouteSettings(
              context,
              settings:
                  RouteSettings(name: ProductDetails.routeName, arguments: {
                'product_id': productList[index].id,
                // 'after_price': productList[index]?.offer?.afterPrice ?? 0.0,
              }),
              screen: ProductDetails(),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.fade,
            ),
            child: SearchItem(
              imgUrl: productList[index].mainImg,
              productName: productList[index].name,
              productPrice: productList[index].price,
              productCategory: productList[index].category.name,
              productPriceAfter: productList[index].offer?.afterPrice ?? 0.0,
              onAddToFavorite: () {
                final fav = Provider.of<FavViewModel>(context, listen: false);
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
                final cart = Provider.of<CartViewModel>(context, listen: false);
                final productCart = ProductCart(
                    id: productList[index].id,
                    name: productList[index].name,
                    mainImg: productList[index].mainImg,
                    price: productList[index].price,
                    priceAfterDiscount: productList[index].offer?.afterPrice ??
                        productList[index].price,
                    categoryName: productList[index].category.name,
                    quantity: 1,
                    availability: productList[index].availability,
                    colorSpecValue: '',
                    sizeSpecValue: '');
                cart.addProductToCart(productCart);
              },
              //  productQuantity: ,
            ),
          ),
        ),
      ),
    );
  }
}
