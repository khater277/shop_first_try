import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_try/models/login_model.dart';
import 'package:last_try/network/remote/END_POINTS.dart';
import 'package:last_try/network/remote/dio_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  bool isPassword=true;
  IconData icon=Icons.visibility_outlined;
  void changeVisibility(){
    isPassword=!isPassword;
    if(isPassword==true)
      icon=Icons.visibility_outlined;
    else
      icon=Icons.visibility_off_outlined;
    emit(ShopLoginChangeVisibilityState());
  }

  LoginModel? loginModel;
  void getLoginData({
  @required String? email,
    @required String? password,
}){
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value){
      loginModel=LoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error){
      print('ERROR IN GetLoginData====>$error');
      emit(ShopLoginErrorState());
    });
  }
}