import 'package:cizaro_app/widgets/collection_item.dart';
import 'package:flutter/material.dart';

class AddressItem extends StatelessWidget {
  final String strName, strNumber, strMain, cityName, countryName;
  const AddressItem(
      {this.strName,
      this.strNumber,
      this.strMain,
      this.cityName,
      this.countryName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          padding: EdgeInsets.only(left: 5, top: 10),
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    children: [
                      Text(
                        strName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1.3,
                      ),
                      Text(
                        strNumber,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                      ),
                      Text(
                        strMain,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                      ),
                      Text(
                        cityName,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                      ),
                      Text(
                        countryName,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                child: Text(
                  "Edit",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 2,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
