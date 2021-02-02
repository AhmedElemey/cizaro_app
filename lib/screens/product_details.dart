import 'package:carousel_pro/carousel_pro.dart';
import 'package:cizaro_app/helper/database_helper.dart';
import 'package:cizaro_app/model/cartModel.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/view_model/cart_view_model.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/product_details_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';

class ProductDetails extends StatefulWidget {
  static final routeName = '/productDetails-screen';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isLoading = false, _isColor = false;
  ProductDetailsModel productDetails;
  FToast fToast;
  int _selectedCard = -1, productId, productAvailability;
  String productName, imgUrl, productDescription, specTitle;
  double productPrice, productStar;
  List<RelatedProducts> productRelated = [];
  List<MultiImages> productImages = [];
  List<Values> productSpecs = [];
  Specs specs;
  List<Values> specsValuesList = [];

  Future getHomeData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });
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
      productStar = productDetails.data.stars;
      productDescription = productDetails.data.shortDescription;
      _isColor = productDetails.data.specs?.isColor ?? false;
      specTitle = productDetails?.data.specs?.name ?? "";

      _isColor = productDetails?.data.specs?.isColor ?? false;
      specTitle = productDetails?.data.specs?.name ?? "";
      //
      productRelated = productDetails.data.relatedProducts;
//
      productImages = productDetails.data.multiImages;
      //
      productSpecs = productDetails?.data.specs?.values ?? [];
      print(productRelated.length);
      // print(productList.data.relatedProducts.length);
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
  }

  Future getSpecData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });
    final getSpec = Provider.of<ListViewModel>(context, listen: false);
    await getSpec
        .fetchSpecValues(_selectedCard).then((response) {
      specs = response;
      specsValuesList = specs.values;
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
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
          Icon(Icons.check,color: Colors.white),
          SizedBox(width: 12.0),
          Text("Added to Cart",style: const TextStyle(color: Colors.white))
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

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartViewModel>(context,listen: false);
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
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Container(
                          child: Column(
                            children: [
                              Text(
                                productName ?? "",
                                textScaleFactor:
                                    MediaQuery.of(context).textScaleFactor *
                                        1.1,
                              ),
                              Row(
                                children: [
                                  Text(
                                    productPrice.toString(),
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            1.1,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .1,
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
                        Icon(
                          Icons.shopping_cart,
                          color: Color(0xff2DE300),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: Carousel(
                          dotColor: Color(0xff727C8E),
                          radius: Radius.circular(5.0),
                          dotSize: 5.0,
                          dotBgColor: Colors.white,
                          autoplay: false,
                          dotIncreasedColor: Color(0xff727C8E),
                          images: [Image.asset("assets/images/hot.png")],
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Text(
                          "Description ",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 2,
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
                          "Select $specTitle".toUpperCase(),
                          style: TextStyle(color: Color(0xff515C6F)),
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1,
                        ),
                      ],
                    ),
                  ),
                  _isColor == true
                      ? Container(
                          padding:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          height: MediaQuery.of(context).size.height * .1,
                          child: GridView.builder(
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
                                    _selectedCard = index;
                                  });
                                },
                                child: CircleAvatar(
                                    radius: .3,
                                    child: _selectedCard == index
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
                          ))
                      : Container(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          height: MediaQuery.of(context).size.height * .06,
                          child: GridView.builder(
                            itemCount: productSpecs.length,
                            padding: const EdgeInsets.only(right: 8, left: 8),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 2,
                                    crossAxisCount: 6,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCard = index;
                                    _selectedCard = productSpecs[index].id;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    productSpecs[index].value,
                                    style: TextStyle(
                                      color: _selectedCard == index
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
                          )),
                  // Container(
                  //   padding: EdgeInsets.only(left: 10, top: 10),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         "SELECT SIZE (US)",
                  //         style: TextStyle(color: Color(0xff515C6F)),
                  //         textScaleFactor:
                  //             MediaQuery.of(context).textScaleFactor * 1,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width * .44,
                    height: MediaQuery.of(context).size.height * .066,
                    decoration: BoxDecoration(
                        color: Color(0xff3A559F),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final productCart = ProductCart(
                                id: productId,
                                name: productName,
                                mainImg: imgUrl,
                                price: productPrice,
                                categoryName: productName,
                                quantity: 1,
                                availability: productAvailability);
                            cart.addProductToCart(productCart);
                            showToast();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "ADD TO CART",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 5),
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
                    padding: const EdgeInsets.only(top: 10, left: 5),
                    height: MediaQuery.of(context).size.height * .3,
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
