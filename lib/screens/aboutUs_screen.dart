import 'package:cizaro_app/model/aboutUsModel.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';

class AboutUsScreen extends StatefulWidget {
  static final routeName = '/aboutUs-screen';

  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool _isLoading = false;
  AboutUsModel aboutUsModel;
  String _details;

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientAppBar("About Us"),
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
