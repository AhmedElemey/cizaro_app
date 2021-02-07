import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastBuild extends StatefulWidget {
  final String toastMessage;
  final IconData toastIcon;
  final Color bgColor;

  ToastBuild({this.toastMessage, this.toastIcon, this.bgColor});

  @override
  _ToastBuildState createState() => _ToastBuildState();
}

class _ToastBuildState extends State<ToastBuild> {
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: widget.bgColor ?? Color(0xff3A559F)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.toastIcon ?? Icons.check, color: Colors.white),
          SizedBox(width: 12.0),
          Text(widget.toastMessage, style: const TextStyle(color: Colors.white))
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 2),
      // positionedToastBuilder: (context, child) {
      //   return Positioned(
      //     child: child,
      //     bottom: 16.0,
      //     left: 16.0,
      //   );
      // } da law 3ayz tezbat el postion ele hayzhar feh
      gravity: ToastGravity.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return showToast();
  }
}
