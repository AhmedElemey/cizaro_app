import 'package:cizaro_app/model/checkMailModel.dart';
import 'package:cizaro_app/model/emailModel.dart';
import 'package:cizaro_app/screens/login_screen.dart';
import 'package:cizaro_app/size_config.dart';
import 'package:cizaro_app/view_model/list_view_model.dart';
import 'package:cizaro_app/widgets/drawer_layout.dart';
import 'package:cizaro_app/widgets/gradientAppBar.dart';
import 'package:cizaro_app/widgets/textfield_build.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static final routeName = '/forgetPassword-screen';
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  FToast fToast;
  final GlobalKey<ScaffoldState> _scaffoldKey50 = GlobalKey<ScaffoldState>();
  TextEditingController emailController = TextEditingController();
  bool _isLoading = false;
  CheckMailModel responseStatus;
  String responseMessage;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context); // de 3ashan awel lama aload el screen t7mel el data
  }

  Future resetPassword() async {
    if (this.mounted) setState(() => _isLoading = true);
    final getProfile = Provider.of<ListViewModel>(context, listen: false);
    String email = emailController?.text;
    final emailModel = EmailModel(email: email);
    await getProfile.resetPassword(emailModel).then((response) {
      responseStatus = response;
      responseMessage = responseStatus.message;
      if (responseMessage == "Password reset e-mail has been sent.") {
        showSendMailToast();
      } else {
        showSendErrorToast();
      }
    });

    if (this.mounted) setState(() => _isLoading = false);
  }

  showSendMailToast() {
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
          SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
          Text("mail_sent".tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 4,
              ))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  showSendErrorToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0), color: Colors.red
          // color: Color(0xff3A559F),
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.close, color: Colors.white),
          SizedBox(width: SizeConfig.blockSizeHorizontal * 2),
          Text(" enter_mail_pass".tr(),
              style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.safeBlockHorizontal * 3,
              ))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await pushNewScreenWithRouteSettings(context,
              settings: RouteSettings(
                name: LoginScreen.routeName,
              ),
              screen: LoginScreen(),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.fade);
          return true;
        },
        child: Scaffold(
            key: _scaffoldKey50,
            drawer: DrawerLayout(),
            appBar: PreferredSize(
              child:
                  GradientAppBar("forget_password".tr(), _scaffoldKey50, true),
              preferredSize: const Size(double.infinity, kToolbarHeight),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      EdgeInsets.only(top: SizeConfig.blockSizeVertical * 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "forget_password".tr() + "؟",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.safeBlockHorizontal * 6,
                            // color: Colors.black
                            color: Color(0xff515C6F)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2,
                            right: SizeConfig.blockSizeHorizontal * 2,
                            left: SizeConfig.blockSizeHorizontal * 2),
                        child: Text(
                          "mail_confirm".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.safeBlockHorizontal * 3.5,
                              // color: Color(0xff3A559F),
                              color: Color(0xff515C6F)),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 80,
                        height: SizeConfig.blockSizeVertical * 10,
                        padding: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 1,
                            top: SizeConfig.blockSizeVertical * 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: TextFieldBuild(
                            obscureText: false,
                            readOnly: false,
                            textInputType: TextInputType.text,
                            lineCount: 1,
                            hintText: "enter_mail".tr(),
                            textStyle: TextStyle(
                                fontSize: SizeConfig.safeBlockHorizontal * 4,
                                color: Color(0xff515C6F)),
                            textEditingController: emailController),
                      ),
                      GestureDetector(
                        onTap: () => resetPassword(),
                        child: Container(
                          width: SizeConfig.blockSizeHorizontal * 60,
                          height: SizeConfig.blockSizeVertical * 9,
                          padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xff3A559F),
                            ),
                            height: SizeConfig.blockSizeVertical * 5,
                            width: SizeConfig.blockSizeHorizontal * 30,
                            child: Center(
                              child: Text(
                                "send_mail".tr(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        SizeConfig.safeBlockHorizontal * 5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
