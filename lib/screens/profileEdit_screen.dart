import 'package:cizaro_app/model/profileEditModel.dart' as Edit;
import 'package:cizaro_app/model/profileModel.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
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

  Edit.ProfileEditingModel profileEditingModel;
  var valueGender;

  List<Gender> genderList = [];

  String valueUserName,
      valueFullName,
      valueEmail,
      valueBirthDate,
      valueCurrentPassword,
      valuePassword;

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
        birthDate: valueBirthDate ?? userBirthDate);
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            GradientAppBar("Profile Editing"),
            Container(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * .05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                      "YOUR PERSONAL DATA",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "User Name :",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.05,
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
                    padding: EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "Full Name :",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_box,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.07,
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
                    padding: EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "Email Address :",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.07,
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
                    padding: EdgeInsets.only(top: 10, left: 50),
                    child: Text(
                      "Birth Date :",
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
                          padding: EdgeInsets.only(left: 15, top: 10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: TextField(
                            obscureText: false,
                            readOnly: false,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                              hintText: userBirthDate,
                            ),
                            onChanged: (value) {
                              setState(() {
                                valueBirthDate = value;
                              });
                            },
                          ),
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
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        SizedBox(),
                        Spacer(),
                        GestureDetector(
                          onTap: () => editProfile(),
                          child: Container(
                            padding: EdgeInsets.only(right: 10),
                            width: MediaQuery.of(context).size.width * .3,
                            height: MediaQuery.of(context).size.height * .06,
                            decoration: BoxDecoration(
                                color: Color(0xff3A559F),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    "Update",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.arrow_forward_ios_rounded,
                                        size: 15, color: Color(0xff3A559F)))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    height: MediaQuery.of(context).size.height * .05,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Text(
                      "PASSWORD",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "Current Password :",
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
                          padding: EdgeInsets.only(left: 15, top: 10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: TextField(
                            obscureText: true,
                            readOnly: false,
                            onChanged: (value) {
                              setState(() {
                                valueCurrentPassword = value;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 20),
                    child: Text(
                      "Password :",
                      textScaleFactor:
                          MediaQuery.of(context).textScaleFactor * 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 30,
                          color: Colors.grey,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, top: 10),
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.07,
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
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 10, bottom: 20),
                    child: Row(
                      children: [
                        SizedBox(),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          width: MediaQuery.of(context).size.width * .5,
                          height: MediaQuery.of(context).size.height * .06,
                          decoration: BoxDecoration(
                              color: Color(0xff3A559F),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  "Update Password",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.arrow_forward_ios_rounded,
                                      size: 15, color: Color(0xff3A559F)))
                            ],
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
