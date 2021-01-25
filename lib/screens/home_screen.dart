import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/collection_item.dart';
import 'package:cizaro_app/widgets/custom_tab_bar.dart';
import 'package:cizaro_app/widgets/hotDeals_item.dart';
import 'package:cizaro_app/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  Home home;
  int initPosition = 0;
  bool _isLoading = false;

  Future getHomeData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    await getHome.fetchHomeList().then((response) {
      home = response;
      hotDealsList = home.data.hotDeals;
      collectionsList = home.data.collections;
      newArrivalsList = home.data.newArrivals;
      topSellingList = home.data.topSelling;
    });
    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  Widget tabsWidgets() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: newArrivalsList?.length ?? 0,
        tabBuilder: (context, index) => Tab(text: newArrivalsList[index].name),
        pageBuilder: (context, index) => Container(
          height: MediaQuery.of(context).size.height * .38,
          child: ListView.builder(
              padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
              itemCount: newArrivalsList[index]?.products?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(ProductDetails.routeName, arguments: {
                      'product_id': newArrivalsList[0].products[index].id
                    }),
                    child: ProductItem(
                        productText:
                            newArrivalsList[0]?.products[index]?.name ?? '',
                        imgUrl:
                            newArrivalsList[0]?.products[index]?.mainImg ?? '',
                        productPrice:
                            newArrivalsList[0]?.products[index]?.price ?? 0.0),
                  )),
        ),
        onPositionChange: (index) {
          initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  Widget topSellingWidgets() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 8),
      child: CustomTabView(
        initPosition: initPosition,
        itemCount: topSellingList?.length ?? 0,
        tabBuilder: (context, index) => Tab(text: topSellingList[index].name),
        pageBuilder: (context, index) => Container(
          height: MediaQuery.of(context).size.height * .38,
          child: ListView.builder(
              padding: const EdgeInsets.only(right: 5, left: 5, top: 5),
              itemCount: topSellingList[index]?.products?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(ProductDetails.routeName, arguments: {
                      'product_id': topSellingList[0].products[index].id
                    }),
                    child: ProductItem(
                        productText:
                            topSellingList[0]?.products[index]?.name ?? '',
                        imgUrl:
                            topSellingList[0]?.products[index]?.mainImg ?? '',
                        productPrice:
                            topSellingList[0]?.products[index]?.price ?? 0.0),
                  )),
        ),
        onPositionChange: (index) {
          initPosition = index;
        },
        onScroll: (position) => print('$position'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Align(
        alignment: Alignment.topLeft,
        child: Container(
          padding: EdgeInsets.only(top: 50, left: 10),
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width * .4,
          decoration: BoxDecoration(shape: BoxShape.circle),
          child: Drawer(
            child: Column(
              children: [DrawerHeader(child: Container(child: Text("hello")))],
            ),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientAppBar(""),
                  hotDealsList.length == 0 || hotDealsList.length == null
                      ? Container()
                      : Container(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Hot Deals",
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            1.2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xff294794)),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                height: MediaQuery.of(context).size.height * .3,
                                width: double.infinity,
                                child: CarouselSlider.builder(
                                  itemCount: hotDealsList.length,
                                  itemBuilder: (ctx, index) {
                                    return GestureDetector(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed(ProductDetails.routeName),
                                      child: HotDealsItem(
                                          id: hotDealsList[index].id,
                                          itemText: hotDealsList[index].name,
                                          imgUrl:
                                              hotDealsList[index].offer.image),
                                    );
                                  },
                                  options: CarouselOptions(
                                    aspectRatio: 16 / 9,
                                    viewportFraction: 0.8,
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
                  collectionsList.length == 0 || collectionsList.length == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                //     spreadRadius: 1,
                                //   blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      "Collections",
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xff294794)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                height: MediaQuery.of(context).size.height * .3,
                                child: ListView.builder(
                                    itemCount: collectionsList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (ctx, index) =>
                                        GestureDetector(
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(ShopScreen.routeName,
                                                  arguments: {
                                                'collection_id':
                                                    collectionsList[index].id
                                              }),
                                          child: CollectionItem(
                                            id: collectionsList[index].id,
                                            itemText:
                                                collectionsList[index].name,
                                            imgUrl: collectionsList[index]
                                                .imageBanner,
                                          ),
                                        )),
                              ),
                            ],
                          ),
                        ),
                  newArrivalsList.length == 0 || newArrivalsList.length == null
                      ? Container()
                      : Container(
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    " New Arrivals",
                                    textScaleFactor:
                                        MediaQuery.of(context).textScaleFactor *
                                            1.1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Color(0xff294794)),
                                  ),
                                ),
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .4,
                                  child: tabsWidgets()),
                            ],
                          ),
                        ),
                  topSellingList.length == 0 || topSellingList.length == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(top: 30),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                //     spreadRadius: 1,
                                //   blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      "Top Selling ",
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Color(0xff294794)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  height:
                                      MediaQuery.of(context).size.height * .4,
                                  child: topSellingWidgets()),
                            ],
                          ),
                        ),
                ],
              ),
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

class CustomTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Color(0xff3A559F)),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
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
                GestureDetector(
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 30,
                  ),
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
