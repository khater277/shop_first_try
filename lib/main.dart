import 'package:flutter/material.dart';
import 'package:last_try/network/local/cache_helper.dart';
import 'package:last_try/network/remote/dio_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shop_app/home/home_screen.dart';
import 'package:last_try/shop_app/login/login_screen.dart';
import 'package:last_try/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:last_try/styles/Themes.dart';


void main() async{
  WidgetsFlutterBinding();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding=CacheHelper.getData(key: 'onBoarding');
  token=CacheHelper.getData(key: 'token');
  print(token);
  if(onBoarding==null)
    widget=OnBoardingScreen();
  else
    if(token==null||token!.isEmpty)
      widget=LoginScreen();
    else
      widget=HomeScreen();
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp(this.widget);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:widget,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
