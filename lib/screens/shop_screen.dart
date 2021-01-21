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
    if (this.mounted)
      setState(() {
        _isLoading = false;
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
      // appBar: AppBar(
      //   leading: Container(
      //       padding: EdgeInsets.all(10),
      //       child: Icon(
      //         Icons.menu,
      //         color: Colors.white,
      //         size: 30,
      //       )),
      //   title: Center(
      //       child: Image.asset(
      //     "assets/images/logo.png",
      //     height: MediaQuery.of(context).size.height * .07,
      //   )),
      //   actions: [
      //     Container(
      //       padding: EdgeInsets.all(10.0),
      //       child: CircleAvatar(
      //         backgroundColor: Colors.white,
      //         child: Icon(Icons.search),
      //       ),
      //     )
      //   ],
      // ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  GradientAppBar(""),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    height: MediaQuery.of(context).size.height,
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

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 50.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: EdgeInsets.only(top: statusbarHeight),
      height: statusbarHeight + barHeight,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                Image.asset(
                  "assets/images/logo.png",
                  height: MediaQuery.of(context).size.height * .06,
                )
              ],
            ),
          ),
          Spacer(),
          Text(
            title,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(7.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                ),
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Color(0xff395A9A), Color(0xff0D152A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 1.0]),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  List<String> recentList = ["Amr", "Baiomey", "Ahmed", "Kareem"];
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentList
        : suggestionList
            .addAll(recentList.where((element) => element.contains(query)));
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index]),
          onTap: () {
            selectedResult = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
