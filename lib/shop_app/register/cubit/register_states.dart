//import 'package:self_try/Models/home_model.dart';
//import 'package:self_try/Models/login_model.dart';
//import 'package:self_try/ShopApp/Cubit/shop_cubit.dart';

import 'package:last_try/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{} //initial

class ShopRegisterChangeVisibilityState extends RegisterStates{} //change password visibility

class ShopRegisterLoadingState extends RegisterStates{}   ////
class ShopRegisterSuccessState extends RegisterStates{
  final LoginModel registerModel;

  ShopRegisterSuccessState(this.registerModel);
}    /////// login
class ShopRegisterErrorState extends RegisterStates{}    ////