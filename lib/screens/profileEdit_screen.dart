import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatefulWidget {
  static final routeName = '/profileEdit-screen';
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController valueUserName = TextEditingController();
  TextEditingController valueFullName = TextEditingController();
  TextEditingController valueEmail = TextEditingController();
  TextEditingController valueBirthDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                Text(
                  "UserName : ",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.04,
                  padding: EdgeInsets.only(left: 10),
                  child: TextFieldBuild(
                      obscureText: false,
                      readOnly: false,
                      textInputType: TextInputType.number,
                      lineCount: 1,
                      textEditingController: valueUserName),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                Text(
                  "Full Name :",
                  textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.2,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: TextFieldBuild(
                      obscureText: false,
                      readOnly: false,
                      lineCount: 1,
                      textInputType: TextInputType.number,
                      textEditingController: valueFullName),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
