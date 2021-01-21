import 'package:cizaro_app/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MycartScreen extends StatelessWidget {
  static final routeName = '/mycart-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Container(
      //       padding: EdgeInsets.all(10),
      //       child: Image.asset(
      //         "assets/images/logo.png",
      //         height: MediaQuery.of(context).size.height * .1,
      //       )),
      //   title: Center(
      //     child: Text("My Cart"),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("My Cart"),
            Container(
              padding: EdgeInsets.only(left: 20, top: 5),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Cart",
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 2,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Color(0xff515C6F)),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .65,
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (ctx, index) => CartItem(
                  imgUrl: "assets/images/collection.png",
                  productName: "Treecode",
                  productCategory: "men fashion",
                  productPrice: 65,
                  totalPrice: 49.99,
                  productQuanitity: 3.toString(),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .07,
                    child: Column(
                      children: [
                        Text(
                          "TOTAL",
                          textScaleFactor:
                              MediaQuery.of(context).textScaleFactor * .9,
                        ),
                        Spacer(),
                        Container(
                          child: Text(
                            '\$' + "45454",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.4,
                            style: TextStyle(color: Color(0xff3A559F)),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 10),
                    width: MediaQuery.of(context).size.width * .4,
                    height: MediaQuery.of(context).size.height * .06,
                    decoration: BoxDecoration(
                        color: Color(0xff3A559F),
                        borderRadius: BorderRadius.circular(25.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            margin: new EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "CHECKOUT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.only(right: 5),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Color(0xff3A559F),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
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
                Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
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
