import 'dart:io';

import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/searchBar_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GradientAppBar extends StatefulWidget {
  final String title;
  final bool withBackIcon;
  GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

  GradientAppBar(this.title, this._scaffoldKey1, this.withBackIcon);

  @override
  _GradientAppBarState createState() => _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {
  final double barHeight = 50.0;
  var valueCollection, valueCategory, currentSelectedValue;
  Home home;
  bool languageValue = false;
  List<Collections> collectionsList = [];
  List<NewArrivals> newArrivalsList = [];
  List<HotDeals> hotDeals = [];

  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  Future getHomeData() async {
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    languageValue = await getLang();
    await getHome
        .fetchHomeList(languageValue == false ? 'en' : 'ar')
        .then((response) {
      home = response;
      collectionsList = home.data.collections;
      newArrivalsList = home.data.newArrivals;
    });
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Row(
        children: [
          Row(
            children: [
              Platform.isIOS
                  ? widget.withBackIcon == true
                      ? SizedBox(width: SizeConfig.blockSizeHorizontal * 2)
                      : Container()
                  : Container(),
              Platform.isIOS
                  ? widget.withBackIcon == true
                      ? GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Icon(CupertinoIcons.back, color: Colors.white))
                      : Container()
                  : Container(),
              Container(
                child: GestureDetector(
                  onTap: () => widget._scaffoldKey1.currentState.openDrawer(),
                  child: Container(
                      width: MediaQuery.of(context).size.width * .11,
                      child: Icon(Icons.menu, size: 25, color: Colors.white)),
                ),
              ),
              Image.asset("assets/images/logo.png",
                  height: MediaQuery.of(context).size.height * .05)
            ],
          ),
          Spacer(),
          Center(
              child: Text(widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))),
          Spacer(),
          Container(
            padding: EdgeInsets.all(7.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(Icons.search, size: 17),
                onPressed: () {
                  pushNewScreenWithRouteSettings(context,
                      settings: RouteSettings(name: SearchBarScreen.routeName),
                      screen: SearchBarScreen(),
                      withNavBar: true,
                      pageTransitionAnimation: PageTransitionAnimation.fade);
                  // Navigator.of(context).pushNamed(SearchBarScreen
                  //     .routeName); //    showSearch(context: context, delegate: Search());
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
