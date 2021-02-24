import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/screens/aboutUs_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/contactUs_screen.dart';
import 'package:cizaro_app/screens/favorite_screen.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/screens/orders_screen.dart';
import 'package:cizaro_app/screens/pending_shipment_screen.dart';
import 'package:cizaro_app/screens/policesTerms_screen.dart';
import 'package:cizaro_app/screens/profileEdit_screen.dart';
import 'package:cizaro_app/services/auth_service.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey12 = GlobalKey<ScaffoldState>();
  ProfileModel profile;
  String userName, userEmail, userBirthDate;
  Gender userGender;
  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Future<void> _logOut() async {
  //   await FacebookAuth.instance.logOut();
  //   String token = await getFacebookToken();
  //   setState(() {
  //     token = null;
  //   });
  //   Navigator.of(context).pushNamed(LoginScreen.routeName);
  // }

  logOut() {
    gSignIn.signOut();
  }

  getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('customer_id');
  }

  Future getProfileData() async {
    if (this.mounted) setState(() => _isLoading = true);
    String token = await getToken();
    int userId = await getId();
    final getProfile = Provider.of<ListViewModel>(context, listen: false);
    await getProfile.fetchProfile(userId, token).then((response) {
      profile = response;
      userName = profile.data.fullName;
      userEmail = profile.data.email;
      userBirthDate = profile.data.birthDate;
      userGender = profile.data.gender;
    });
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
    Future.microtask(() => getProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey12,
        drawer: DrawerLayout(),
        appBar: PreferredSize(
          child: GradientAppBar("Profile", _scaffoldKey12),
          preferredSize: const Size(double.infinity, kToolbarHeight),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * .1,
                      top: SizeConfig.blockSizeVertical * .05,
                      right: SizeConfig.blockSizeHorizontal * .1),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      // Container(
                      //   height: MediaQuery.of(context).size.height * .09,
                      //   child: Center(
                      //     child: Text(
                      //       "Welcome",
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //       textScaleFactor:
                      //           MediaQuery.of(context).textScaleFactor * 3,
                      //     ),
                      //   ),
                      // ),
                      Container(
                        padding: EdgeInsets.only(
                          left: SizeConfig.blockSizeHorizontal * .1,
                        ),
                        width: SizeConfig.blockSizeHorizontal * 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 2,
                                      left: SizeConfig.blockSizeHorizontal * 5),
                                  child: Text(
                                    userName ?? "",
                                    // textScaleFactor:
                                    //     MediaQuery.of(context).textScaleFactor *
                                    //         2,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 6,
                                        color: Color(0xff515C6F)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeVertical * 3),
                                  child: Text(
                                    userEmail ?? "",
                                    // textScaleFactor:
                                    //     MediaQuery.of(context).textScaleFactor *
                                    //         1.3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 5,
                                        color: Color(0xff515C6F)),
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
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * .15),
                              child: GestureDetector(
                                onTap: () => pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(
                                        name: ProfileEditScreen.routeName),
                                    screen: ProfileEditScreen(),
                                    withNavBar: true,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.fade),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 2,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color(0xff3A559F),
                                    ),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    width: SizeConfig.blockSizeHorizontal * 30,
                                    child: Center(
                                      child: Text(
                                        "Edit Profile",
                                        // textScaleFactor: MediaQuery.of(context)
                                        //         .textScaleFactor *
                                        //     1.4,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3,
                          right: SizeConfig.blockSizeHorizontal * 4,
                          left: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // border: Border.all(
                              //   color: Colors.black12,
                              //   width: 2,
                              // ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: OrderScreen.routeName),
                                      screen: OrderScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3),
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   CupertinoIcons.text_quote,
                                        //   size: 30,
                                        // ),
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/menu.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      3,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4),
                                          child: Text(
                                            "All My Orders",
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 13,
                                      right: SizeConfig.blockSizeHorizontal * 5,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: PendingShipment.routeName),
                                      screen: PendingShipment(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left: SizeConfig.blockSizeHorizontal *
                                            2.5,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 4),
                                    child: Row(
                                      children: [
                                        // Icon(Icons.local_shipping_outlined,
                                        //     size: 30),
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/pending shipments.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      5,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Text(
                                            "Pending Shipments",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 13,
                                      right: SizeConfig.blockSizeHorizontal * 5,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 3,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 4),
                                  child: GestureDetector(
                                    onTap: () => pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: AddressBookScreen.routeName),
                                        screen: AddressBookScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade),
                                    child: Row(
                                      children: [
                                        // Icon(Icons.add_business_rounded,
                                        //     size: 30),
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/finished.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  7,
                                              height: SizeConfig
                                                      .blockSizeHorizontal *
                                                  7,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5),
                                            child: Text(
                                              "Address Book ",
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    5,
                                              ),
                                              // textScaleFactor: MediaQuery
                                              //         .textScaleFactorOf(
                                              //             context) *
                                              //     1.5
                                            )),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3,
                          right: SizeConfig.blockSizeHorizontal * 4,
                          left: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              // border:
                              //     Border.all(color: Colors.black12, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * .05,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: GestureDetector(
                                    onTap: () => pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: FavoriteScreen.routeName),
                                        screen: FavoriteScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade),
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   Icons.star,
                                        //   size: 30,
                                        // ),
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/rate.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      4,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Text(
                                            "Wish list",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 10,
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * .5),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: GestureDetector(
                                    onTap: () => pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: PolicesTermsScreen.routeName),
                                        screen: PolicesTermsScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade),
                                    child: Row(
                                      children: [
                                        // Icon(Icons.mail_sharp, size: 30),
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/suggest.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      4,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Text(
                                            "Polices and terms",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 10,
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * .5),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: GestureDetector(
                                    onTap: () => pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: AboutUsScreen.routeName),
                                        screen: AboutUsScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade),
                                    child: Row(
                                      children: [
                                        // Icon(
                                        //   Icons.email_outlined,
                                        //   size: 30,
                                        // ),
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/aboutUs.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      4,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Text(
                                            "About us",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 10,
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * .5,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: GestureDetector(
                                    onTap: () => pushNewScreenWithRouteSettings(
                                        context,
                                        settings: RouteSettings(
                                            name: ContactUsScreen.routeName),
                                        screen: ContactUsScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade),
                                    child: Row(
                                      children: [
                                        Icon(Icons.headset_mic_rounded,
                                            size:
                                                SizeConfig.blockSizeHorizontal *
                                                    8),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  2),
                                          child: Text(
                                            "Contact us",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeHorizontal * 10,
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * 1,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 2),
                                  child: GestureDetector(
                                    onTap: () async {
                                      saveToken('');
                                      saveId(0);
                                      // _logOut();
                                      logOut();
                                      pushNewScreenWithRouteSettings(context,
                                          settings: RouteSettings(
                                              name: LoginScreen.routeName),
                                          screen: LoginScreen(),
                                          withNavBar: false,
                                          pageTransitionAnimation:
                                              PageTransitionAnimation.fade);
                                    },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  .5),
                                          child: Icon(
                                            Icons.logout,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                    8,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3),
                                          child: Text(
                                            "SignOut",
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
                                            // textScaleFactor:
                                            //     MediaQuery.textScaleFactorOf(
                                            //             context) *
                                            //         1.5
                                          ),
                                        ),
                                        Spacer(),
                                        CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.black12,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Colors.black87),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ])));
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
