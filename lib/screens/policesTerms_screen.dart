import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/model/policesTermsModel.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';

class PolicesTermsScreen extends StatefulWidget {
  static final routeName = '/policesTerms-screen';

  @override
  _PolicesTermsScreenState createState() => _PolicesTermsScreenState();
}

class _PolicesTermsScreenState extends State<PolicesTermsScreen> {
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientAppBar("Policy And Privacy"),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Text(
                      _details ?? "",
                      textScaleFactor:
                          MediaQuery.textScaleFactorOf(context) * 2,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
