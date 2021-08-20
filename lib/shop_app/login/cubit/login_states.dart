//import 'package:self_try/Models/home_model.dart';
//import 'package:self_try/Models/login_model.dart';
//import 'package:self_try/ShopApp/Cubit/shop_cubit.dart';

import 'package:last_try/models/login_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{} //initial

class ShopLoginChangeVisibilityState extends LoginStates{} //change password visibility

class ShopLoginLoadingState extends LoginStates{}   ////
class ShopLoginSuccessState extends LoginStates{
  final LoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}    /////// login
class ShopLoginErrorState extends LoginStates{}    ////