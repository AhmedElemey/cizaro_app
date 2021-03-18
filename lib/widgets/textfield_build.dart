import 'package:cizaro_app/size_config.dart';
import 'package:flutter/material.dart';

class TextFieldBuild extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputType textInputType;
  final Function validator;
  final String hintText;
  final IconData icon;
  final int lineCount;
  final TextStyle textStyle;
  final Function onClick;
  final bool readOnly;
  final Function onChange;
  final String initialValue;

  TextFieldBuild(
      {this.textEditingController,
      this.obscureText,
      this.onClick,
      this.readOnly,
      this.textInputType,
      this.validator,
      this.hintText,
      this.initialValue,
      this.textStyle,
      this.onChange,
      this.icon,
      this.lineCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextFormField(
        initialValue: initialValue,
        maxLines: lineCount,
        controller: textEditingController,
        obscureText: obscureText,
        keyboardType: textInputType,
        cursorColor: Color(0xff294794),
        onChanged: onChange,
        validator: validator,
        readOnly: readOnly,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.safeBlockVertical * 2.2),
        decoration: InputDecoration(
            filled: true,
            suffixIcon: GestureDetector(
                onTap: onClick,
                child: Icon(icon,
                    color: Colors.grey,
                    size: MediaQuery.of(context).size.width * 0.06)),
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.only(right: 8, left: 8),
            hintText: hintText,
            hintStyle: textStyle,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }
}
