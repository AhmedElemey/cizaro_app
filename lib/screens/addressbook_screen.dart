import 'package:cizaro_app/widgets/address_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressBookScreen extends StatelessWidget {
  static final routeName = '/addressbook-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            padding: EdgeInsets.only(left: 10),
            child: Image.asset(
              "assets/images/logo.png",
            )),
        title: Center(
          child: Text("Address Book"),
        ),
        actions: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .15,
              padding: EdgeInsets.only(left: 5, top: 15),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Noha Hamza",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 2,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Nohahamza@email.com",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff515C6F)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * .55,
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (ctx, index) => AddressItem(
                        strName: "John Doe",
                        strNumber: "No 123",
                        strMain: "Main Street",
                        cityName: "City Name",
                        countryName: "Country",
                      )),
            ),
            Row(
              children: [
                SizedBox(),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 20, top: 10),
                  width: MediaQuery.of(context).size.width * .16,
                  height: MediaQuery.of(context).size.height * .06,
                  decoration: BoxDecoration(
                      color: Color(0xff3A559F),
                      borderRadius: BorderRadius.circular(20.0)),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
