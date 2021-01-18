import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/collection_item.dart';
import 'package:cizaro_app/widgets/hotDeals_item.dart';
import 'package:cizaro_app/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home-screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HotDeals> hotDealsList = [];
  List<Collections> collectionsList = [];
  List<NewArrivals> newArrivalsList = [];
  Home home;

  Future getHomeData() async {
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    await getHome.fetchHomeList().then((response) {
      home = response;
      hotDealsList = home.data.hotDeals;
      print(hotDealsList.length);

      collectionsList = home.data.collections;
      print(collectionsList.length);

      newArrivalsList = home.data.newArrivals;
      print(newArrivalsList.length);
    });
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  Widget tabsWidgets() {
    // int index;
    // var tabs_name;
    // newArrivalsList.forEach((element) {
    //   tabs_name = element.products[index].category.name;
    //
    //   print(tabs_name);
    // });

    return DefaultTabController(
      length: 5,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width * .9,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  labelPadding:
                      const EdgeInsets.only(right: 10, left: 30, bottom: 5),
                  indicatorWeight: 4,
                  indicatorColor: Color(0xff294794),
                  labelColor: Color(0xff294794),
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: <Widget>[
                    Text("Top",
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("bags",
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("skirts",
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("t-shirts",
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("pants",
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height * .25,
                  child: ListView.builder(
                      itemCount: newArrivalsList.length.compareTo(0),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) => GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed(
                                ProductDetails.routeName,
                                arguments: {
                                  'product_id': newArrivalsList[index].id
                                }),
                            child: ProductItem(
                              // newArrivalsList[index]?.products[index].id,
                              productText:
                                  newArrivalsList[index]?.products[index]?.name,
                              //newArrivalsList[index]?.products[index].name,
                              imgUrl: newArrivalsList[index]
                                  ?.products[index]
                                  ?.mainImg,
                              //newArrivalsList[index]?.products[index].mainImg,
                              productPrice: newArrivalsList[index]
                                  ?.products[index]
                                  ?.price,
                              //newArrivalsList[index]?.products[index].price,
                            ),
                          )),
                ),
                Container(
                  child: Text(
                    "Second View",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: Text(
                    "Third View",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: Text(
                    "forth View",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  child: Text(
                    "fifth View",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  "Hot Deals",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color(0xff294794)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5),
              height: MediaQuery.of(context).size.height * .2,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: hotDealsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(ProductDetails.routeName),
                        child: HotDealsItem(
                          id: hotDealsList[index].id,
                          //   itemText: hotDealsList[index].offer.type.name,
                        ),
                      )),
            ),
            Container(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Collections",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.2,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff294794)),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height * .3,
              child: ListView.builder(
                  itemCount: collectionsList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(ProductDetails.routeName),
                        child: CollectionItem(
                          id: collectionsList[index].id,
                          itemText: collectionsList[index].name,
                          imgUrl: collectionsList[index].imageBanner,
                        ),
                      )),
            ),
            Container(
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    " New Arrivals",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xff294794)),
                  ),
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * .4,
                child: tabsWidgets())
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
