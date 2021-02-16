import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/favorite_item.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          Text("Removed from Favorite",
              style: const TextStyle(color: Colors.white))
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
            height: MediaQuery.of(context).size.height * 0.7,
            padding: const EdgeInsets.all(25),
            child: Center(
                child: Text(
                    'Your Favorites is Empty, please Add your Favorites.',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.3)))
        : Container(
            height: MediaQuery.of(context).size.height * .7,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: fav.favProductModel?.length ?? 0,
                itemBuilder: (ctx, index) => FavoriteItem(
                      imgUrl: fav.favProductModel[index].mainImg,
                      productName: fav.favProductModel[index].name,
                      productCategory: fav.favProductModel[index].categoryName,
                      productStar: fav.favProductModel[index].stars.toString(),
                      productPrice: fav.favProductModel[index].price.toString(),
                      unFavorite: () {
                        fav.deleteFavProduct(
                            index, fav.favProductModel[index].id);
                        setState(() {
                          fav.favProductModel?.removeAt(index);
                          // fav.favProductModel[index].isFav = 0;
                        });
                        showUnFavToast();
                      },
                    )),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey8,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("My Favorite", _scaffoldKey8),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            favProductList(),
          ],
        ),
      ),
    );
  }
}
