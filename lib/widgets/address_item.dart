import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          height: MediaQuery.of(context).size.height * .2,
          padding: EdgeInsets.only(left: 5, top: 2),
          color: bgColor,
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * .3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strName,
                        // style: TextStyle(fontWeight: FontWeight.bold),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff515C6F)),
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1.3,
                      ),
                      Text(
                        strNumber,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff515C6F)),
                      ),
                      Text(
                        strMain,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff515C6F)),
                      ),
                      Text(
                        cityName,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff515C6F)),
                      ),
                      Text(
                        countryName,
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff515C6F)),
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
                      // style: TextStyle(color: Color(0xff3A559F)),
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Color(0xff3A559F)),
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
