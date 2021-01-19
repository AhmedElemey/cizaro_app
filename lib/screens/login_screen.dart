import 'dart:io';

import 'package:cizaro_app/model/home.dart';
import 'package:cizaro_app/screens/addressbook_screen.dart';
import 'package:cizaro_app/screens/checkout_screen.dart';
import 'package:cizaro_app/screens/favorite_screen.dart';
import 'package:cizaro_app/screens/home_screen.dart';
import 'package:cizaro_app/screens/mycart_screen.dart';

import 'package:cizaro_app/screens/profile_screen.dart';
import 'package:cizaro_app/screens/shop_screen.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static final routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  var _currentItemSelectedGender;
  String birthDate;
  TextEditingController _emailLoginController = TextEditingController();
  TextEditingController _emailSignUpController = TextEditingController();
  TextEditingController _passwordLoginController = TextEditingController();
  TextEditingController _passwordSignUpController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _birthDateController = TextEditingController();
  TextEditingController _genderNameController = TextEditingController();

  Widget tabsWidgets() {
    return DefaultTabController(
      length: 2,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                bottom: TabBar(
                  labelPadding:
                      const EdgeInsets.only(right: 60, left: 60, bottom: 15),
                  indicatorWeight: 4,
                  indicatorColor: Color(0xff294794),
                  labelColor: Color(0xff294794),
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  tabs: <Widget>[
                    Text('Login',
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1.4,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text('SignUp',
                        textScaleFactor:
                            MediaQuery.of(context).textScaleFactor * 1.4,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                _isLoading
                    ? Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator()
                            : CircularProgressIndicator())
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              TextFieldBuild(
                                  obscureText: false,
                                  readOnly: false,
                                  textInputType: TextInputType.emailAddress,
                                  hintText: 'Email Address',
                                  lineCount: 1,
                                  textEditingController: _emailLoginController),
                              const SizedBox(height: 10),
                              TextFieldBuild(
                                  obscureText: true,
                                  readOnly: false,
                                  textInputType: TextInputType.visiblePassword,
                                  hintText: 'Password',
                                  lineCount: 1,
                                  textEditingController:
                                      _passwordLoginController,
                                  icon: CupertinoIcons.eye),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: CupertinoButton(
                                      color: Theme.of(context).primaryColor,
                                      child: Text('Login'),
                                      onPressed: () => Navigator.of(context)
                                          .pushNamed(HomeScreen.routeName))),
                              const SizedBox(height: 10),
                              Text('Forgot your password?',
                                  textScaleFactor:
                                      MediaQuery.of(context).textScaleFactor *
                                          1.1),
                              Divider(
                                  thickness: 0.8,
                                  color: Colors.grey,
                                  indent:
                                      MediaQuery.of(context).size.width * 0.07,
                                  endIndent:
                                      MediaQuery.of(context).size.width * 0.07),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/google.png'),
                                        const SizedBox(width: 25),
                                        Text('Login with Google',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    1.3,
                                            style: const TextStyle(
                                                color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff3A559F)),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/face.png'),
                                        const SizedBox(width: 25),
                                        Text('Login with Facebook',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    1.3,
                                            style: const TextStyle(
                                                color: Color(0xff3A559F)))
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                _isLoading
                    ? Center(
                        child: Platform.isIOS
                            ? CupertinoActivityIndicator()
                            : CircularProgressIndicator())
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 40),
                              TextFieldBuild(
                                  obscureText: false,
                                  readOnly: false,
                                  textInputType: TextInputType.emailAddress,
                                  hintText: 'Email Address',
                                  lineCount: 1,
                                  textEditingController:
                                      _emailSignUpController),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextFieldBuild(
                                        obscureText: false,
                                        readOnly: false,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        hintText: 'Full Name',
                                        lineCount: 1,
                                        textEditingController:
                                            _fullNameController),
                                  )),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 10),
                                    child: TextFieldBuild(
                                        obscureText: false,
                                        readOnly: false,
                                        textInputType:
                                            TextInputType.emailAddress,
                                        hintText: 'Username',
                                        lineCount: 1,
                                        textEditingController:
                                            _userNameController),
                                  )),
                                ],
                              ),
                              TextFieldBuild(
                                  obscureText: true,
                                  readOnly: false,
                                  textInputType: TextInputType.visiblePassword,
                                  hintText: 'Password',
                                  lineCount: 1,
                                  textEditingController:
                                      _passwordSignUpController,
                                  icon: CupertinoIcons.eye),
                              TextFieldBuild(
                                  obscureText: true,
                                  readOnly: false,
                                  textInputType: TextInputType.visiblePassword,
                                  hintText: 'Confirm password',
                                  lineCount: 1,
                                  textEditingController:
                                      _confirmPasswordController),
                              Row(
                                children: [
                                  // Expanded(
                                  //     child: Container(
                                  //         width: MediaQuery.of(context)
                                  //                 .size
                                  //                 .width *
                                  //             0.5,
                                  //         height: MediaQuery.of(context)
                                  //                 .size
                                  //                 .height *
                                  //             0.057,
                                  //         margin: const EdgeInsets.only(
                                  //             left: 20, bottom: 10),
                                  //         decoration: BoxDecoration(
                                  //             borderRadius:
                                  //                 BorderRadius.circular(8),
                                  //             border: Border.all(
                                  //                 color: Colors.black54,
                                  //                 width: 1)),
                                  //         child: Center(
                                  //           child: DropdownButtonFormField(
                                  //               iconSize: MediaQuery.of(context).size.width *
                                  //                   0.08,
                                  //               iconEnabledColor:
                                  //                   Colors.black54,
                                  //               style: const TextStyle(
                                  //                   color: Colors.black),
                                  //               isExpanded: true,
                                  //               hint: Padding(
                                  //                   padding: const EdgeInsets.only(
                                  //                       left: 5),
                                  //                   child: Text('Gender',
                                  //                       style: const TextStyle(
                                  //                           color: Colors
                                  //                               .black54))),
                                  //               decoration: InputDecoration(
                                  //                   contentPadding:
                                  //                       EdgeInsets.all(3),
                                  //                   enabledBorder: UnderlineInputBorder(
                                  //                       borderSide: BorderSide(
                                  //                           color:
                                  //                               Colors.white)),
                                  //                   isDense: true),
                                  //               validator: (value) =>
                                  //                   value == null ? 'Choose Gender' : null,
                                  //               items: ['Male', 'Female']
                                  //                   .map((label) => DropdownMenuItem(
                                  //                         child: Padding(
                                  //                           padding:
                                  //                               const EdgeInsets
                                  //                                       .only(
                                  //                                   left: 15),
                                  //                           child: Text(label
                                  //                               .toString()),
                                  //                         ),
                                  //                         value: label,
                                  //                       ))
                                  //                   .toList(),
                                  //               onChanged: (newValueSelected) {
                                  //                 setState(() =>
                                  //                     _currentItemSelectedGender =
                                  //                         newValueSelected);
                                  //                 print(
                                  //                     _currentItemSelectedGender);
                                  //               },
                                  //               value: _currentItemSelectedGender),
                                  //         ))),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: TextFieldBuild(
                                      obscureText: false,
                                      readOnly: true,
                                      hintText: 'Gender',
                                      lineCount: 1,
                                      textEditingController:
                                          _genderNameController,
                                      icon: CupertinoIcons.chevron_down,
                                      onClick: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext builder) {
                                              return Container(
                                                  height: MediaQuery.of(context)
                                                          .copyWith()
                                                          .size
                                                          .height /
                                                      3,
                                                  child: CupertinoPicker(
                                                    onSelectedItemChanged:
                                                        (int index) {
                                                      int indexItem = index + 1;
                                                      indexItem == 1
                                                          ? _genderNameController
                                                              .text = 'Male'
                                                          : _genderNameController
                                                              .text = 'Female';
                                                    },
                                                    itemExtent: 50,
                                                    children: [
                                                      Text('Male'),
                                                      Text('Female'),
                                                    ],
                                                  ));
                                            });
                                      },
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 10),
                                    child: TextFieldBuild(
                                      obscureText: false,
                                      readOnly: true,
                                      hintText: 'Birth Date',
                                      lineCount: 1,
                                      textEditingController:
                                          _birthDateController,
                                      icon: CupertinoIcons.calendar,
                                      onClick: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext builder) {
                                              return Container(
                                                  height: MediaQuery.of(context)
                                                          .copyWith()
                                                          .size
                                                          .height /
                                                      3,
                                                  child: CupertinoDatePicker(
                                                      initialDateTime:
                                                          DateTime.now(),
                                                      onDateTimeChanged: (DateTime
                                                              newDate) =>
                                                          _birthDateController
                                                                  .text =
                                                              '${newDate.year}-${newDate.month}-${newDate.day}',
                                                      use24hFormat: true,
                                                      maximumDate:
                                                          DateTime.now(),
                                                      minuteInterval: 1,
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .date));
                                            });
                                      },
                                    ),
                                  )),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: CupertinoButton(
                                      color: Theme.of(context).primaryColor,
                                      child: Text('SignUp'),
                                      onPressed: () {})),
                              const SizedBox(height: 10),
                              Divider(
                                  thickness: 0.8,
                                  color: Colors.grey,
                                  indent:
                                      MediaQuery.of(context).size.width * 0.07,
                                  endIndent:
                                      MediaQuery.of(context).size.width * 0.07),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/google.png'),
                                        const SizedBox(width: 25),
                                        Text('SignUp with Google',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    1.3,
                                            style: const TextStyle(
                                                color: Colors.white))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => {},
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xff3A559F)),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/images/face.png'),
                                        const SizedBox(width: 25),
                                        Text('SignUp with Facebook',
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    1.3,
                                            style: const TextStyle(
                                                color: Color(0xff3A559F)))
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Image.asset('assets/images/cizaro_logo2.png',
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: MediaQuery.of(context).size.height * 0.23)),
              Text(
                'Welcome',
                textScaleFactor: MediaQuery.of(context).textScaleFactor * 1.7,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              tabsWidgets(),
            ],
          ),
        ),
      ),
    );
  }
}
