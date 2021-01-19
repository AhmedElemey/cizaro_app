import 'package:cizaro_app/model/shopModel.dart';
import 'package:cizaro_app/widgets/shop_item.dart';
import 'package:flutter/material.dart ';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';

class ShopScreen extends StatefulWidget {
  static final routeName = '/product-screen';

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
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
  }

  @override
  void initState() {
    Future.microtask(() => getShopData());
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
          "assets/images/logo.png",
          height: MediaQuery.of(context).size.height * .07,
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height * .7,
                    child: ListView.builder(
                      itemCount: productList.length,
                      itemBuilder: (ctx, index) => ShopItem(
                        imgUrl: productList[index].mainImg,
                        productName: productList[index].name,
                        productPrice: productList[index].price,
                      ),
                    ),
                  ),
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
