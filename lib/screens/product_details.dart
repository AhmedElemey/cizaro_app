import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/favModel.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/related_spec.dart' as rs;
import 'package:cizaro_app/model/specMdel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/product_details_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom_image_last/pinch_zoom_image_last.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetails extends StatefulWidget {
  static final routeName = '/productDetails-screen';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey10 = GlobalKey<ScaffoldState>();
  bool _isLoading = false,
      _isLoading2 = false,
      _isColor = false,
      _isSelected = false;
  ProductDetailsModel productDetails;
  FToast fToast;
  int _selectedColor = -1,
      _selectedSize = -1,
      productId,
      specId,
      productAvailability;
  String productName,
      imgUrl,
      productDescription,
      specTitle,
      colorSpecValue,
      productCategory,
      sizeSpecValue;
  double productPrice, productStar, productPriceAfter;
  List<RelatedProducts> productRelated = [];
  List<MultiImages> productImages = [];
  List<Values> productSpecs = [];
  List<rs.Data> relatedSpecList = [];
  rs.RelatedSpec relatedSpec;
  bool languageValue = false;
  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  Future getHomeData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getProduct = Provider.of<ListViewModel>(context, listen: false);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    languageValue = await getLang();
    await getProduct
        .fetchProductDetailsList(
            arguments['product_id'],
            languageValue == null
                ? 'en'
                : languageValue == false
                    ? 'en'
                    : 'ar')
        .then((response) {
      productDetails = response;
      productId = productDetails.data.id;
      productAvailability = productDetails.data.availability;
      productName = productDetails.data.name;
      imgUrl = productDetails.data.mainImg;
      productPrice = productDetails.data.price;
      productPriceAfter = productDetails.data.offer?.afterPrice ?? 0;
      productCategory = productDetails.data.category.name ?? "";

      productStar = productDetails.data.stars ?? 0.0;
      productDescription = productDetails.data.shortDescription;
      _isColor = productDetails.data.specs?.isColor ?? false;
      specTitle = productDetails?.data.specs?.name ?? "";

      _isColor = productDetails?.data.specs?.isColor ?? false;
      specId = productDetails?.data.specs?.id ?? 1;
      specTitle = productDetails?.data.specs?.name ?? "";
      //
      productRelated = productDetails.data.relatedProducts;
//
      productImages = productDetails?.data.multiImages;
      productImages.insert(0, MultiImages(image: imgUrl));
      //
      productSpecs = productDetails?.data.specs?.values ?? [];
      print(productRelated.length);
      // print(productList.data.relatedProducts.length);
    });
    if (this.mounted) setState(() => _isLoading = false);
  }

  Future getSpecData() async {
    if (this.mounted) setState(() => _isLoading2 = true);
    final selectedSpec = Spec(specValueId: specId);
    final getSpec = Provider.of<ListViewModel>(context, listen: false);
    await getSpec.fetchSpecValues(selectedSpec).then((value) {
      relatedSpec = value;
      relatedSpecList = relatedSpec.data;
    });
    if (this.mounted) setState(() => _isLoading2 = false);
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState();
    fToast = FToast();
    fToast.init(context); // de 3ashan awel lama aload el screen t7mel el data
  }

  showToast() {
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
          Text("Added to Cart", style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showErrorToast() {
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
          Text("Please, Select Specification of Project First!",
              style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        gravity: ToastGravity.BOTTOM);
  }

  showFavToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xffFF6969),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Added to Favorite", style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context, listen: false);
    final fav = Provider.of<FavViewModel>(context, listen: false);
    return Scaffold(
      key: _scaffoldKey10,
      appBar: PreferredSize(
        child: GradientAppBar("", _scaffoldKey10, true),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      drawer: DrawerLayout(),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productImages?.length == 0
                      ? Container(
                          height: SizeConfig.blockSizeVertical * .4,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Image.network(imgUrl ?? ''),
                        )
                      : Container(
                          height: SizeConfig.blockSizeVertical * 50,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    child: PhotoView(
                                        backgroundDecoration: BoxDecoration(
                                            color: Color(0xffFAFAFA)),
                                        loadingBuilder: (ctx, event) => Platform
                                                .isAndroid
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : Center(
                                                child:
                                                    CupertinoActivityIndicator()),
                                        imageProvider: NetworkImage(
                                            productImages[index]?.image ??
                                                imgUrl)));
                                //   PinchZoomImage(
                                //   image: Center(
                                //     child: CachedNetworkImage(
                                //         imageUrl: productImages[index]?.image ??
                                //             imgUrl,
                                //         fit: BoxFit.fitWidth,
                                //         progressIndicatorBuilder: (context, url,
                                //                 downloadProgress) =>
                                //             Platform.isAndroid
                                //                 ? Center(
                                //                     child:
                                //                         CircularProgressIndicator(
                                //                             value:
                                //                                 downloadProgress
                                //                                     .progress))
                                //                 : Center(
                                //                     child:
                                //                         CupertinoActivityIndicator()),
                                //         errorWidget: (context, url, error) =>
                                //             Icon(Icons.error)),
                                //   ),
                                //   zoomedBackgroundColor: Colors.grey.shade300,
                                //   hideStatusBarWhileZooming: true,
                                //   onZoomStart: () => print('Zoom started'),
                                //   onZoomEnd: () => print('Zoom finished'),
                                // );
                              },
                              itemCount: productImages.length,
                              pagination: SwiperPagination()),
                        ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * 7,
                          right: SizeConfig.blockSizeHorizontal * 7,
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Text(
                        productName ?? "",
                        style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Divider(
                        height: SizeConfig.blockSizeVertical * .1,
                        color: Color(0xff727C8E)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 7,
                        left: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        productPriceAfter == productPrice ||
                                productPriceAfter == 0
                            ? Container(
                                child: Text(
                                  productPrice.toString() + ' le'.tr(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5,
                                  ),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 1,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(productPrice.toString() + ' le'.tr(),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                    SizedBox(
                                        width:
                                            SizeConfig.blockSizeHorizontal * 5),
                                    Text(
                                      productPriceAfter.toString() + ' le'.tr(),
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 5,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        Spacer(),
                        Container(
                          height: SizeConfig.blockSizeVertical * 4,
                          width: SizeConfig.blockSizeHorizontal * 12,
                          decoration: BoxDecoration(
                              color: Color(0xffFF6969),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star,
                                    size: SizeConfig.blockSizeHorizontal * 4,
                                    color: Colors.white),
                                SizedBox(
                                    width: SizeConfig.blockSizeHorizontal * .3),
                                Text(
                                  productStar.toString() ?? 0.0,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Divider(
                        height: SizeConfig.blockSizeVertical * .1,
                        color: Color(0xff727C8E)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 7,
                      right: SizeConfig.blockSizeHorizontal * 7,
                      top: SizeConfig.blockSizeVertical * 2,
                    ),
                    child: Row(
                      children: [
                        Text('description'.tr(),
                            style: TextStyle(
                              color: Color(0xff3A559F),
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 5,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7),
                    child: Text(
                      productDescription ?? "",
                      style: TextStyle(
                        color: Color(0xff707070),
                        fontWeight: FontWeight.w400,
                        fontSize: SizeConfig.safeBlockHorizontal * 4,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Divider(
                        height: SizeConfig.blockSizeVertical * .1,
                        color: Color(0xff727C8E)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      children: [
                        Text(
                          specTitle == ''
                              ? ''
                              : "Select $specTitle".toUpperCase(),
                          style: TextStyle(
                              color: Color(0xff515C6F),
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              fontWeight: FontWeight.bold),
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1,
                        ),
                      ],
                    ),
                  ),
                  _isColor == true
                      ? Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 7,
                              right: SizeConfig.blockSizeHorizontal * 7,
                              top: SizeConfig.blockSizeVertical * 2,
                              bottom: SizeConfig.blockSizeVertical * 1),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productSpecs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1.9,
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return GridTile(
                                  child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedColor = productSpecs[index].id;
                                    _selectedColor = index;
                                    _isSelected = true;
                                  });
                                  getSpecData();
                                },
                                child: CircleAvatar(
                                    radius: .3,
                                    child: _selectedColor == index
                                        ? Center(
                                            child: Icon(Icons.check,
                                                color: Theme.of(context)
                                                    .primaryColor))
                                        : Text(''),
                                    foregroundColor: Color(int.parse('0xff' +
                                        productSpecs[index]
                                            .value
                                            .split('#')
                                            .last)),
                                    backgroundColor: Color(int.parse('0xff' +
                                        productSpecs[index]
                                            .value
                                            .split('#')
                                            .last))),
                              ));
                            },
                          ),
                        )
                      : Container(
                          padding: EdgeInsets.only(
                            left: SizeConfig.blockSizeHorizontal * 7,
                            right: SizeConfig.blockSizeHorizontal * 7,
                            top: SizeConfig.blockSizeVertical * 2,
                          ),
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productSpecs.length,
                            padding: EdgeInsets.only(
                                right: SizeConfig.blockSizeHorizontal * 5,
                                left: SizeConfig.blockSizeHorizontal * 5,
                                top: SizeConfig.blockSizeVertical * .5),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2.1,
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSize = productSpecs[index].id;
                                    _selectedSize = index;
                                    _isSelected = true;
                                    sizeSpecValue = productSpecs[index].value;
                                    print(sizeSpecValue);
                                  });
                                  getSpecData();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left:
                                          SizeConfig.blockSizeHorizontal * .05),
                                  child: Text(
                                    productSpecs[index].value,
                                    style: TextStyle(
                                      color: _selectedSize == index
                                          ? Color(0xffE7A646)
                                          : Color(0xff707070),
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  _isSelected == true
                      ? _isLoading2
                          ? SizedBox(
                              width: 0,
                              height: 0,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white)))
                          : Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 7,
                                  right: SizeConfig.blockSizeHorizontal * 7,
                                  top: SizeConfig.blockSizeVertical * 1,
                                  bottom: SizeConfig.blockSizeVertical * 2),
                              child: GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: relatedSpecList?.length ?? 0,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 2.1,
                                        crossAxisCount: 6,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                                itemBuilder: (BuildContext context, int index) {
                                  return GridTile(
                                      child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedColor = index;
                                        colorSpecValue = relatedSpecList[index]
                                            .values[index]
                                            .value
                                            .split('#')
                                            .last;
                                      });
                                    },
                                    child: CircleAvatar(
                                        radius: .3,
                                        child: _selectedColor == index
                                            ? Center(
                                                child: Icon(Icons.check,
                                                    color: Theme.of(context)
                                                        .primaryColor))
                                            : Text(''),
                                        foregroundColor: Color(int.parse(
                                            '0xff' +
                                                relatedSpecList[index]
                                                    .values[index]
                                                    .value
                                                    .split('#')
                                                    .last)),
                                        backgroundColor: Color(int.parse(
                                            '0xff' +
                                                relatedSpecList[index]
                                                    .values[index]
                                                    .value
                                                    .split('#')
                                                    .last))),
                                  ));
                                },
                              ),
                            )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 5,
                        right: SizeConfig.blockSizeHorizontal * 5),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (productSpecs.length == 0) {
                              final productCart = ProductCart(
                                  id: productId,
                                  name: productName,
                                  mainImg: imgUrl,
                                  price: productPrice,
                                  categoryName: productCategory,
                                  priceAfterDiscount: productPriceAfter,
                                  quantity: 1,
                                  availability: productAvailability,
                                  colorSpecValue: colorSpecValue,
                                  inCart: 1,
                                  sizeSpecValue: sizeSpecValue);
                              cart.addProductToCart(productCart);
                              showToast();
                            } else {
                              if (_selectedSize == -1 || _selectedColor == -1) {
                                showErrorToast();
                              } else {
                                final productCart = ProductCart(
                                    id: productId,
                                    name: productName,
                                    mainImg: imgUrl,
                                    price: productPrice,
                                    categoryName: productCategory,
                                    priceAfterDiscount: productPriceAfter,
                                    quantity: 1,
                                    availability: productAvailability,
                                    colorSpecValue: colorSpecValue,
                                    inCart: 1,
                                    sizeSpecValue: sizeSpecValue);
                                cart.addProductToCart(productCart);
                                showToast();
                              }
                            }
                          },
                          child: Center(
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 42,
                              height: SizeConfig.blockSizeHorizontal * 10,
                              decoration: BoxDecoration(
                                  color: Color(0xff3A559F),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'add_to_cart'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        //  fontSize: 15,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: SizeConfig.blockSizeHorizontal * 3,
                                      color: Colors.red.shade900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            final productFav = ProductFav(
                                id: productId,
                                name: productName,
                                mainImg: imgUrl,
                                price: productPrice,
                                categoryName: productCategory,
                                isFav: 1);
                            fav.addProductToFav(productFav);
                            showFavToast();
                          },
                          child: Center(
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 40,
                              height: SizeConfig.blockSizeHorizontal * 10,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF6969),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'add_to_fav'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        //  fontSize: 15,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 4,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: SizeConfig.blockSizeHorizontal * 3,
                                      color: Colors.red.shade900,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        top: SizeConfig.blockSizeVertical * 3),
                    child: Divider(
                        height: SizeConfig.blockSizeVertical * .1,
                        color: Color(0xff727C8E)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        right: SizeConfig.blockSizeHorizontal * 7,
                        left: SizeConfig.blockSizeHorizontal * 7),
                    child: Row(
                      children: [
                        Text(
                          'related_products'.tr(),
                          style: TextStyle(
                            color: Color(0xff3A559F),
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 7,
                        right: SizeConfig.blockSizeHorizontal * 3,
                        bottom: SizeConfig.blockSizeVertical * 2),
                    height: SizeConfig.blockSizeVertical * 40,
                    child: ListView.builder(
                      itemCount: productRelated.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: ProductDetails.routeName,
                              arguments: {
                                'product_id': productRelated[index].id
                              }),
                          screen: ProductDetails(),
                          withNavBar: true,
                          pageTransitionAnimation: PageTransitionAnimation.fade,
                        ),
                        child: ProductDetailItem(
                          productId: productRelated[index]?.id ?? 0,
                          imgUrl: productRelated[index].mainImg,
                          productName: productRelated[index].name ?? "",
                          productPrice: productRelated[index].price ?? 0.0,
                          productPriceAfter:
                              productRelated[index]?.offer?.afterPrice ?? 0.0,
                          productStar: productRelated[index].stars ?? 0.0,
                          discount:
                              productRelated[index]?.offer?.discount ?? 0.0,
                          onAddToCart: () {
                            final cart = Provider.of<CartViewModel>(context,
                                listen: false);
                            final productCart = ProductCart(
                                id: productRelated[index].id,
                                name: productRelated[index].name,
                                mainImg: productRelated[index].mainImg,
                                price: productRelated[index].price,
                                priceAfterDiscount:
                                    productRelated[index].offer?.afterPrice ??
                                        productRelated[index].price,
                                categoryName:
                                    productRelated[index].category.name,
                                quantity: 1,
                                availability:
                                    productRelated[index].availability,
                                inCart: 1,
                                colorSpecValue: '',
                                sizeSpecValue: '');
                            cart.addProductToCart(productCart);
                          },
                          onAddToFavorite: () {
                            final productFav = ProductFav(
                                id: productRelated[index].id,
                                name: productRelated[index].name,
                                mainImg: productRelated[index].mainImg,
                                price: productRelated[index].price,
                                categoryName:
                                    productRelated[index].category.name,
                                isFav: 1);
                            fav.addProductToFav(productFav);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
