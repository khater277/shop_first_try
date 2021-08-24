import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicators/progress_indicators.dart';

Widget defaultProgressIndicator({
  IconData? icon,
}){
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlowingProgressIndicator(
          child: Icon(icon,size: 35,),
        ),
        SizedBox(height: 6,),
        FadingText(
            'Loading...',
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ],
    ),
  );
}

TextFormField defaultTextFiled({
  @required TextEditingController? controller,
  @required TextInputType? inputType,
  @required IconData? prefixIcon,
  @required String? label,
  @required Color? textColor,
  @required Color? borderColor,
  @required Color? preIconColor,
  Color? suffixIconColor,
  bool isPassword = false,
  Function? onSubmit(value)?,
  Function? onChanged(value)?,
  Function? suffixPressed,
  IconData? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    cursorColor: textColor,
    validator: (value) {
      if (value!.isEmpty) {
        return "$label can't be empty";
      }
      return null;
    },
    style: TextStyle(
      color: textColor,
    ),
    keyboardType: inputType,
    obscureText: isPassword,
    onFieldSubmitted: (value) => onSubmit!(value),
    //onChanged: (value)=>onChanged!(value),
    decoration: InputDecoration(
      prefixIcon: Icon(
        prefixIcon,
        color: preIconColor,
      ),
      suffixIcon:suffixIcon!=null? IconButton(
        onPressed: () => suffixPressed!(),
        icon: Icon(suffixIcon),
        color: suffixIconColor,
        //focusColor: suffixIconColor,
      ):null,
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          )),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red,
          )),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor!,
          )),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor,
          )),
      labelText: label,
      labelStyle: TextStyle(
        color: textColor,
      ),
    ),
  );
}

void toastBuilder({
  @required String? msg,
  @required Color? color,
}) {
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 13.0);
}
