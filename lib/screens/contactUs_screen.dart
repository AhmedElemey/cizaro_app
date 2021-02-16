import 'package:cizaro_app/model/contactUsModel.dart';
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
        child: GradientAppBar("", _scaffoldKey7),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "username of logged in user",
                          textScaleFactor:
                              MediaQuery.textScaleFactorOf(context) * 1.5,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            "Email of logged in user",
                            textScaleFactor:
                                MediaQuery.textScaleFactorOf(context) * 1.5,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: RichText(
                            text: TextSpan(
                              text: "Address:   ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: contactAddress ?? "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black38))
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Text(
                                "Phone:   ",
                                textScaleFactor:
                                    MediaQuery.textScaleFactorOf(context) * 1.5,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                contactPhone ?? "",
                                textScaleFactor:
                                    MediaQuery.textScaleFactorOf(context) * 1.3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(
                            children: [
                              Text(
                                "Email:   ",
                                textScaleFactor:
                                    MediaQuery.textScaleFactorOf(context) * 1.5,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                contactEmail ?? "",
                                textScaleFactor:
                                    MediaQuery.textScaleFactorOf(context) * 1.3,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Leave A Comment ",
                            textScaleFactor:
                                MediaQuery.textScaleFactorOf(context) * 1.5,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(hintText: "Your Name"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Divider(
                              height: MediaQuery.of(context).size.height * .01),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(hintText: "Your Email"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            decoration:
                                InputDecoration(hintText: "Your Message"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Divider(
                              height: MediaQuery.of(context).size.height * .01),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Center(
                            child: Text(
                              "Social Links ",
                              textScaleFactor:
                                  MediaQuery.textScaleFactorOf(context) * 1.8,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 100, right: 30),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    launchURL(contactFaceBook);
                                  },
                                  child: Image.asset(
                                    "assets/images/facebook.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.09,
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    launchURL(contactYoutube);
                                  },
                                  child: Image.asset(
                                    "assets/images/youtube.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    launchURL(contactInstagram);
                                  },
                                  child: Image.asset(
                                      "assets/images/instgram.jpg",
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.09),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    launchURL(contactTwitter);
                                  },
                                  child: Image.asset(
                                    "assets/images/twitter.png",
                                    width: MediaQuery.of(context).size.width *
                                        0.13,
                                    height: MediaQuery.of(context).size.height *
                                        0.13,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 50, right: 10),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * .9,
                              height: MediaQuery.of(context).size.height * .07,
                              decoration: BoxDecoration(
                                  color: Color(0xff3A559F),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: Center(
                                child: Text(
                                  "Send Comment",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
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
