import 'dart:io';

import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class DrawerLayout extends StatefulWidget {
  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  bool _isLoading = false;
  Home home;
  List<Collections> collectionsList = [];
  List<HotDeals> hotDeals = [];

  Future getHomeData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    await getHome.fetchHomeList().then((response) {
      home = response;
      collectionsList = home.data.collections;
      hotDeals = home.data.hotDeals;
    });
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          alignment: Alignment.topLeft,
          margin: Platform.isAndroid
              ? const EdgeInsets.only(top: 75)
              : const EdgeInsets.only(top: 95),
          height: MediaQuery.of(context).size.height * 0.35,
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: Drawer(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)))
                : SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        children: [
                          Text('Collections',
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.4,
                              style: const TextStyle(
                                  color: Color(0xff294794),
                                  fontWeight: FontWeight.bold)),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: collectionsList.length,
                              itemBuilder: (ctx, index) => GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: ShopScreen.routeName,
                                          arguments: {
                                            'collection_id':
                                                collectionsList[index].id
                                          }),
                                      screen: ShopScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Text(' - ' + collectionsList[index].name,
                                      textScaleFactor: MediaQuery.of(context)
                                              .textScaleFactor *
                                          1.25)),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 10)),
                          const SizedBox(height: 13),
                          Text('Hot Deals',
                              textScaleFactor:
                                  MediaQuery.of(context).textScaleFactor * 1.4,
                              style: const TextStyle(
                                  color: Color(0xff294794),
                                  fontWeight: FontWeight.bold)),
                          ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: hotDeals.length,
                              itemBuilder: (ctx, index) => GestureDetector(
                                    onTap: () => pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: ShopScreen.routeName,
                                            arguments: {
                                              'category_id': hotDeals[index].id
                                            }),
                                        screen: ShopScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade),
                                    child: Text(' - ' + hotDeals[index].name,
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
                                            1.25),
                                  ),
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 10))
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _DrawerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(50, 0);
    path.quadraticBezierTo(0, size.height / 2, 50, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
