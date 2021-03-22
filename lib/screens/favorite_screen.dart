import 'package:cizaro_app/screens/product_details.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/favorite_item.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart' as tab;
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static final routeName = '/favorite-screen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FToast fToast;
  final GlobalKey<ScaffoldState> _scaffoldKey8 = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    //   Future.microtask(() => getHomeData());
    super.initState();
    fToast = FToast();
    fToast.init(context); // de 3ashan awel lama aload el screen t7mel el data
  }

  showUnFavToast() {
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
          Text("remove_fav".tr(), style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  Widget favProductList() {
    final fav = Provider.of<FavViewModel>(context, listen: true);
    return fav.favProductModel.length == 0
        ? Container(
            height: SizeConfig.blockSizeVertical * 90,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 3,
                horizontal: SizeConfig.blockSizeHorizontal * 3),
            child: Center(
                child: Text('no_fav'.tr(),
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 4,
                    ),
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.3)))
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: fav.favProductModel?.length ?? 0,
            itemBuilder: (ctx, index) => GestureDetector(
                  onTap: () => tab.pushNewScreenWithRouteSettings(context,
                      settings: RouteSettings(
                          name: ProductDetails.routeName,
                          arguments: {
                            'product_id': fav.favProductModel[index]?.id
                          }),
                      screen: ProductDetails(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          tab.PageTransitionAnimation.fade),
                  child: FavoriteItem(
                    imgUrl: fav.favProductModel[index].mainImg ?? "",
                    productName: fav.favProductModel[index].name ?? "",
                    productCategory:
                        fav.favProductModel[index].categoryName ?? "",
                    productStar: fav.favProductModel[index]?.stars ?? '0.0',
                    productPrice:
                        fav.favProductModel[index].price.toString() ?? "",
                    unFavorite: () {
                      fav.deleteFavProduct(
                          index, fav.favProductModel[index].id);
                      setState(() {
                        fav.favProductModel?.removeAt(index);
                        // fav.favProductModel[index].isFav = 0;
                      });
                      showUnFavToast();
                    },
                  ),
                ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey8,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar('wish_list'.tr(), _scaffoldKey8, true),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            favProductList(),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            )
          ],
        ),
      ),
    );
  }
}
