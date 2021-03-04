import 'dart:io';

import 'package:cizaro_app/model/changePasswordModel.dart';
import 'package:cizaro_app/model/profileEditModel.dart' as Edit;
import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditScreen extends StatefulWidget {
  static final routeName = '/profileEdit-screen';
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  bool _isLoading = false;
  ProfileModel profile;
  String userName, userEmail, userFullName, userBirthDate;
  Gender userGender;
  FToast fToast;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Edit.ProfileEditingModel profileEditingModel;
  var valueGender;

  List<Gender> genderList = [];

  String valueUserName,
      valueFullName,
      valueEmail,
      valueConfirmPassword,
      valuePassword;

  TextEditingController valueBirthDate = TextEditingController();

  getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('customer_id');
  }

  Future getProfileData() async {
    if (this.mounted)
      setState(() {
        _isLoading = true;
      });

    String token = await getToken();
    int userId = await getId();

    final getProfile = Provider.of<ListViewModel>(context, listen: false);
    await getProfile.fetchProfile(userId, token).then((response) {
      profile = response;
      userName = profile.data.fullName;
      userEmail = profile.data.email;
      userBirthDate = profile.data.birthDate;
      userGender = profile.data.gender;
      userFullName = profile.data.fullName;

      //  profileList = response.data;
    });
    if (this.mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  showPasswordChangeToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Your Password Changed .!",
              style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showConfirmToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Password Not matching !",
              style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showUpdatedToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Color(0xff3A559F),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text("Your Personal Data Updated",
              style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future changePassword() async {
    if (this.mounted) setState(() => _isLoading = true);
    final changeProfilePassword =
        Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    final changePasswordModel = ChangePasswordModel(
        newPassword1: valuePassword, newPassword2: valueConfirmPassword);
    await changeProfilePassword
        .changePassword(changePasswordModel, token)
        .then((response) {});
    showPasswordChangeToast();
    if (this.mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future editProfile() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getProfile = Provider.of<ListViewModel>(context, listen: false);
    String token = await getToken();
    int id = await getId();
    // final Map arguments = ModalRoute.of(context).settings.arguments as Map;

    final profileEditingModel = Edit.ProfileEditingModel(
        username: valueUserName ?? userName,
        fullName: valueFullName ?? userFullName,
        email: valueEmail ?? userEmail,
        //   gender: valueGender ?? userGender.value,
        birthDate: valueBirthDate.text ?? userBirthDate);
    await getProfile
        .updateProfile(id, profileEditingModel, token)
        .then((response) {});
    showUpdatedToast();
    if (this.mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void initState() {
    Future.microtask(() => getProfileData());
    super.initState(); // de 3ashan awel lama aload el screen t7mel el data
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        child: GradientAppBar("Profile Editing", _scaffoldKey),
        preferredSize: const Size(double.infinity, kToolbarHeight),
      ),
      body: _isLoading
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 1,
                        left: SizeConfig.blockSizeHorizontal * 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Text(
                            "YOUR PERSONAL DATA",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 5),
                          child: Text(
                            "User Name :",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              top: SizeConfig.blockSizeVertical * 1),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_circle,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                height: SizeConfig.blockSizeVertical * 05,
                                child: TextField(
                                  obscureText: false,
                                  readOnly: false,
                                  decoration: InputDecoration(
                                    hintText: userName,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      valueUserName = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 5),
                          child: Text(
                            "Full Name :",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_box,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1.5,
                                    top: SizeConfig.blockSizeVertical * 1),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                height: SizeConfig.blockSizeHorizontal * 7,
                                child: TextField(
                                  obscureText: false,
                                  readOnly: false,
                                  decoration: InputDecoration(
                                    hintText: userFullName,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      valueFullName = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 5),
                          child: Text(
                            "Email Address :",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1.5,
                                    top: SizeConfig.blockSizeVertical * 1),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                height: SizeConfig.blockSizeVertical * 7,
                                child: TextField(
                                  obscureText: false,
                                  readOnly: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    hintText: userEmail,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      valueEmail = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 5),
                          child: Text(
                            "Birth Date :",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      left:
                                          SizeConfig.blockSizeHorizontal * 1.5,
                                      top: SizeConfig.blockSizeVertical * 1),
                                  width: SizeConfig.blockSizeHorizontal * 80,
                                  height: SizeConfig.blockSizeVertical * 7,
                                  child: TextFieldBuild(
                                    obscureText: false,
                                    readOnly: true,
                                    hintText: userBirthDate,
                                    textStyle: TextStyle(
                                      fontSize:
                                          SizeConfig.safeBlockHorizontal * 3.2,
                                    ),
                                    lineCount: 1,
                                    // validator: validateBirthDate,
                                    textEditingController: valueBirthDate,
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
                                                        valueBirthDate.text =
                                                            '${newDate.year}-${newDate.month}-${newDate.day}',
                                                    use24hFormat: true,
                                                    minuteInterval: 1,
                                                    mode:
                                                        CupertinoDatePickerMode
                                                            .date));
                                          });
                                    },
                                  )
                                  // TextField(
                                  //   obscureText: false,
                                  //   readOnly: false,
                                  //   keyboardType: TextInputType.datetime,
                                  //   decoration: InputDecoration(
                                  //     hintText: userBirthDate,
                                  //   ),
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       valueBirthDate = value;
                                  //     });
                                  //   },
                                  // ),
                                  )
                            ],
                          ),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(top: 10, left: 50),
                        //   child: Text(
                        //     "Gender :",
                        //     textScaleFactor:
                        //         MediaQuery.of(context).textScaleFactor * 1,
                        //   ),
                        // ),
                        // Container(
                        //   padding: EdgeInsets.only(left: 10),
                        //   child: Row(
                        //     children: [
                        //       Icon(
                        //         Icons.hail,
                        //         size: 30,
                        //         color: Colors.grey,
                        //       ),
                        //       Container(
                        //         padding: EdgeInsets.only(left: 10),
                        //         child: Row(
                        //           children: [
                        //             Container(
                        //               height: MediaQuery.of(context).size.height * .1,
                        //               width: MediaQuery.of(context).size.width * .5,
                        //               padding: EdgeInsets.only(left: 10, right: 40),
                        //               child: DropdownButton(
                        //                 hint: Text(userGender?.value ?? ""),
                        //                 value: valueGender,
                        //                 dropdownColor: Colors.grey,
                        //                 items: genderList.map((e) {
                        //                   return DropdownMenuItem(
                        //                     child: Text(e.value),
                        //                     value: e.key,
                        //                   );
                        //                 })
                        //                     // return DropdownMenuItem(value: e, child: Text(e));
                        //
                        //                     .toList(),
                        //                 onChanged: (value) {
                        //                   setState(() {
                        //                     valueGender = value;
                        //                   });
                        //                 },
                        //                 isExpanded: true,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          padding: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 3,
                              top: SizeConfig.blockSizeVertical * 2),
                          child: Row(
                            children: [
                              SizedBox(),
                              Spacer(),
                              GestureDetector(
                                onTap: () => editProfile(),
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: SizeConfig.blockSizeHorizontal * 3,
                                      left: SizeConfig.blockSizeHorizontal * 2),
                                  width: SizeConfig.blockSizeHorizontal * 30,
                                  height: SizeConfig.blockSizeVertical * 6,
                                  decoration: BoxDecoration(
                                      color: Color(0xff3A559F),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left:
                                                SizeConfig.blockSizeHorizontal *
                                                    1.5),
                                        child: Text(
                                          "Update",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: SizeConfig
                                                      .safeBlockHorizontal *
                                                  4,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      CircleAvatar(
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Color(0xff3A559F)))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: SizeConfig.blockSizeVertical * 1,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1,
                              top: SizeConfig.blockSizeVertical * 1),
                          height: SizeConfig.blockSizeVertical * 5,
                          width: SizeConfig.blockSizeHorizontal * 100,
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Text(
                            "PASSWORD",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            " Password :",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1.5,
                                    top: SizeConfig.blockSizeVertical * 1),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                height: SizeConfig.blockSizeVertical * 7,
                                child: TextField(
                                  obscureText: true,
                                  readOnly: false,
                                  onChanged: (value) {
                                    setState(() {
                                      valuePassword = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              left: SizeConfig.blockSizeHorizontal * 2),
                          child: Text(
                            "Confirm Password :",
                            style: TextStyle(
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                            ),
                            textScaleFactor:
                                MediaQuery.of(context).textScaleFactor * 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 1),
                          child: Row(
                            children: [
                              Icon(
                                Icons.lock_outline,
                                size: 30,
                                color: Colors.grey,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 1.5,
                                    top: SizeConfig.blockSizeVertical * 1),
                                width: SizeConfig.blockSizeHorizontal * 80,
                                height: SizeConfig.blockSizeVertical * 7,
                                child: TextField(
                                  obscureText: true,
                                  readOnly: false,
                                  onChanged: (value) {
                                    setState(() {
                                      valueConfirmPassword = value;
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              top: SizeConfig.blockSizeVertical * 1,
                              right: SizeConfig.blockSizeHorizontal * 3,
                              bottom: SizeConfig.blockSizeVertical * 2),
                          child: Row(
                            children: [
                              SizedBox(),
                              Spacer(),
                              GestureDetector(
                                onTap: () => {
                                  valuePassword == valueConfirmPassword
                                      ? changePassword()
                                      : showConfirmToast()
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 40,
                                  height: SizeConfig.blockSizeHorizontal * 10,
                                  margin: EdgeInsets.only(
                                      top: SizeConfig.blockSizeVertical * .8),
                                  decoration: BoxDecoration(
                                      color: Color(0xff3A559F),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        "Change Password",
                                        textScaleFactor: MediaQuery.of(context)
                                                .textScaleFactor *
                                            1,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                SizeConfig.safeBlockHorizontal *
                                                    3,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      CircleAvatar(
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                          backgroundColor: Colors.white,
                                          child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: SizeConfig
                                                      .blockSizeHorizontal *
                                                  4,
                                              color: Color(0xff3A559F)))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
