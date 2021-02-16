import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/material.dart';

class PendingShipment extends StatefulWidget {
  static final routeName = '/pending-shipment-screen';
  @override
  _PendingShipmentState createState() => _PendingShipmentState();
}

class _PendingShipmentState extends State<PendingShipment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        child: GradientAppBar("My Pending Shipment", _scaffoldKey),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Text('There is No Orders Yet!',
                    textScaleFactor:
                        MediaQuery.of(context).textScaleFactor * 1.5))
          ],
        ),
      ),
    );
  }
}
