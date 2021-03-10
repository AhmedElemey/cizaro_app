import 'dart:io';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cizaro_app/model/brandModel.dart' as brandData;
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/model/searchModel.dart';
import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/search_item.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = '/search-screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var valueBrand;
  final GlobalKey<ScaffoldState> _scaffoldKey13 = GlobalKey<ScaffoldState>();
  TextEditingController valueMinPrice = TextEditingController();
  TextEditingController valueMaxPrice = TextEditingController();

  FToast fToast;

  bool wannaFilter = false;

  ShopModel filter;
  List filterList = [];

  brandData.BrandModel brand;
  List<brandData.Data> brandList = [];

  Home home;
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
    fToast = FToast();
    fToast.init(context);
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    //  print("BACK BUTTON!"); // Do some stuff.
    pushNewScreenWithRouteSettings(context,
        settings: RouteSettings(name: SearchScreen.routeName),
        screen: SearchScreen(),
        withNavBar: true,
        pageTransitionAnimation: PageTransitionAnimation.fade);
    return true;
  }

  Future getFilterData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });
    final getFilter = Provider.of<ListViewModel>(context, listen: false);

    await getFilter
        .fetchFilter(valueMinPrice.text ?? "", valueMaxPrice.text ?? "",
            valueBrand ?? "")
        .then((response) {
      filter = response;
      filterList = filter.data.products;
      //getBrandData();
    });
    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  displayBottomSheet(BuildContext context) {
    // getBrandData();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return _isLoading
                ? Center(
                    child: Platform.isIOS
                        ? CupertinoActivityIndicator()
                        : CircularProgressIndicator())
                : Container(
                    height: MediaQuery.of(context).size.height * .8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                            "Filter By :",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 2,
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
                          child: Row(
                            children: [
                              Text(
                                "Filter By Brand :",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.3,
                                style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3.5,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: FutureBuilder(
                                    future: Provider.of<ListViewModel>(context,
                                            listen: false)
                                        .fetchBrandList(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<brandData.Data>>
                                            snapshot) {
                                      if (snapshot.hasError)
                                        return Text(snapshot.error.toString());
                                      else
                                        return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .1,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .5,
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20),
                                            child: DropdownButton(
                                              hint: Text("Select Brand "),
                                              value: valueBrand,
                                              // dropdownColor: Colors.grey.shade400,
                                              items: snapshot.data
                                                      ?.map((brandData.Data e) {
                                                    return DropdownMenuItem(
                                                      child: Text(e.name),
                                                      value: e.id,
                                                    );
                                                  })?.toList() ??
                                                  null,
                                              onChanged: (value) {
                                                setState(() {
                                                  valueBrand = value;
                                                });
                                              },
                                              isExpanded: true,
                                            ));
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 50, bottom: 5),
                          child: Divider(
                              height:
                                  MediaQuery.of(context).size.height * .0001,
                              color: Color(0xff727C8E)),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.07,
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Row(
                            children: [
                              Text(
                                "Minimum Price : ",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.2,
                                style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3.5,
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                padding: EdgeInsets.only(left: 30),
                                child: TextFieldBuild(
                                    obscureText: false,
                                    readOnly: false,
                                    textInputType: TextInputType.number,
                                    lineCount: 1,
                                    textEditingController: valueMinPrice),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 50, bottom: 5),
                          child: Divider(
                              height:
                                  MediaQuery.of(context).size.height * .0001,
                              color: Color(0xff727C8E)),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, left: 20),
                          child: Row(
                            children: [
                              Text(
                                "Maximum Price :",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.2,
                                style: TextStyle(
                                  fontSize:
                                      SizeConfig.safeBlockHorizontal * 3.5,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 30),
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                child: TextFieldBuild(
                                    obscureText: false,
                                    readOnly: false,
                                    lineCount: 1,
                                    textInputType: TextInputType.number,
                                    textEditingController: valueMaxPrice),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30, left: 150),
                          child: GestureDetector(
                            onTap: () => {
                              getFilterData(),
                              Navigator.pop(context),
                              wannaFilter = true
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * .25,
                              height: MediaQuery.of(context).size.height * .06,
                              decoration: BoxDecoration(
                                  color: Color(0xff3A559F),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Center(
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
                        ),
                      ],
                    ),
                  );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        wannaFilter = false;
        await pushNewScreenWithRouteSettings(context,
            settings: RouteSettings(name: SearchScreen.routeName),
            screen: SearchScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.fade);
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey13,
        drawer: DrawerLayout(),
        appBar: PreferredSize(
          child: GradientAppBar("", _scaffoldKey13, false),
          preferredSize: const Size(double.infinity, kToolbarHeight),
        ),
        body: _isLoading
            ? Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator())
            : SingleChildScrollView(
                physics: ScrollPhysics(),
                child: filterList.length == 0 && wannaFilter == true
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 20,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            "There is no Available Items Matches Your Filter ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                                // color: Color(0xff3A559F),
                                color: Color(0xff515C6F)),
                          ),
                        ),
                      )
                    : filterList.length == 0 && wannaFilter == false
                        ? Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 5,
                                    right: SizeConfig.blockSizeHorizontal * 5),
                                height: SizeConfig.blockSizeVertical * 6,
                                width: SizeConfig.blockSizeHorizontal * 99,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            productList?.length.toString() ??
                                                '',
                                            style: TextStyle(
                                                color: Color(0xff3A559F),
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    4),
                                            textScaleFactor:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    1.5,
                                          ),
                                          Text(
                                            " Items",
                                            textScaleFactor:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    1.5,
                                            style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    4),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                productList = productList
                                                    .reversed
                                                    .toList();
                                              });
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/arrow.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.5,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      2.5,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    .03),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  displayBottomSheet(context),
                                              child: Icon(
                                                Icons.filter_alt_outlined,
                                                size: SizeConfig
                                                        .blockSizeVertical *
                                                    3,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: productList?.length ?? 0,
                                itemBuilder: (ctx, index) => GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: ProductDetails.routeName,
                                          arguments: {
                                            'product_id': productList[index].id
                                          }),
                                      screen: ProductDetails(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: SearchItem(
                                    productId: productList[index].id,
                                    imgUrl: productList[index].mainImg,
                                    productName: productList[index].name,
                                    productPrice:
                                        productList[index].price ?? 0.0,
                                    productPriceAfter:
                                        productList[index]?.offer?.afterPrice ??
                                            0.0,
                                    productCategory:
                                        productList[index].category.name,
                                    onAddToFavorite: () {
                                      final fav = Provider.of<FavViewModel>(
                                          context,
                                          listen: false);
                                      final productFav = ProductFav(
                                          id: productList[index].id,
                                          name: productList[index].name,
                                          mainImg: productList[index].mainImg,
                                          price: productList[index].price,
                                          categoryName:
                                              productList[index].category.name,
                                          isFav: 1);
                                      fav.addProductToFav(productFav);
                                    },
                                    onAddToCart: () {
                                      final cart = Provider.of<CartViewModel>(
                                          context,
                                          listen: false);
                                      final productCart = ProductCart(
                                          id: productList[index].id,
                                          name: productList[index].name,
                                          mainImg: productList[index].mainImg,
                                          price: productList[index].price,
                                          priceAfterDiscount: productList[index]
                                                  .offer
                                                  ?.afterPrice ??
                                              productList[index].price,
                                          categoryName:
                                              productList[index].category.name,
                                          quantity: 1,
                                          availability:
                                              productList[index].availability,
                                          inCart: 1,
                                          colorSpecValue: '',
                                          sizeSpecValue: '');
                                      cart.addProductToCart(productCart);
                                    },
                                    //  productQuantity: ,
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 5)
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 6,
                                    right: SizeConfig.blockSizeHorizontal * 4),
                                height: SizeConfig.blockSizeVertical * 6,
                                //   width: MediaQuery.of(context).size.width * .9,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            filterList?.length.toString() ?? '',
                                            style: TextStyle(
                                                color: Color(0xff3A559F)),
                                            textScaleFactor:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    1.5,
                                          ),
                                          Text(
                                            " Items",
                                            textScaleFactor:
                                                MediaQuery.textScaleFactorOf(
                                                        context) *
                                                    1.5,
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  3,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                filterList = filterList.reversed
                                                    .toList();
                                              });
                                            },
                                            child: SvgPicture.asset(
                                              'assets/images/arrow.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 1),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  displayBottomSheet(context),
                                              child: Icon(
                                                Icons.filter_alt_outlined,
                                                size: SizeConfig
                                                        .blockSizeHorizontal *
                                                    7,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: filterList?.length ?? 0,
                                itemBuilder: (ctx, index) => GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: ProductDetails.routeName,
                                          arguments: {
                                            'product_id': filterList[index].id
                                          }),
                                      screen: ProductDetails(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: SearchItem(
                                    imgUrl: filterList[index].mainImg,
                                    productName: filterList[index].name,
                                    productPrice:
                                        filterList[index].price ?? 0.0,
                                    productPriceAfter:
                                        productList[index]?.offer?.afterPrice ??
                                            0.0,
                                    productCategory:
                                        filterList[index].category.name,
                                    onAddToFavorite: () {
                                      final fav = Provider.of<FavViewModel>(
                                          context,
                                          listen: false);
                                      final productFav = ProductFav(
                                          id: filterList[index].id,
                                          name: filterList[index].name,
                                          mainImg: filterList[index].mainImg,
                                          price: filterList[index].price,
                                          categoryName:
                                              filterList[index].category.name,
                                          isFav: 1);
                                      fav.addProductToFav(productFav);
                                    },
                                    onAddToCart: () {
                                      final cart = Provider.of<CartViewModel>(
                                          context,
                                          listen: false);
                                      final productCart = ProductCart(
                                          id: filterList[index].id,
                                          name: filterList[index].name,
                                          mainImg: filterList[index].mainImg,
                                          price: filterList[index].price,
                                          priceAfterDiscount: filterList[index]
                                                  .offer
                                                  ?.afterPrice ??
                                              filterList[index].price,
                                          categoryName:
                                              filterList[index].category.name,
                                          quantity: 1,
                                          availability:
                                              filterList[index].availability,
                                          inCart: 1,
                                          colorSpecValue: '',
                                          sizeSpecValue: '');
                                      cart.addProductToCart(productCart);
                                    },
                                    //  productQuantity: ,
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.blockSizeVertical * 2)
                            ],
                          ),
              ),
      ),
    );
  }
}
