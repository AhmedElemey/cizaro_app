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
import 'package:fluttertoast/fluttertoast.dart';
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
  FToast fToast;
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
    languageValue = await getLang();
    await getHome
        .fetchHomeList(languageValue == null
            ? 'en'
            : languageValue == false
                ? 'en'
                : 'ar')
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
    fToast = FToast();
    fToast.init(context);
  }

  showCartToast(BuildContext context) {
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
          Text("added_cart".tr(), style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
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
        pageBuilder: (context, i) =>
            newArrivalProductsView(newArrivalsList[i].products),
        onPositionChange: (index) {
          if (this.mounted)
            setState(() {
              initPosition = index;
            });
        },
      ),
    );
  }

  Widget topSellingWidgets(BuildContext context) {
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
                fontSize: SizeConfig.safeBlockHorizontal * 4),
          ),
        ),
        pageBuilder: (context, index) =>
            topSellingProductsView(topSellingList[index].products),
        onPositionChange: (index) {
          if (this.mounted)
            setState(() {
              initPosition2 = index;
            });
        },
      ),
    );
  }

  Widget newArrivalProductsView(List<Products> products) {
    return ListView.builder(
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * .5,
            top: SizeConfig.blockSizeVertical * 2),
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) => GestureDetector(
              onTap: () => tab.pushNewScreenWithRouteSettings(context,
                  settings: RouteSettings(
                      name: ProductDetails.routeName,
                      arguments: {'product_id': products[index]?.id}),
                  screen: ProductDetails(),
                  // withNavBar: true,
                  pageTransitionAnimation: tab.PageTransitionAnimation.fade),
              child: ProductItem(
                key: ObjectKey(products[index]),
                item: products[index],
                onAddToCart: () {
                  if (products[index].specs == false) {
                    final cart =
                        Provider.of<CartViewModel>(context, listen: false);
                    final productCart = ProductCart(
                        id: products[index].id,
                        name: products[index].name,
                        mainImg: products[index].mainImg,
                        price: products[index].price,
                        priceAfterDiscount: products[index].offer?.afterPrice ??
                            products[index].price,
                        categoryName: products[index].category.name,
                        quantity: 1,
                        availability: products[index].availability,
                        inCart: 1,
                        colorSpecValue: '',
                        sizeSpecValue: '');
                    showCartToast(_scaffoldKey.currentContext);
                    cart.addProductToCart(productCart);
                  } else {
                    tab.pushNewScreenWithRouteSettings(context,
                        settings: RouteSettings(
                            name: ProductDetails.routeName,
                            arguments: {'product_id': products[index].id}),
                        screen: ProductDetails(),
                        withNavBar: true,
                        pageTransitionAnimation:
                            tab.PageTransitionAnimation.fade);
                  }
                  final cart =
                      Provider.of<CartViewModel>(context, listen: false);
                  final productCart = ProductCart(
                      id: products[index].id,
                      name: products[index].name,
                      mainImg: products[index].mainImg,
                      price: products[index].price,
                      priceAfterDiscount: products[index].offer?.afterPrice ??
                          products[index].price,
                      categoryName: products[index].category.name,
                      quantity: 1,
                      inCart: 1,
                      availability: products[index].availability,
                      colorSpecValue: '',
                      sizeSpecValue: '');
                  cart.addProductToCart(productCart);
                },
              ),
            ));
  }

  Widget topSellingProductsView(List<Products> products) {
    final fav = Provider.of<FavViewModel>(context, listen: false);
    return Container(
      child: ListView.builder(
          padding: EdgeInsets.only(
            right: SizeConfig.blockSizeHorizontal * .5,
            top: SizeConfig.blockSizeVertical * 1,
          ),
          itemCount: products?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) => GestureDetector(
                onTap: () => tab.pushNewScreenWithRouteSettings(context,
                    settings: RouteSettings(
                        name: ProductDetails.routeName,
                        arguments: {'product_id': products[index].id}),
                    screen: ProductDetails(),
                    withNavBar: true,
                    pageTransitionAnimation: tab.PageTransitionAnimation.fade),
                child: ProductItem(
                  item: products[index],
                  onAddToCart: () {
                    if (products[index].specs == false) {
                      final cart =
                          Provider.of<CartViewModel>(context, listen: false);
                      final productCart = ProductCart(
                          id: products[index].id,
                          name: products[index].name,
                          mainImg: products[index].mainImg,
                          price: products[index].price,
                          priceAfterDiscount:
                              products[index].offer?.afterPrice ??
                                  products[index].price,
                          categoryName: products[index].category.name,
                          quantity: 1,
                          availability: products[index].availability,
                          inCart: 1,
                          colorSpecValue: '',
                          sizeSpecValue: '');
                      showCartToast(_scaffoldKey.currentContext);
                      cart.addProductToCart(productCart);
                    } else {
                      tab.pushNewScreenWithRouteSettings(context,
                          settings: RouteSettings(
                              name: ProductDetails.routeName,
                              arguments: {'product_id': products[index].id}),
                          screen: ProductDetails(),
                          withNavBar: true,
                          pageTransitionAnimation:
                              tab.PageTransitionAnimation.fade);
                    }
                  },
                  onAddToFavorite: () {
                    final productFav = ProductFav(
                        id: products[index].id,
                        name: products[index].name,
                        mainImg: products[index].mainImg,
                        price: products[index].price,
                        categoryName: products[index].category.name,
                        isFav: 1);
                    fav.addProductToFav(productFav);
                  },
                ),
              )),
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
                            height: SizeConfig.blockSizeVertical * 40,
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
                                          color: Colors.grey.withOpacity(0.08),
                                          spreadRadius: 1,
                                          offset: Offset(0, -10),
                                          blurRadius: 5),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 1.5,
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
