import 'package:cizaro_app/screens/edit_address_screen.dart';
import 'package:cizaro_app/widgets/collection_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class AddressItem extends StatelessWidget {
  final String strName, strNumber, strMain, cityName, countryName;
  final Color bgColor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const AddressItem(
      {this.strName,
      this.strNumber,
      this.strMain,
      this.bgColor,
      this.cityName,
      this.onDelete,
      this.onEdit,
      this.countryName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 4,
        child: Container(
          height: MediaQuery.of(context).size.height * .15,
          padding: EdgeInsets.only(left: 5, top: 5),
          color: bgColor,
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 5, left: 10),
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () => onEdit(),
                  child: Text("Edit",
                      style: TextStyle(color: Color(0xff3A559F)),
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1.3)),
            ),
            IconButton(
                icon: Icon(CupertinoIcons.delete_simple),
                color: Colors.red,
                onPressed: () => onDelete()),
            const SizedBox(width: 5)
          ]),
        ),
      ),
    );
  }
}
