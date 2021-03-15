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
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart' as tab;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int initPosition2 = 0;
  bool _isLoading = false;
  bool languageValue = false;

  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  Future getHomeData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    bool languageValue = await getLang();
    await getHome
        .fetchHomeList(languageValue == false ? 'en' : 'ar')
        .then((response) {
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
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 2,
          left: SizeConfig.blockSizeHorizontal * 2),
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: newArrivalsList?.length ?? 0,
        tabBuilder: (context, index) => Tab(
          child: Text(newArrivalsList[index].name,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: SizeConfig.safeBlockHorizontal * 4)),
        ),
        pageBuilder: (context, index) => Container(
          child: ListView.builder(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * .5,
                  top: SizeConfig.blockSizeVertical * 2),
              itemCount:
                  newArrivalsList[initPosition > 0 ? 1 : 0].products.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () => tab.pushNewScreenWithRouteSettings(context,
                        settings: RouteSettings(
                            name: ProductDetails.routeName,
                            arguments: {
                              'product_id':
                                  newArrivalsList[initPosition > 0 ? 1 : 0]
                                      ?.products[index]
                                      .id
                            }),
                        screen: ProductDetails(),
                        // withNavBar: true,
                        pageTransitionAnimation:
                            tab.PageTransitionAnimation.fade),
                    child: ProductItem(
                      key: ObjectKey(newArrivalsList[initPosition > 0 ? 1 : 0]),
                      productId: newArrivalsList[initPosition > 0 ? 1 : 0]
                              ?.products[index]
                              ?.id ??
                          0,
                      productName: newArrivalsList[initPosition > 0 ? 1 : 0]
                              ?.products[index]
                              ?.name ??
                          '',
                      imgUrl: newArrivalsList[initPosition > 0 ? 1 : 0]
                              ?.products[index]
                              ?.mainImg ??
                          '',
                      categoryName: newArrivalsList[initPosition > 0 ? 1 : 0]
                              ?.products[index]
                              ?.category
                              ?.name ??
                          '',
                      productPrice: newArrivalsList[initPosition > 0 ? 1 : 0]
                              ?.products[index]
                              ?.price ??
                          0.0,
                      productPriceAfter:
                          newArrivalsList[initPosition > 0 ? 1 : 0]
                                  ?.products[index]
                                  ?.offer
                                  ?.afterPrice ??
                              0.0,
                      discount: newArrivalsList[initPosition > 0 ? 1 : 0]
                              ?.products[index]
                              ?.offer
                              ?.discount ??
                          0.0,
                      onAddToCart: () {
                        final cart =
                            Provider.of<CartViewModel>(context, listen: false);
                        final productCart = ProductCart(
                            id: newArrivalsList[initPosition > 0 ? 1 : 0]
                                ?.products[index]
                                .id,
                            name: newArrivalsList[initPosition > 0 ? 1 : 0]
                                ?.products[index]
                                .name,
                            mainImg: newArrivalsList[initPosition > 0 ? 1 : 0]
                                ?.products[index]
                                .mainImg,
                            price: newArrivalsList[initPosition > 0 ? 1 : 0]
                                ?.products[index]
                                .price,
                            priceAfterDiscount:
                                newArrivalsList[initPosition > 0 ? 1 : 0]
                                        ?.products[index]
                                        .offer
                                        ?.afterPrice ??
                                    newArrivalsList[initPosition > 0 ? 1 : 0]
                                        ?.products[index]
                                        .price,
                            categoryName:
                                newArrivalsList[initPosition > 0 ? 1 : 0]
                                    ?.products[index]
                                    .category
                                    .name,
                            quantity: 1,
                            inCart: 1,
                            availability:
                                newArrivalsList[initPosition > 0 ? 1 : 0]
                                    ?.products[index]
                                    .availability,
                            colorSpecValue: '',
                            sizeSpecValue: '');
                        cart.addProductToCart(productCart);
                      },
                      // onAddToFavorite: () {
                      //   final productFav = ProductFav(
                      //       id: newArrivalsList[initPosition > 0 ? 1 : 0]
                      //           ?.products[index]
                      //           .id,
                      //       name: newArrivalsList[initPosition > 0 ? 1 : 0]
                      //           ?.products[index]
                      //           .name,
                      //       mainImg: newArrivalsList[initPosition > 0 ? 1 : 0]
                      //           ?.products[index]
                      //           .mainImg,
                      //       price: newArrivalsList[initPosition > 0 ? 1 : 0]
                      //           ?.products[index]
                      //           .price,
                      //       categoryName:
                      //           newArrivalsList[initPosition > 0 ? 1 : 0]
                      //               ?.products[index]
                      //               .category
                      //               .name,
                      //       isFav: 1);
                      //   fav.addProductToFav(productFav);
                      // },
                    ),
                  )),
        ),
        onPositionChange: (index) {
          setState(() {
            initPosition = index;
          });
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  Widget topSellingWidgets(BuildContext context) {
    final fav = Provider.of<FavViewModel>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(
          right: SizeConfig.blockSizeHorizontal * 2,
          left: SizeConfig.blockSizeHorizontal * 2),
      child: CustomTabView(
        initPosition: initPosition2,
        itemCount: topSellingList?.length ?? 0,
        tabBuilder: (context, index) => Tab(
          child: Text(
            topSellingList[index].name,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: SizeConfig.safeBlockHorizontal * 4,
            ),
          ),
        ),
        pageBuilder: (context, index) => Container(
          child: ListView.builder(
              padding: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * .5,
                top: SizeConfig.blockSizeVertical * 1,
              ),
              itemCount:
                  topSellingList[initPosition2 > 0 ? 1 : 0]?.products?.length ??
                      0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () => tab.pushNewScreenWithRouteSettings(context,
                        settings: RouteSettings(
                            name: ProductDetails.routeName,
                            arguments: {
                              'product_id':
                                  topSellingList[initPosition2 > 0 ? 1 : 0]
                                      .products[index]
                                      .id
                            }),
                        screen: ProductDetails(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            tab.PageTransitionAnimation.fade),
                    child: ProductItem(
                      productId: topSellingList[initPosition2 > 0 ? 1 : 0]
                              ?.products[index]
                              ?.id ??
                          0,
                      productName: topSellingList[initPosition2 > 0 ? 1 : 0]
                              ?.products[index]
                              ?.name ??
                          '',
                      imgUrl: topSellingList[initPosition2 > 0 ? 1 : 0]
                              ?.products[index]
                              ?.mainImg ??
                          '',
                      productPrice: topSellingList[initPosition2 > 0 ? 1 : 0]
                              ?.products[index]
                              ?.price ??
                          0.0,
                      productPriceAfter:
                          topSellingList[initPosition2 > 0 ? 1 : 0]
                                  ?.products[index]
                                  ?.offer
                                  ?.afterPrice ??
                              0.0,
                      discount: topSellingList[initPosition2 > 0 ? 1 : 0]
                              ?.products[index]
                              ?.offer
                              ?.discount ??
                          0.0,
                      onAddToCart: () {
                        final cart =
                            Provider.of<CartViewModel>(context, listen: false);
                        final productCart = ProductCart(
                            id: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .id,
                            name: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .name,
                            mainImg: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .mainImg,
                            price: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .price,
                            priceAfterDiscount:
                                topSellingList[initPosition2 > 0 ? 1 : 0]
                                        ?.products[index]
                                        .offer
                                        ?.afterPrice ??
                                    topSellingList[initPosition2 > 0 ? 1 : 0]
                                        ?.products[index]
                                        .price,
                            categoryName:
                                topSellingList[initPosition2 > 0 ? 1 : 0]
                                    ?.products[index]
                                    .category
                                    .name,
                            quantity: 1,
                            availability:
                                topSellingList[initPosition2 > 0 ? 1 : 0]
                                    ?.products[index]
                                    .availability,
                            inCart: 1,
                            colorSpecValue: '',
                            sizeSpecValue: '');
                        cart.addProductToCart(productCart);
                      },
                      onAddToFavorite: () {
                        final productFav = ProductFav(
                            id: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .id,
                            name: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .name,
                            mainImg: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .mainImg,
                            price: topSellingList[initPosition2 > 0 ? 1 : 0]
                                ?.products[index]
                                .price,
                            categoryName:
                                topSellingList[initPosition2 > 0 ? 1 : 0]
                                    ?.products[index]
                                    .category
                                    .name,
                            isFav: 1);
                        fav.addProductToFav(productFav);
                      },
                    ),
                  )),
        ),
        onPositionChange: (index) {
          setState(() {
            initPosition2 = index;
          });
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("", _scaffoldKey, false),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
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
                                      top: SizeConfig.blockSizeVertical * 1.5,
                                    ),
                                    child: Text(
                                      'hot_deals_title'.tr(),
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
                                    top: SizeConfig.blockSizeVertical * 2,
                                  ),
                                  height: SizeConfig.blockSizeVertical * 28,
                                  width: SizeConfig.blockSizeHorizontal * 100,
                                  child: CarouselSlider.builder(
                                    itemCount: hotDealsList.length,
                                    itemBuilder: (ctx, index) {
                                      return GestureDetector(
                                        onTap: () =>
                                            tab.pushNewScreenWithRouteSettings(
                                                context,
                                                settings: RouteSettings(
                                                    name: ShopScreen.routeName,
                                                    arguments: {
                                                      'category_id':
                                                          hotDealsList[index].id
                                                    }),
                                                screen: ShopScreen(),
                                                withNavBar: true,
                                                pageTransitionAnimation: tab
                                                    .PageTransitionAnimation
                                                    .fade),
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
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1),
                                    child: Text(
                                      'collection_title'.tr(),
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
                                  right: SizeConfig.blockSizeHorizontal * 2,
                                ),
                                height: SizeConfig.blockSizeVertical * 23,
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
                                                  .imageBanner),
                                        )),
                              ),
                            ],
                          ),
                    newArrivalsList.length == 0 ||
                            newArrivalsList.length == null
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 3,
                              left: SizeConfig.blockSizeHorizontal * 1,
                              right: SizeConfig.blockSizeHorizontal * 1,
                            ),
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * .1),
                                    child: Text(
                                      'new_arrival_title'.tr(),
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
                                    height: SizeConfig.blockSizeVertical * 43,
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
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 3),
                                  child: Center(
                                    child: Text(
                                      'top_selling_title'.tr(),
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
                                    padding: EdgeInsets.only(
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1),
                                    height: SizeConfig.blockSizeVertical * 43,
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
