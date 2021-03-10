import 'dart:io';

import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUsScreen extends StatefulWidget {
  static final routeName = '/aboutUs-screen';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool _isLoading = false;
  AboutUsModel aboutUsModel;
  String _details;
  final GlobalKey<ScaffoldState> _scaffoldKey2 = GlobalKey<ScaffoldState>();

  Future getAboutUsData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    final getData = Provider.of<ListViewModel>(context, listen: false);
    await getData.fetchAboutUs().then((response) {
      aboutUsModel = response;
      _details = aboutUsModel.data.details;
      //
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  void initState() {
    Future.microtask(() => getAboutUsData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey2,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("About Us", _scaffoldKey2, true),
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
                        top: SizeConfig.blockSizeVertical * 1,
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Text(
                      _details ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.safeBlockHorizontal * 4),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
