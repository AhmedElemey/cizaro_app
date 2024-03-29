import 'package:cizaro_app/view_model/fav_iew_model.dart';
import 'package:cizaro_app/widgets/favorite_item.dart';
import 'package:flutter/material.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  static final routeName = '/favorite-screen';

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FToast fToast;
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
                          fav.favProductModel[index].isFav = 0;
                        });
                        showUnFavToast();
                      },
                    )),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Container(
      //       padding: EdgeInsets.only(left: 10),
      //       child: Image.asset(
      //         "assets/images/logo.png",
      //       )),
      //   title: Center(
      //     child: Text("Wishlist"),
      //   ),
      //   actions: [
      //     Container(
      //       padding: EdgeInsets.all(10.0),
      //       child: CircleAvatar(
      //         backgroundColor: Colors.white,
      //         child: Icon(
      //           Icons.search,
      //           color: Colors.black,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("My Favorite"),
            Container(
              padding: EdgeInsets.only(left: 10, top: 25),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Noha Hamza",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Nohahamza@email.com",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                ],
              ),
            ),
            favProductList(),
          ],
        ),
      ),
    );
  }
}
