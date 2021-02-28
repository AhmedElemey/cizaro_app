import 'dart:io';

import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PolicesTermsScreen extends StatefulWidget {
  static final routeName = '/policesTerms-screen';

  @override
  _PolicesTermsScreenState createState() => _PolicesTermsScreenState();
}

class _PolicesTermsScreenState extends State<PolicesTermsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey11 = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  PolicesTermsModel policesTermsModel;
  String _details;

  Future getPolicyData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    final getData = Provider.of<ListViewModel>(context, listen: false);
    await getData.fetchPolicy().then((response) {
      policesTermsModel = response;
      _details = policesTermsModel.data.details;
      //
    });
    if (this.mounted)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  void initState() {
    Future.microtask(() => getPolicyData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey11,
      drawer: DrawerLayout(),
      appBar: PreferredSize(
        child: GradientAppBar("Policy And Privacy", _scaffoldKey11),
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
                      // textScaleFactor:
                      //     MediaQuery.textScaleFactorOf(context) * 2,
                      style: TextStyle(
                          fontSize: SizeConfig.safeBlockHorizontal * 5,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
