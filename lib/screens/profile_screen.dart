import 'dart:ffi';

import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/contactUs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';

class ProfileScreen extends StatelessWidget {
  static final routeName = '/profile-screen';
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
      //     child: Text("Profile"),
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
            GradientAppBar("Profile"),
            Container(
              height: MediaQuery.of(context).size.height * .09,
              child: Center(
                child: Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 3,
                ),
              ),
            ),
            Container(
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xff3A559F),
                ),
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .4,
                child: Center(
                  child: Text(
                    "Login/ Signup",
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.4,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, top: 5),
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
                  Container(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black26,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Center(
                          child: Text(
                            "EDIT PROFILE",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.3,
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.menu,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "All My Orders",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black26,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.local_shipping_outlined,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Pending Shipments",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black26,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_business_rounded,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Address Book ",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AddressBookScreen.routeName),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black26,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 10,
                                color: Colors.black45,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Wish list",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black26,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mail_sharp,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Polices and terms",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black26,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.email_rounded,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "About us",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.black26,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 10,
                              color: Colors.black45,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.headset_mic_rounded,
                            size: 30,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Contact us",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.5,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(ContactUsScreen.routeName),
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.black26,
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 10,
                                color: Colors.black45,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
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
