import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/collection_item.dart';
import 'package:cizaro_app/widgets/custom_tab_bar.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/hotDeals_item.dart';
import 'package:cizaro_app/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart' as tab;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class Constants {}

class _HomeScreenState extends State<HomeScreen> {
  List<HotDeals> hotDealsList = [];
  List<Collections> collectionsList = [];
  List<NewArrivals> newArrivalsList = [];
  List<Products> newArrivalsProducts = [];
  List<TopSelling> topSellingList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Home home;
  int initPosition = 0;
  bool _isLoading = false;

  Future getHomeData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    await getHome.fetchHomeList().then((response) {
      home = response;
      hotDealsList = home.data.hotDeals;
      collectionsList = home.data.collections;
      newArrivalsList = home.data.newArrivals;
      topSellingList = home.data.topSelling;
    });
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState();
  }

  Widget tabsWidgets(BuildContext context) {
    final fav = Provider.of<FavViewModel>(context, listen: false);
    // ScreenUtil.init(context,
    //     allowFontScaling: false,
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height);

    // return InfoWidget(
    //   builder: (context, deviceInfo) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 2,
          left: SizeConfig.blockSizeHorizontal * 2),
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: newArrivalsList?.length ?? 0,
        tabBuilder: (context, index) => Tab(
          child: Text(
            newArrivalsList[index].name,
            // style: TextStyle(
            //   fontFamily: 'Poppins',
            //   fontWeight: FontWeight.w700,
            // ),
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: SizeConfig.safeBlockHorizontal * 4),
            //  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3
          ),
        ),
        pageBuilder: (context, index) => Container(
          child: ListView.builder(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * .5,
                  top: SizeConfig.blockSizeVertical * 2),
              itemCount:
                  newArrivalsList?.elementAt(index)?.products?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () => tab.pushNewScreenWithRouteSettings(context,
                        settings: RouteSettings(
                            name: ProductDetails.routeName,
                            arguments: {
                              'product_id': newArrivalsList
                                  ?.elementAt(index)
                                  ?.products[index]
                                  .id
                            }),
                        screen: ProductDetails(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            tab.PageTransitionAnimation.fade),
                    child: ProductItem(
                      productId: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.id ??
                          0,
                      productName: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.name ??
                          '',

                      imgUrl: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.mainImg ??
                          '',
                      categoryName: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.category
                              ?.name ??
                          '',
                      productPrice: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.price ??
                          0.0,
                      productPriceAfter: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.offer
                              ?.afterPrice ??
                          0.0,
                      discount: newArrivalsList
                              ?.elementAt(index)
                              ?.products[index]
                              ?.offer
                              ?.discount ??
                          0.0,
                      onAddToCart: () {
                        final cart =
                            Provider.of<CartViewModel>(context, listen: false);
                        final productCart = ProductCart(
                            id: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .id,
                            name: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .name,
                            mainImg: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .mainImg,
                            price: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .price,
                            priceAfterDiscount: newArrivalsList
                                    ?.elementAt(index)
                                    ?.products[index]
                                    .offer
                                    ?.afterPrice ??
                                newArrivalsList
                                    ?.elementAt(index)
                                    ?.products[index]
                                    .price,
                            categoryName: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .category
                                .name,
                            quantity: 1,
                            availability: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .availability,
                            colorSpecValue: '',
                            sizeSpecValue: '');
                        cart.addProductToCart(productCart);
                      },
                      onAddToFavorite: () {
                        final productFav = ProductFav(
                            id: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .id,
                            name: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .name,
                            mainImg: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .mainImg,
                            price: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .price,
                            categoryName: newArrivalsList
                                ?.elementAt(index)
                                ?.products[index]
                                .category
                                .name,
                            isFav: 1);
                        fav.addProductToFav(productFav);
                      },
                      // fav.favProductModel.length == 0 ||
                      //         fav.favProductModel == null
                      //     ? 0
                      //     : fav.favProductModel[index]?.isFav ?? 0,
                    ),
                  )),
        ),
        onPositionChange: (index) {
          initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  Widget topSellingWidgets(BuildContext context) {
    final fav = Provider.of<FavViewModel>(context, listen: false);
    // ScreenUtil.init(context,
    //     allowFontScaling: false,
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height);
    // return InfoWidget(
    //   builder: (context, deviceInfo) {
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 2,
          left: SizeConfig.blockSizeHorizontal * 2),
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: topSellingList?.length ?? 0,
        tabBuilder: (context, index) => Tab(
          child: Text(
            topSellingList[index].name,
            // style: TextStyle(
            //   fontFamily: 'Poppins',
            //   fontWeight: FontWeight.w700,
            // ),
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.safeBlockHorizontal * 3,
            ),
            // textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.3
          ),
        ),
        pageBuilder: (context, index) => Container(
          child: ListView.builder(
              padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * .5,
                top: SizeConfig.blockSizeVertical * 1,
              ),
              itemCount: topSellingList[index]?.products?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () => tab.pushNewScreenWithRouteSettings(context,
                        settings: RouteSettings(
                            name: ProductDetails.routeName,
                            arguments: {
                              'product_id': topSellingList[0].products[index].id
                            }),
                        screen: ProductDetails(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            tab.PageTransitionAnimation.fade),
                    child: ProductItem(
                      productId: topSellingList[0]?.products[index]?.id ?? 0,
                      productName:
                          topSellingList[0]?.products[index]?.name ?? '',
                      imgUrl: topSellingList[0]?.products[index]?.mainImg ?? '',
                      productPrice:
                          topSellingList[0]?.products[index]?.price ?? 0.0,
                      productPriceAfter: topSellingList[0]
                              ?.products[index]
                              ?.offer
                              ?.afterPrice ??
                          0.0,
                      discount:
                          topSellingList[0]?.products[index]?.offer?.discount ??
                              0.0,
                      onAddToCart: () {
                        final cart =
                            Provider.of<CartViewModel>(context, listen: false);
                        final productCart = ProductCart(
                            id: topSellingList[0]?.products[index].id,
                            name: topSellingList[0]?.products[index].name,
                            mainImg: topSellingList[0]?.products[index].mainImg,
                            price: topSellingList[0]?.products[index].price,
                            priceAfterDiscount: topSellingList[0]
                                    ?.products[index]
                                    .offer
                                    ?.afterPrice ??
                                topSellingList[0]?.products[index].price,
                            categoryName: topSellingList[0]
                                ?.products[index]
                                .category
                                .name,
                            quantity: 1,
                            availability:
                                topSellingList[0]?.products[index].availability,
                            colorSpecValue: '',
                            sizeSpecValue: '');
                        cart.addProductToCart(productCart);
                      },
                      onAddToFavorite: () {
                        final productFav = ProductFav(
                            id: topSellingList[0]?.products[index].id,
                            name: topSellingList[0]?.products[index].name,
                            mainImg: topSellingList[0]?.products[index].mainImg,
                            price: topSellingList[0]?.products[index].price,
                            categoryName: topSellingList[0]
                                ?.products[index]
                                .category
                                .name,
                            isFav: 1);
                        fav.addProductToFav(productFav);
                      },
                      //   isFav: fav.favProductModel[index].isFav,
                    ),
                  )),
        ),
        onPositionChange: (index) {
          initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // var mediaQueryData = MediaQuery.of(context);
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
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
              child: Container(
                // height: MediaQuery.of(context).size.height,
                // width: double.infinity,
                // height: SizeConfig.blockSizeVertical * 100,
                // width: SizeConfig.blockSizeHorizontal * 100,
                // child: InfoWidget(
                //   builder: (context, deviceInfo) {
                //     return
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hotDealsList.length == 0 || hotDealsList.length == null
                        ? Container()
                        : Container(
                            width: SizeConfig.blockSizeHorizontal * 100,
                            height: SizeConfig.blockSizeVertical * 38,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                    ),
                                    child: Text(
                                      "Hot Deals",
                                      // textScaleFactor: MediaQuery.of(context)
                                      //         .textScaleFactor *
                                      //     1.6,
                                      // style: TextStyle(
                                      //     //   fontWeight: FontWeight.bold,
                                      //     fontSize: 20,
                                      //     fontFamily: 'Poppins',
                                      //     fontWeight: FontWeight.w700,
                                      //     color: Color(0xff294794)
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 5,
                                        color: Color(0xff294794),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * .1,
                                  ),
                                  height: SizeConfig.blockSizeVertical * 28,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  child: CarouselSlider.builder(
                                    itemCount: hotDealsList.length,
                                    itemBuilder: (ctx, index) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context)
                                            .pushNamed(
                                                ProductDetails.routeName),
                                        child: HotDealsItem(
                                            id: hotDealsList[index].id,
                                            itemText: hotDealsList[index].name,
                                            imgUrl: hotDealsList[index]
                                                .offer
                                                .image),
                                      );
                                    },
                                    options: CarouselOptions(
                                      aspectRatio: 16 / 9,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: true,
                                      reverse: false,
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    collectionsList.length == 0 ||
                            collectionsList.length == null
                        ? Container()
                        : Column(
                            children: [
                              Container(
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      "Collections",
                                      // textScaleFactor:
                                      //     MediaQuery.textScaleFactorOf(
                                      //             context) *
                                      //         1.5,
                                      // style: TextStyle(
                                      //     fontSize: 18,
                                      //     fontFamily: 'Poppins',
                                      //     fontWeight: FontWeight.w700,
                                      //     color: Color(0xff294794)
                                      // ),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  5,
                                          color: Color(0xff294794)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * .2,
                                  left: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                height: SizeConfig.blockSizeVertical * 22,
                                //    width: deviceInfo.localWidth * .2,
                                child: ListView.builder(
                                    itemCount: collectionsList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) =>
                                        GestureDetector(
                                          onTap: () => tab
                                              .pushNewScreenWithRouteSettings(
                                                  context,
                                                  settings: RouteSettings(
                                                      name:
                                                          ShopScreen.routeName,
                                                      arguments: {
                                                        'collection_id':
                                                            collectionsList[
                                                                    index]
                                                                .id
                                                      }),
                                                  screen: ShopScreen(),
                                                  withNavBar: true,
                                                  pageTransitionAnimation: tab
                                                      .PageTransitionAnimation
                                                      .fade),
                                          child: CollectionItem(
                                            id: collectionsList[index].id,
                                            itemText:
                                                collectionsList[index].name,
                                            imgUrl: collectionsList[index]
                                                .imageBanner,
                                            // width: SizeConfig
                                            //         .blockSizeHorizontal *
                                            //     100,
                                            // height: SizeConfig
                                            //         .blockSizeVertical *
                                            //     100,
                                          ),
                                        )),
                              ),
                            ],
                          ),
                    newArrivalsList.length == 0 ||
                            newArrivalsList.length == null
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 1),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * .1),
                                    child: Text(
                                      " New Arrivals",
                                      // textScaleFactor: MediaQuery.of(context)
                                      //         .textScaleFactor *
                                      //     1.3,
                                      // style: TextStyle(
                                      //     fontFamily: 'Poppins',
                                      //     fontWeight: FontWeight.w700,
                                      //     color: Color(0xff294794)),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              SizeConfig.safeBlockHorizontal *
                                                  5,
                                          color: Color(0xff294794)),
                                    ),
                                  ),
                                ),
                                Container(
                                    height: SizeConfig.blockSizeVertical * 45,
                                    child: tabsWidgets(context)),
                              ],
                            ),
                          ),
                    topSellingList.length == 0 || topSellingList.length == null
                        ? Container()
                        : Container(
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: Container(
                                      child: Text(
                                        "Top Selling ",
                                        // textScaleFactor: MediaQuery.of(context)
                                        //         .textScaleFactor *
                                        //     1.3,
                                        // style: TextStyle(
                                        //     fontFamily: 'Poppins',
                                        //     fontWeight: FontWeight.w700,
                                        //     color: Color(0xff294794)),
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5,
                                            color: Color(0xff294794)),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1),
                                    height: SizeConfig.blockSizeVertical * 45,
                                    child: topSellingWidgets(context)),
                              ],
                            ),
                          ),
                  ],
                ),
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

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Color(0xff3A559F)),
      child: Container(
        height: MediaQuery.of(context).size.height * .2,
        width: double.infinity,
        child: Expanded(
            child: CustomTabBarButton(
          text: "CHATS",
          textColor: Colors.white,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
        )),
      ),
    );
  }
}

class CustomTabBarButton extends StatelessWidget {
  final String text;
  final Color borderColor, textColor;
  final double borderWidth;

  const CustomTabBarButton(
      {Key key, this.text, this.borderColor, this.textColor, this.borderWidth})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: borderColor, width: borderWidth)),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: textColor),
      ),
    );
  }
}
