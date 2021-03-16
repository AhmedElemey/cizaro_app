import 'dart:io';

import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/screens/aboutUs_screen.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/contactUs_screen.dart';
import 'package:cizaro_app/screens/favorite_screen.dart';
import 'package:cizaro_app/screens/languages_screen.dart';
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
import 'package:easy_localization/easy_localization.dart';
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
  bool languageValue = false;
  Future<bool> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isArabic');
  }

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

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
    if (token == null || userId == null) {
      if (this.mounted) setState(() => _isLoading = false);
      pushNewScreenWithRouteSettings(context,
          settings: RouteSettings(name: LoginScreen.routeName),
          screen: LoginScreen(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.fade);
    }
    final getProfile = Provider.of<ListViewModel>(context, listen: false);
    languageValue = await getLang();
    await getProfile
        .fetchProfile(
            userId,
            token,
            languageValue == null
                ? 'en'
                : languageValue == false
                    ? 'en'
                    : 'ar')
        .then((response) {
      profile = response;
      userName = profile.data.fullName;
      userEmail = profile.data.email;
      userBirthDate = profile.data.birthDate;
      userGender = profile.data.gender;
    }).catchError((error) => print(error));
    if (this.mounted) setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getProfileData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey12,
        drawer: DrawerLayout(),
        appBar: PreferredSize(
          child: GradientAppBar('profile'.tr(), _scaffoldKey12, false),
          preferredSize: const Size(double.infinity, kToolbarHeight),
        ),
        body: _isLoading
            ? Center(
                child: Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * .1,
                      top: SizeConfig.blockSizeVertical * .05,
                      right: SizeConfig.blockSizeHorizontal * .1),
                  width: SizeConfig.blockSizeHorizontal * 100,
                  child: Column(
                    children: [
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
                                      top: SizeConfig.blockSizeVertical * 1,
                                      left: SizeConfig.blockSizeHorizontal * 5,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 5),
                                  child: Text(
                                    userName ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 6,
                                        color: Color(0xff515C6F)),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: SizeConfig.blockSizeVertical * 3,
                                      right:
                                          SizeConfig.blockSizeHorizontal * 5),
                                  child: Text(
                                    userEmail ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 5,
                                        color: Color(0xff515C6F)),
                                  ),
                                ),
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
                                      top: SizeConfig.blockSizeVertical * 1,
                                      right: SizeConfig.blockSizeHorizontal * 4,
                                      left: SizeConfig.blockSizeHorizontal * 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Color(0xff3A559F),
                                    ),
                                    height: SizeConfig.blockSizeVertical * 5,
                                    width: SizeConfig.blockSizeHorizontal * 35,
                                    child: Center(
                                      child: Text(
                                        'edit_profile'.tr(),
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
                          top: SizeConfig.blockSizeVertical * 2,
                          right: SizeConfig.blockSizeHorizontal * 4,
                          left: SizeConfig.blockSizeHorizontal * 4,
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 2,
                                horizontal: SizeConfig.blockSizeHorizontal * 1),
                            decoration: BoxDecoration(
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
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 4,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3),
                                    child: Row(
                                      children: [
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
                                                  5,
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          child: Text(
                                            'all_orders'.tr(),
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      left: SizeConfig.blockSizeHorizontal * 14,
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
                                          name:
                                              PendingShipmentScreen.routeName),
                                      screen: PendingShipmentScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left: SizeConfig.blockSizeHorizontal *
                                            2.5,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/pending shipments.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  1,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      4,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          child: Text(
                                            'pending_shipment'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      left: SizeConfig.blockSizeHorizontal * 14,
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
                                          name: AddressBookScreen.routeName),
                                      screen: AddressBookScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 3,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 4),
                                    child: Row(
                                      children: [
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
                                                right: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5,
                                                left: SizeConfig
                                                        .blockSizeHorizontal *
                                                    5),
                                            child: Text(
                                              'address_book'.tr(),
                                              style: TextStyle(
                                                fontSize: SizeConfig
                                                        .safeBlockHorizontal *
                                                    5,
                                              ),
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
                            padding: EdgeInsets.symmetric(
                                vertical: SizeConfig.blockSizeVertical * 2,
                                horizontal:
                                    SizeConfig.blockSizeHorizontal * 2.3),
                            decoration: BoxDecoration(
                              // border:
                              //     Border.all(color: Colors.black12, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: FavoriteScreen.routeName),
                                      screen: FavoriteScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * .05,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/rate.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.6,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      3.6,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          child: Text(
                                            'wish_list'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * .5),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: PolicesTermsScreen.routeName),
                                      screen: PolicesTermsScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/suggest.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.6,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      3.6,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          child: Text(
                                            'polices_terms'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * .5),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: AboutUsScreen.routeName),
                                      screen: AboutUsScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/aboutUs.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.6,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      3.6,
                                              color: Colors.grey[900]),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          child: Text(
                                            'about_us'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                GestureDetector(
                                  onTap: () => pushNewScreenWithRouteSettings(
                                      context,
                                      settings: RouteSettings(
                                          name: ContactUsScreen.routeName),
                                      screen: ContactUsScreen(),
                                      withNavBar: true,
                                      pageTransitionAnimation:
                                          PageTransitionAnimation.fade),
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * .5,
                                        left:
                                            SizeConfig.blockSizeHorizontal * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: SvgPicture.asset(
                                              'assets/images/support.svg',
                                              width: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3.6,
                                              height:
                                                  SizeConfig.blockSizeVertical *
                                                      3.6,
                                              color: Colors.black),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  5),
                                          child: Text(
                                            'contact_us'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    pushNewScreenWithRouteSettings(context,
                                        settings: RouteSettings(
                                            name: ChangeLanguagesScreen
                                                .routeName),
                                        screen: ChangeLanguagesScreen(),
                                        withNavBar: true,
                                        pageTransitionAnimation:
                                            PageTransitionAnimation.fade)
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * .5,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.language,
                                            size:
                                                SizeConfig.safeBlockHorizontal *
                                                    8,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4),
                                          child: Text(
                                            'change_language'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  child: Divider(
                                      height: SizeConfig.blockSizeVertical * 1,
                                      color: Color(0xff727C8E)),
                                ),
                                GestureDetector(
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
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.blockSizeVertical * 1,
                                        right:
                                            SizeConfig.blockSizeHorizontal * 2),
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
                                              right: SizeConfig
                                                      .blockSizeHorizontal *
                                                  3,
                                              left: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4),
                                          child: Text(
                                            'sign_out'.tr(),
                                            style: TextStyle(
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  5,
                                            ),
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
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      )
                    ],
                  ),
                ),
              ])));
  }
}
