import 'dart:io';

import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  static final routeName = '/contactUs-screen';

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey7 = GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  bool languageValue = false;
  ContactUsModel contactUsModel;
  String contactAddress,
      contactEmail,
      contactPhone,
      contactPostalCode,
      contactFaceBook,
      contactInstagram,
      contactYoutube,
      contactTwitter;
  List<Data> contactList = [];
  int index = 0;

  Future getContactUsData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });
    Future<bool> getLang() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('isArabic');
    }

    languageValue = await getLang();
    final getData = Provider.of<ListViewModel>(context, listen: false);
    await getData
        .fetchContacts(languageValue == false ? 'en' : 'ar')
        .then((response) {
      contactUsModel = response;
      contactList = contactUsModel.data;

      contactAddress = contactList[index]?.address;
      contactPhone = contactList[index]?.phone;
      contactEmail = contactList[index]?.email;
      contactPostalCode = contactList[index]?.postalCode;
      //
      contactFaceBook = contactList[index]?.facebook;
      contactYoutube = contactList[index]?.youtube;
      contactInstagram = contactList[index]?.instagram;
      contactTwitter = contactList[index]?.twitter;
      //

      //
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  void initState() {
    Future.microtask(() => getContactUsData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey7,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("", _scaffoldKey7, true),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2,
                        left: SizeConfig.blockSizeHorizontal * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2,
                            left: SizeConfig.blockSizeHorizontal * 2,
                            right: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: "address".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 20
                                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: contactAddress ?? "",
                                    style: TextStyle(
                                        // fontSize: 18,
                                        fontSize:
                                            SizeConfig.safeBlockHorizontal * 5,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: [
                              Text(
                                "phone".tr(),
                                // textScaleFactor:
                                //     MediaQuery.textScaleFactorOf(context) * 1.5,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                                ),
                              ),
                              Text(
                                contactPhone ?? "",
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                                ),
                                // textScaleFactor:
                                //     MediaQuery.textScaleFactorOf(context) * 1.3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: [
                              Text(
                                "email".tr(),
                                // textScaleFactor:
                                //     MediaQuery.textScaleFactorOf(context) * 1.5,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                                ),
                              ),
                              Text(
                                contactEmail ?? "",
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockHorizontal * 5,
                                ),
                                // textScaleFactor:
                                //     MediaQuery.textScaleFactorOf(context) * 1.3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 4,
                              right: SizeConfig.blockSizeHorizontal * 2,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            "leave_comment".tr(),
                            // textScaleFactor:
                            //     MediaQuery.textScaleFactorOf(context) * 1.5,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2,
                              right: SizeConfig.blockSizeHorizontal * 6,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "your_name".tr(),
                              hintStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 2,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child:
                              Divider(height: SizeConfig.blockSizeVertical * 1),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              right: SizeConfig.blockSizeHorizontal * 6,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "your_email".tr(),
                              hintStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              right: SizeConfig.blockSizeHorizontal * 6,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "your_message".tr(),
                              hintStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                              ),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       left: SizeConfig.blockSizeHorizontal * 2,
                        //       top: SizeConfig.blockSizeVertical * 2,
                        //       right: SizeConfig.blockSizeHorizontal * 2),
                        //   child:
                        //       Divider(height: SizeConfig.blockSizeVertical * 1),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2,
                          ),
                          child: Center(
                            child: Text(
                              "social_links".tr(),
                              // textScaleFactor:
                              //     MediaQuery.textScaleFactorOf(context) * 1.8,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.safeBlockHorizontal * 6,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              child: GestureDetector(
                                onTap: () {
                                  launchURL(contactFaceBook);
                                },
                                child: Image.asset(
                                  "assets/images/facebook.png",
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeVertical * 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              child: GestureDetector(
                                onTap: () {
                                  launchURL(contactYoutube);
                                },
                                child: Image.asset(
                                  "assets/images/youtube.png",
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  height: SizeConfig.blockSizeVertical * 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              child: GestureDetector(
                                onTap: () {
                                  launchURL(contactInstagram);
                                },
                                child: Image.asset(
                                  "assets/images/instgram.jpg",
                                  width: SizeConfig.blockSizeHorizontal * 10,
                                  height: SizeConfig.blockSizeVertical * 10,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: SizeConfig.blockSizeHorizontal * 2),
                              child: GestureDetector(
                                onTap: () {
                                  launchURL(contactTwitter);
                                },
                                child: Image.asset(
                                  "assets/images/twitter.png",
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  height: SizeConfig.blockSizeVertical * 15,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              bottom: SizeConfig.blockSizeHorizontal * 5,
                              right: SizeConfig.blockSizeHorizontal * 2),
                          child: Center(
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 90,
                              height: SizeConfig.blockSizeVertical * 7,
                              decoration: BoxDecoration(
                                  color: Color(0xff3A559F),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                child: Text(
                                  "send_comment".tr(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      // fontSize: 15,
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 5,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
