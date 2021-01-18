import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CollectionItem extends StatelessWidget {
  final String itemText, imgUrl;
  final int id;
  const CollectionItem({this.id, this.itemText, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Card(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * .2,
          padding: EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                imgUrl,
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .2,
                fit: BoxFit.contain,
              ),
              Container(
                padding: EdgeInsets.only(top: 10, right: 10),
                child: Text(
                  itemText,
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
