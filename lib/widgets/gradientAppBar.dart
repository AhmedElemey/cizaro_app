import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/searchBar_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class GradientAppBar extends StatefulWidget {
  final String title;
  GlobalKey<ScaffoldState> _scaffoldKey1 = GlobalKey<ScaffoldState>();

  GradientAppBar(this.title, this._scaffoldKey1);

  @override
  _GradientAppBarState createState() => _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {
  final double barHeight = 50.0;
  var valueCollection, valueCategory, currentSelectedValue;
  // final deviceTypes = ["Mac", "Windows", "Mobile"];
  // var _selection;

  Home home;
  List<Collections> collectionsList = [];
  List<NewArrivals> newArrivalsList = [];
  List<HotDeals> hotDeals = [];

  // int _value = 1;
//  bool isEnabled;

  Future getHomeData() async {
    final getHome = Provider.of<ListViewModel>(context, listen: false);
    await getHome.fetchHomeList().then((response) {
      home = response;
      collectionsList = home.data.collections;
      newArrivalsList = home.data.newArrivals;

      print(collectionsList.length);
    });
  }

  @override
  void initState() {
    Future.microtask(() => getHomeData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    Map _mySelection;

    SizeConfig().init(context);
    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Row(
        children: [
          Row(
            children: [
              Container(
                child: GestureDetector(
                  onTap: () {
                    widget._scaffoldKey1.currentState.openDrawer();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * .11,
                    child: Icon(
                      Icons.menu,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: MediaQuery.of(context).size.height * .05,
              )
            ],
          ),
          Spacer(),
          Center(
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.all(7.0),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  size: 17,
                ),
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
// Container(
// width: MediaQuery.of(context).size.width * .1,
// child: IconButton(
// icon: Icon(Icons.menu),
// color: Colors.white,
// iconSize: 30,
// onPressed: () {
// return DropdownButton( items: <String>['Collections', 'HotDeals']
//     .map<DropdownMenuItem<String>>((String value) {
// return DropdownMenuItem<String>(
// value: value,
// child: Text(value),
// );
// }).toList(),
// onChanged: (value)
// {if (value ==valueCollection){
// return DropdownButton(
// //  hint: Text("Select Collection "),
// value: valueCollection,
// dropdownColor: Colors.grey.shade400,
// items: collectionsList.map((e) {
// return DropdownMenuItem(
// child: Text(e.name),
// value: e.id,
// );
// }).toList(),
// onChanged: (value) {
// setState(() {
// valueCollection = value;
// });
// },
// );}if(value==)
// });   //  hint: Text("Select Collection "),
// //   value: valueCollection,
// //   dropdownColor: Colors.grey.shade400,
// //   items: collectionsList.map((e) {
// //     return DropdownMenuItem(
// //       child: Text(e.name),
// //       value: e.id,
// //     );
// //   }).toList(),
// //   onChanged: (value) {
// //     setState(() {
// //       valueCollection = value;
// //     });
// //   },
// // );
// },
// ),
// ),
