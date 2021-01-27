import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GradientAppBar extends StatefulWidget {
  final String title;

  GradientAppBar(this.title);

  @override
  _GradientAppBarState createState() => _GradientAppBarState();
}

class _GradientAppBarState extends State<GradientAppBar> {
  final double barHeight = 50.0;
  var valueCollection, valueCategory, currentSelectedValue;
  final deviceTypes = ["Mac", "Windows", "Mobile"];
  var _selection;

  Home home;
  List<Collections> collectionsList = [];
  List<NewArrivals> newArrivalsList = [];

  int _value = 1;
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

  openDropDownButton(BuildContext context) {
    print("enta fel dropdown now");
    return Container(
        child: DropdownButton(
      dropdownColor: Colors.green,
      hint: Text("Select Device"),
      value: currentSelectedValue,
      isDense: true,
      onChanged: (newValue) {
        setState(() {
          currentSelectedValue = newValue;
        });
        print(currentSelectedValue);
      },
      items: deviceTypes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ));
    // DropdownButtonHideUnderline(
    //   child: DropdownButton(
    //     isExpanded: true,
    //     itemHeight: 50.0,
    //     style: TextStyle(
    //       fontSize: 15.0,
    //       // color: isEnabled ? Colors.black : Colors.grey[700]
    //     ),
    //     items: [
    //       DropdownMenuItem(
    //         child: Text("First Item"),
    //         value: 1,
    //       ),
    //       DropdownMenuItem(
    //         child: Text("Second Item"),
    //         value: 2,
    //       ),
    //       DropdownMenuItem(child: Text("Third Item"), value: 3),
    //       DropdownMenuItem(child: Text("Fourth Item"), value: 4)
    //     ]
    //     // collectionsList.map((e) {
    //     //   return DropdownMenuItem(
    //     //     child: Text(e.name),
    //     //     value: e.id,
    //     //   );
    //     // }).toList()
    //     ,
    //     onChanged: (value) {
    //       setState(() {
    //         _value = value;
    //       });
    //     }
    //
    //     //     (value) {
    //     //   setState(() {
    //     //     valueCollection = value;
    //     //   });
    //     // }
    //     ,
    //   ),
    // ),
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: Row(
        children: [
          Row(
            children: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  Navigator.of(context).pushNamed(ShopScreen.routeName,
                      arguments: {'collection_id': int.parse(value)});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .11,
                  child: Icon(
                    Icons.menu,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
                itemBuilder: (context) => collectionsList
                    .map((item) => PopupMenuItem<String>(
                          child: Text(
                            item.name,
                          ),
                          value: item.id.toString(),
                        ))
                    .toList(),
              ),
              Image.asset(
                "assets/images/logo.png",
                height: MediaQuery.of(context).size.height * .06,
              )
            ],
          ),
          Spacer(),
          Text(
            widget.title,
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
                  //    showSearch(context: context, delegate: Search());
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
