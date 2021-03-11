import 'package:cizaro_app/size_config.dart';
import 'package:easy_localization/easy_localization.dart';
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
          height: SizeConfig.blockSizeVertical * 20,
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 2,
              right: SizeConfig.blockSizeHorizontal * 4,
              top: SizeConfig.blockSizeVertical * .25),
          color: bgColor,
          child: Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 3),
                  width: SizeConfig.blockSizeHorizontal * 30,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strName,
                        // style: TextStyle(fontWeight: FontWeight.bold),
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            color: Color(0xff515C6F)),
                        // textScaleFactor:
                        //     MediaQuery.of(context).textScaleFactor * 1.3,
                      ),
                      Text(
                        strNumber,
                        // textScaleFactor:
                        //     MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            color: Color(0xff515C6F)),
                      ),
                      Text(
                        strMain,
                        // textScaleFactor:
                        //     MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            color: Color(0xff515C6F)),
                      ),
                      Text(
                        cityName,
                        // textScaleFactor:
                        //     MediaQuery.of(context).textScaleFactor * 1,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                            color: Color(0xff515C6F)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * .25),
                        child: Text(
                          countryName,
                          // textScaleFactor:
                          //     MediaQuery.of(context).textScaleFactor * 1,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                              color: Color(0xff515C6F)),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 1),
              child: GestureDetector(
                  onTap: () => onEdit(),
                  child: Text(
                    'edit'.tr(),
                    // style: TextStyle(color: Color(0xff3A559F)),
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.safeBlockHorizontal * 5,
                        color: Color(0xff3A559F)),
                    // textScaleFactor:
                    //     MediaQuery.of(context).textScaleFactor * 1.3
                  )),
            ),
            IconButton(
                icon: Icon(CupertinoIcons.delete_simple),
                color: Colors.red,
                onPressed: () => onDelete()),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 2)
          ]),
        ),
      ),
    );
  }
}
