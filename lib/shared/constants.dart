import 'package:flutter/material.dart';

String? token='';
Color indicatorColor=Colors.red.withOpacity(0.7);

void navigateTo({
  @required BuildContext? context,
  @required Widget? widget,
}) {
  Navigator.push(
    context!,
    MaterialPageRoute(builder: (context)=>widget!),
  );
}

void navigateAndFinish({
  @required BuildContext? context,
  @required Widget? widget,
}){
  Navigator.pushAndRemoveUntil(
      context!,
      MaterialPageRoute(builder: (context)=>widget!),
          (route) => false
  );
}