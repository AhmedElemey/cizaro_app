import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/model/countries.dart' as country;

class AddAddressScreen extends StatefulWidget {
  static final routeName = '/add-address-screen';

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  var _currentItemSelectedCountries,_currentItemSelectedCities;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Column(
         children: [
           GradientAppBar("Add New Address"),
           FutureBuilder(
               future: Provider.of<ListViewModel>(context, listen: false).fetchCountries('c4ce7da269c80455720be2c26c984d8828b88c5f'),
               builder: (BuildContext context,
                   AsyncSnapshot<List<country.Data>> snapshot) {
                 if (snapshot.hasError)
                   return Text(snapshot.error.toString());
                 else
                   return Padding(
                     padding: const EdgeInsets.only(bottom: 15,top: 5),
                     child: Container(
                       width: MediaQuery.of(context)
                           .size
                           .width *
                           0.7,
                       height: MediaQuery.of(context)
                           .size
                           .height *
                           0.05,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.all(
                               Radius.circular(8))),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButtonFormField(
                             iconSize: 35,
                             iconEnabledColor: Colors.black,
                             dropdownColor: Colors.white,
                             style: const TextStyle(
                                 color: Colors.black),
                             isExpanded: true,
                             hint: Padding(
                               padding: const EdgeInsets.only(
                                   right: 12, left: 12),
                               child: Text('Country',
                                   style: const TextStyle(
                                       color: Colors.black)),
                             ),
                             decoration: InputDecoration(
                                 contentPadding:
                                 EdgeInsets.all(0),
                                 isDense: true),
                             items: snapshot.data
                                 ?.map((country.Data data) {
                               return DropdownMenuItem(
                                 value: data.id,
                                 child: Padding(
                                   padding:
                                   const EdgeInsets
                                       .only(
                                       right: 12,
                                       left: 12),
                                   child: Text(data.name),
                                 ),
                               );
                             })?.toList() ??
                                 null,
                             onChanged: (newValueSelected) {
                               setState(() =>
                               _currentItemSelectedCountries =
                                   newValueSelected);
                             },
                             value:
                             _currentItemSelectedCountries),
                       ),
                     ),
                   );
               }),
           FutureBuilder(
               future: Provider.of<ListViewModel>(context, listen: false).fetchCountries('c4ce7da269c80455720be2c26c984d8828b88c5f'),
               builder: (BuildContext context,
                   AsyncSnapshot<List<country.Data>> snapshot) {
                 if (snapshot.hasError)
                   return Text(snapshot.error.toString());
                 else
                   return Padding(
                     padding: const EdgeInsets.only(bottom: 15,top: 5),
                     child: Container(
                       width: MediaQuery.of(context)
                           .size
                           .width *
                           0.7,
                       height: MediaQuery.of(context)
                           .size
                           .height *
                           0.05,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.all(
                               Radius.circular(8))),
                       child: DropdownButtonHideUnderline(
                         child: DropdownButtonFormField(
                             iconSize: 35,
                             iconEnabledColor: Colors.black,
                             dropdownColor: Colors.white,
                             style: const TextStyle(
                                 color: Colors.black),
                             isExpanded: true,
                             hint: Padding(
                               padding: const EdgeInsets.only(
                                   right: 12, left: 12),
                               child: Text('City',
                                   style: const TextStyle(
                                       color: Colors.black)),
                             ),
                             decoration: InputDecoration(
                                 contentPadding:
                                 EdgeInsets.all(0),
                                 isDense: true),
                             items: snapshot.data
                                 ?.map((country.Data data) {
                               return DropdownMenuItem(
                                 value: data.id,
                                 child: Padding(
                                   padding:
                                   const EdgeInsets
                                       .only(
                                       right: 12,
                                       left: 12),
                                   child: Text(data.name),
                                 ),
                               );
                             })?.toList() ??
                                 null,
                             onChanged: (newValueSelected) {
                               setState(() =>
                               _currentItemSelectedCities =
                                   newValueSelected);
                             },
                             value:
                             _currentItemSelectedCities),
                       ),
                     ),
                   );
               })
         ],
       ),
     ),
    );
  }
}