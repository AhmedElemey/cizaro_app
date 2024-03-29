import 'package:flutter/material.dart';

class TextFieldBuild extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool obscureText;
  final TextInputType textInputType;
  final Function validator;
  final String hintText;
  final IconData icon;
  final int lineCount;
  final Function onClick;
  final bool readOnly;

  TextFieldBuild({this.textEditingController, this.obscureText,this.onClick,this.readOnly,
    this.textInputType, this.validator, this.hintText,this.icon,this.lineCount});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width * 0.89,
      height: MediaQuery.of(context).size.height * 0.07,
      child: TextFormField(
        maxLines: lineCount,
        controller: textEditingController,
        obscureText: obscureText,
        keyboardType: textInputType,
        cursorColor: Color(0xff294794),
        validator: validator,
        readOnly: readOnly,
        style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
        decoration: InputDecoration(
            filled: true,
            suffixIcon: GestureDetector( onTap : onClick,child: Icon(icon,color: Colors.grey,size: MediaQuery.of(context).size.width * 0.06)),
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.only(right: 8, left: 8),
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)))),
      ),
    );
  }

}