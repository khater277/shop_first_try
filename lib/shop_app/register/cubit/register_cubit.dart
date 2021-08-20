import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_try/models/login_model.dart';
import 'package:last_try/network/remote/END_POINTS.dart';
import 'package:last_try/network/remote/dio_helper.dart';
import 'package:last_try/shop_app/register/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool isPassword=true;
  IconData icon=Icons.visibility_outlined;
  void changeVisibility(){
    isPassword=!isPassword;
    if(isPassword==true)
      icon=Icons.visibility_outlined;
    else
      icon=Icons.visibility_off_outlined;
    emit(ShopRegisterChangeVisibilityState());
  }

  LoginModel? registerModel;
  void getRegisterData({
    @required String? name,
    @required String? email,
    @required String? password,
    @required String? phone,
}){
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'phone':phone,
        }
    ).then((value){
      print(value.data);
      registerModel=LoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      print('ERROR IN GetRegisterData====>$error');
      emit(ShopRegisterErrorState());
    });
  }
}