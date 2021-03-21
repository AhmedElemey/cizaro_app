import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerLayout extends StatefulWidget {
  @override
  _DrawerLayoutState createState() => _DrawerLayoutState();
}

class _DrawerLayoutState extends State<DrawerLayout> {
  bool _isLoading = false;
  Home home;
  List<Collections> collectionsList = [];
  List<HotDeals> hotDeals = [];

  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  Future getHomeData() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    bool languageValue = await getLang();
    await getHome
        .fetchHomeList(languageValue == null
            ? 'en'
            : languageValue == false
                ? 'en'
                : 'ar')
        .then((response) {
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        // alignment: Alignment.topLeft,
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 10.6,
            bottom: SizeConfig.blockSizeVertical * 40),
        width: SizeConfig.blockSizeHorizontal * 50,
        // height: SizeConfig.blockSizeVertical * 36,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Drawer(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 3,
                        horizontal: SizeConfig.blockSizeHorizontal * 3),
                    child: Column(
                      children: [
                        Text('collection_title'.tr(),
                            style: TextStyle(
                                color: Color(0xff294794),
                                fontSize: SizeConfig.safeBlockVertical * 3,
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
                                    style: TextStyle(
                                        fontSize: SizeConfig.safeBlockVertical *
                                            2.5))),
                            separatorBuilder: (BuildContext context, int index) =>
                                SizedBox(height: SizeConfig.blockSizeVertical * 1.5)),
                        SizedBox(height: SizeConfig.blockSizeVertical * 3),
                        Text('hot_deals_title'.tr(),
                            style: TextStyle(
                                color: Color(0xff294794),
                                fontSize: SizeConfig.safeBlockVertical * 3,
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
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.safeBlockVertical *
                                                  2.5)),
                                ),
                            separatorBuilder:
                                (BuildContext context, int index) => SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1.5))
                      ],
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
