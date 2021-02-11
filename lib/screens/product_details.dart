import 'package:carousel_slider/carousel_slider.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/model/related_spec.dart' as rs;
import 'package:cizaro_app/model/specMdel.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/product_details_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static final routeName = '/productDetails-screen';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
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
      sizeSpecValue;
  double productPrice, productStar, productPriceAfter;
  List<RelatedProducts> productRelated = [];
  List<MultiImages> productImages = [];
  List<Values> productSpecs = [];
  List<rs.Data> relatedSpecList = [];
  rs.RelatedSpec relatedSpec;

  Future getHomeData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getProduct = Provider.of<ListViewModel>(context, listen: false);
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    await getProduct
        .fetchProductDetailsList(arguments['product_id'])
        .then((response) {
      productDetails = response;
      productId = productDetails.data.id;
      productAvailability = productDetails.data.availability;
      productName = productDetails.data.name;
      imgUrl = productDetails.data.mainImg;
      productPrice = productDetails.data.price;
      productPriceAfter = productDetails.data.offer.afterPrice;

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
      // positionedToastBuilder: (context, child) {
      //   return Positioned(
      //     child: child,
      //     bottom: 16.0,
      //     left: 16.0,
      //   );
      // } da law 3ayz tezbat el postion ele hayzhar feh
      gravity: ToastGravity.BOTTOM,
    );
  }

  showFavToast() {
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
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  GradientAppBar(""),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                            color: Color(0xff3A559F),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Spacer(),
                        Container(
                          width: MediaQuery.of(context).size.width * .3,
                          child: Column(
                            children: [
                              Text(
                                productName ?? "",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.5,
                              ),
                              Row(
                                children: [
                                  productPriceAfter == productPrice
                                      ? Container(
                                          child: Text(
                                            productPrice.toString() + ' LE',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    0.85,
                                          ),
                                        )
                                      : Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                  top: 5,
                                                ),
                                                child: Text(
                                                  productPrice.toString() +
                                                      ' LE',
                                                  textScaleFactor:
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          0.85,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Text(
                                                  productPriceAfter.toString() +
                                                      ' LE',
                                                  textScaleFactor:
                                                      MediaQuery.of(context)
                                                              .textScaleFactor *
                                                          0.85,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                  // Text(
                                  //   productPrice.toString(),
                                  //   textScaleFactor:
                                  //       MediaQuery.of(context).textScaleFactor *
                                  //           1.1,
                                  // ),
                                  Spacer(),
                                  Container(
                                    padding: EdgeInsets.only(right: 5),
                                    height: MediaQuery.of(context).size.height *
                                        .03,
                                    decoration: BoxDecoration(
                                        color: Color(0xffFF6969),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          productStar.toString() ?? 0.0,
                                          style: TextStyle(color: Colors.white),
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  1,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  productImages?.length == 0
                      ? Container(
                          height: MediaQuery.of(context).size.height * .4,
                          width: double.infinity,
                          child: Image.network(imgUrl),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * .4,
                          width: double.infinity,
                          child: CarouselSlider.builder(
                            // dotColor: Color(0xff727C8E),
                            // radius: Radius.circular(5.0),
                            // dotSize: 5.0,
                            // dotBgColor: Colors.white,
                            // autoplay: false,
                            // dotIncreasedColor: Color(0xff727C8E),
                            // images: productImages.length == 0
                            //     ? imgUrl
                            //     : productImages,
                            itemCount: productImages.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Image.network(
                                    productImages[index]?.image ?? imgUrl),
                              );
                            },
                            options: CarouselOptions(
                              aspectRatio: 16 / 9,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: false,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                  // Container(
                  //   child: SmoothPageIndicator(
                  //     // controller: controller,
                  //     count: productImages.length,
                  //     effect: SlideEffect(
                  //         spacing: 8.0,
                  //         radius: 4.0,
                  //         dotWidth: 24.0,
                  //         dotHeight: 16.0,
                  //         dotColor: Colors.grey,
                  //         paintStyle: PaintingStyle.stroke,
                  //         strokeWidth: 2,
                  //         activeDotColor: Colors.indigo),
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Description ",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.7,
                          style: TextStyle(color: Color(0xff3A559F)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, left: 10),
                    child: Column(
                      children: [
                        Text(
                          productDescription ?? "",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1,
                          style: TextStyle(color: Color(0xff707070)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 15),
                    child: Row(
                      children: [
                        Text(
                          specTitle == ''
                              ? ''
                              : "Select $specTitle".toUpperCase(),
                          style: TextStyle(color: Color(0xff515C6F)),
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1,
                        ),
                      ],
                    ),
                  ),
                  _isColor == true
                      ? GridView.builder(
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
                        )
                      : GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: productSpecs.length,
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, top: 10),
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
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  productSpecs[index].value,
                                  style: TextStyle(
                                    color: _selectedSize == index
                                        ? Color(0xffE7A646)
                                        : Color(0xff707070),
                                  ),
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1.2,
                                ),
                              ),
                            );
                          },
                        ),
                  _isSelected == true
                      ? _isLoading2
                          ? SizedBox(
                              width: 0,
                              height: 0,
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white)))
                          : GridView.builder(
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
                                      foregroundColor: Color(int.parse('0xff' +
                                          relatedSpecList[index]
                                              .values[index]
                                              .value
                                              .split('#')
                                              .last)),
                                      backgroundColor: Color(int.parse('0xff' +
                                          relatedSpecList[index]
                                              .values[index]
                                              .value
                                              .split('#')
                                              .last))),
                                ));
                              },
                            )
                      : Container(),
                  GestureDetector(
                    onTap: () {
                      final productCart = ProductCart(
                          id: productId,
                          name: productName,
                          mainImg: imgUrl,
                          price: productPrice,
                          categoryName: productName,
                          quantity: 1,
                          availability: productAvailability,
                          colorSpecValue: colorSpecValue,
                          sizeSpecValue: sizeSpecValue);
                      cart.addProductToCart(productCart);
                      showToast();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * .44,
                      height: MediaQuery.of(context).size.height * .066,
                      decoration: BoxDecoration(
                          color: Color(0xff3A559F),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "ADD TO CART",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.red.shade900,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Related Products ",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.5,
                          style: const TextStyle(color: Color(0xff3A559F)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    height: MediaQuery.of(context).size.height * .33,
                    child: ListView.builder(
                        itemCount: productRelated.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) => GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                  ProductDetails.routeName,
                                  arguments: {
                                    'product_id': productRelated[index].id
                                  }),
                              child: ProductDetailItem(
                                imgUrl: productRelated[index].mainImg,
                                productName: productRelated[index].name ?? "",
                                productPrice:
                                    productRelated[index].price ?? 0.0,
                                productPriceAfter:
                                    productRelated[index]?.offer?.afterPrice ??
                                        0.0,
                                productStar: productRelated[index].stars ?? 0.0,
                              ),
                            )),
                  )
                ],
              ),
            ),
    );
  }
}
