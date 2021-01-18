import 'package:carousel_pro/carousel_pro.dart';
import 'package:cizaro_app/model/product_details.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/product_details_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static final routeName = '/productDetails-screen';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailsModel productList;
  int _selectedCard = -1;
  Future getHomeData() async {
    final getProduct = Provider.of<ListViewModel>(context, listen: false);
    await getProduct.fetchProductDetailsList().then((response) {
      productList = response;
      print(productList.data.products.length);
    });
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            )),
        title: Center(
            child: Image.asset(
          "assets/images/cizaro_logo.png",
          height: MediaQuery.of(context).size.height * .1,
        )),
        actions: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.search),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    size: 20,
                    color: Color(0xffFB2733),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Red Heels with silver strases ",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.1,
                        ),
                        Row(
                          children: [
                            Text(
                              "49.99 LE ",
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * .1,
                              height: MediaQuery.of(context).size.height * .03,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF6969),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                    padding: EdgeInsets.only(left: 5),
                                  ),
                                  Text(
                                    "4.9",
                                    style: TextStyle(color: Colors.white),
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
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
                    images: [
                      Image.asset("assets/images/hot.png"),
                      Image.asset("assets/images/boots.png"),
                      Image.asset("assets/images/discount.png"),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    "Description ",
                    textScaleFactor: MediaQuery.of(context).textScaleFactor * 2,
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
                    "It was popularised in the 1960s with the release of "
                    "Letraset sheets containing Lorem Ipsum passages,and"
                    " more recently with desktop publishing software like Aldus"
                    " PageMaker including versions of Lorem Ipsum ",
                    textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
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
                    "SELECT COLOR",
                    style: TextStyle(color: Color(0xff515C6F)),
                    textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                height: MediaQuery.of(context).size.height * .09,
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3,
                      crossAxisCount: 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return new GridTile(
                        child: GestureDetector(
                      child: CircleAvatar(
                        radius: .5,
                        backgroundColor: Colors.black26,
                      ),
                    ));
                  },
                )),
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Row(
                children: [
                  Text(
                    "SELECT SIZE (US)",
                    style: TextStyle(color: Color(0xff515C6F)),
                    textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                height: MediaQuery.of(context).size.height * .06,
                child: GridView.builder(
                  itemCount: 6,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.3,
                      crossAxisCount: 6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCard = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "4.5",
                          style: TextStyle(
                            color: _selectedCard == index
                                ? Color(0xffE7A646)
                                : Color(0xff707070),
                          ),
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * 1.2,
                        ),
                      ),
                    );
                  },
                )),
            Container(
              width: MediaQuery.of(context).size.width * .44,
              height: MediaQuery.of(context).size.height * .066,
              decoration: BoxDecoration(
                  color: Color(0xff3A559F),
                  borderRadius: BorderRadius.circular(25.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: new EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "ADD TO CART",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(right: 5),
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
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Row(
                children: [
                  Text(
                    "Related Products ",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.5,
                    style: TextStyle(color: Color(0xff3A559F)),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 5),
              height: MediaQuery.of(context).size.height * .3,
              child: ListView.builder(
                  itemCount: productList.data.products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(ProductDetails.routeName),
                        child: ProductDetailItem(
                          imgUrl: productList.data.products[index].mainImg,
                          productName: productList.data.products[index].name,
                          productPrice: productList.data.products[index].price,
                          productStar: productList.data.products[index].stars,
                        ),
                      )),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 35), label: 'Home'),
          new BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 35,
              ),
              label: 'Search'),
          new BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart, size: 35), label: 'Cart'),
          new BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 35),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
