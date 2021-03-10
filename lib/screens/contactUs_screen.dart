import 'dart:io';

import 'package:cizaro_app/model/contactUsModel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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

    final getData = Provider.of<ListViewModel>(context, listen: false);
    await getData.fetchContacts().then((response) {
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
                        // Text(
                        //   "username of logged in user",
                        //   // textScaleFactor:
                        //   //     MediaQuery.textScaleFactorOf(context) * 1.5,
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: SizeConfig.safeBlockHorizontal * 5,
                        //   ),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //     top: SizeConfig.blockSizeVertical * 2,
                        //   ),
                        //   child: Text(
                        //     "Email of logged in user",
                        //     style: TextStyle(
                        //       // fontWeight: FontWeight.bold,
                        //       fontSize: SizeConfig.safeBlockHorizontal * 5,
                        //     ),
                        //     // textScaleFactor:
                        //     //     MediaQuery.textScaleFactorOf(context) * 1.5,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 2,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: RichText(
                            text: TextSpan(
                              text: "Address:   ",
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
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: [
                              Text(
                                "Phone:   ",
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
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Row(
                            children: [
                              Text(
                                "Email:   ",
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
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            "Leave A Comment : ",
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
                              hintText: "Your Name",
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
                              hintText: "Your Email",
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
                              hintText: "Your Message",
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
                              "Social Links ",
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
                                  "Send Comment",
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
