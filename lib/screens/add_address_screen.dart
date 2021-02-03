import 'package:cizaro_app/model/createAdressModel.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:cizaro_app/model/countries.dart' as country;

class AddAddressScreen extends StatefulWidget {
  static final routeName = '/add-address-screen';

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  var _currentItemSelectedCountries, _currentItemSelectedCities;
  final _streetController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  TextEditingController _regionController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _streetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("Add New Address"),
            FutureBuilder(
                future: Provider.of<ListViewModel>(context, listen: false)
                    .fetchCountries('c4ce7da269c80455720be2c26c984d8828b88c5f'),
                builder: (BuildContext context,
                    AsyncSnapshot<List<country.Data>> snapshot) {
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              iconSize: 35,
                              iconEnabledColor: Colors.black,
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              isExpanded: true,
                              hint: Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 12),
                                child: Text('Country',
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true),
                              items: snapshot.data?.map((country.Data data) {
                                    return DropdownMenuItem(
                                      value: data.id,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, left: 12),
                                        child: Text(data.name),
                                      ),
                                    );
                                  })?.toList() ??
                                  null,
                              onChanged: (newValueSelected) {
                                setState(() => _currentItemSelectedCountries =
                                    newValueSelected);
                              },
                              value: _currentItemSelectedCountries),
                        ),
                      ),
                    );
                }),
            FutureBuilder(
                future: Provider.of<ListViewModel>(context, listen: false)
                    .fetchCountries('c4ce7da269c80455720be2c26c984d8828b88c5f'),
                builder: (BuildContext context,
                    AsyncSnapshot<List<country.Data>> snapshot) {
                  if (snapshot.hasError)
                    return Text(snapshot.error.toString());
                  else
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 5),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.05,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                              iconSize: 35,
                              iconEnabledColor: Colors.black,
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              isExpanded: true,
                              hint: Padding(
                                padding:
                                    const EdgeInsets.only(right: 12, left: 12),
                                child: Text('City',
                                    style:
                                        const TextStyle(color: Colors.black)),
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  isDense: true),
                              items: snapshot.data[0]?.cities
                                      ?.map((country.Cities data) {
                                    return DropdownMenuItem(
                                      value: data.id,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 12, left: 12),
                                        child: Text(data.name),
                                      ),
                                    );
                                  })?.toList() ??
                                  null,
                              onChanged: (newValueSelected) {
                                setState(() => _currentItemSelectedCities =
                                    newValueSelected);
                              },
                              value: _currentItemSelectedCities),
                        ),
                      ),
                    );
                }),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 5),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.text,
                  lineCount: 1,
                  hintText: "Street",
                  textEditingController: _streetController),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.number,
                  lineCount: 1,
                  hintText: "Zip-Code",
                  textEditingController: _zipCodeController),
              // TextFieldBuild(
              //   textInputType: TextInputType.number,
              //   textEditingController: _zipCodeController,
              //   // decoration: InputDecoration(
              //   //   hintText: "Zip Code",
              //   //   hintStyle: const TextStyle(color: Colors.black),
              //   //   border: OutlineInputBorder(borderSide: BorderSide()),
              //   // ),
              //   // onClick: (value) {
              //   //   setState(() {
              //   //     _zipCodeController.text = value;
              //   //   });
              //   // },
              // )
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.text,
                  lineCount: 1,
                  hintText: "Region",
                  textEditingController: _regionController),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: TextFieldBuild(
                  obscureText: false,
                  readOnly: false,
                  textInputType: TextInputType.number,
                  lineCount: 1,
                  hintText: "Phone Number",
                  textEditingController: _phoneController),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 20),
                  width: MediaQuery.of(context).size.width * .16,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                      color: Color(0xff3A559F),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: GestureDetector(
                    onTap: () async {
                      final data = CreateAddress(
                          country: _currentItemSelectedCountries,
                          city: _currentItemSelectedCities,
                          streetAddress: _streetController?.text,
                          phone: _phoneController?.text,
                          region: _regionController?.text,
                          zipCode: _zipCodeController?.text);
                      final getData =
                          Provider.of<ListViewModel>(context, listen: false);
                      await getData.fetchAddress(
                          data, "c4ce7da269c80455720be2c26c984d8828b88c5f");
                    },
                    child: Container(
                      margin: new EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          "ADD",
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
          ],
        ),
      ),
    );
  }
}
