import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/screens/aboutUs_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/contactUs_screen.dart';
import 'package:cizaro_app/screens/favorite_screen.dart';
import 'package:cizaro_app/screens/policesTerms_screen.dart';
import 'package:cizaro_app/screens/profileEdit_screen.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static final routeName = '/profile-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoading = false;
  ProfileModel profile;
  String userName, userEmail, userBirthDate;
  Gender userGender;
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('customer_id');
  }

  Future getProfileData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    String token = await getToken();
    int userId = await getId();

    final getProfile = Provider.of<ListViewModel>(context, listen: false);
    await getProfile.fetchProfile(userId, token).then((response) {
      profile = response;
      userName = profile.data.fullName;
      userEmail = profile.data.email;
      userBirthDate = profile.data.birthDate;
      userGender = profile.data.gender;

      //  profileList = response.data;
    });
    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
    Future.microtask(() => getProfileData());
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
              padding: EdgeInsets.only(left: 10, top: 5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      userName ?? "",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                  Container(
                    child: Text(
                      userEmail ?? "",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => pushNewScreenWithRouteSettings(context,
                        settings:
                            RouteSettings(name: ProfileEditScreen.routeName),
                        screen: ProfileEditScreen(),
                        withNavBar: true,
                        pageTransitionAnimation: PageTransitionAnimation.fade),
                    child: Container(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xff3A559F),
                        ),
                        height: MediaQuery.of(context).size.height * .05,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Center(
                          child: Text(
                            "EDIT PROFILE",
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1.4,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //     padding: EdgeInsets.only(top: 5, left: 10),
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Colors.black26,
                  //           width: 2,
                  //         ),
                  //         borderRadius: BorderRadius.all(Radius.circular(20)),
                  //       ),
                  //       height: MediaQuery.of(context).size.height * .05,
                  //       width: MediaQuery.of(context).size.width * .4,
                  //       child: Center(
                  //         child: Text(
                  //           "EDIT PROFILE",
                  //           textScaleFactor:
                  //               MediaQuery.of(context).textScaleFactor * 1.3,
                  //           style: TextStyle(
                  //               color: Colors.black38,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       ),
                  //     )),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Divider(
                        height: MediaQuery.of(context).size.height * .01,
                        color: Color(0xff727C8E),
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Divider(
                        height: MediaQuery.of(context).size.height * .01,
                        color: Color(0xff727C8E),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AddressBookScreen.routeName),
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
                      child: GestureDetector(
                        onTap: () => pushNewScreenWithRouteSettings(context,
                            settings:
                                RouteSettings(name: FavoriteScreen.routeName),
                            screen: FavoriteScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade),
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Divider(
                        height: MediaQuery.of(context).size.height * .01,
                        color: Color(0xff727C8E),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => pushNewScreenWithRouteSettings(context,
                            settings: RouteSettings(
                                name: PolicesTermsScreen.routeName),
                            screen: PolicesTermsScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade),
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Divider(
                        height: MediaQuery.of(context).size.height * .01,
                        color: Color(0xff727C8E),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => pushNewScreenWithRouteSettings(context,
                            settings:
                                RouteSettings(name: AboutUsScreen.routeName),
                            screen: AboutUsScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade),
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Divider(
                        height: MediaQuery.of(context).size.height * .01,
                        color: Color(0xff727C8E),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => pushNewScreenWithRouteSettings(context,
                            settings:
                                RouteSettings(name: ContactUsScreen.routeName),
                            screen: ContactUsScreen(),
                            withNavBar: true,
                            pageTransitionAnimation:
                                PageTransitionAnimation.fade),
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
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 5),
                      child: Divider(
                        height: MediaQuery.of(context).size.height * .01,
                        color: Color(0xff727C8E),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                "SignOut",
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
