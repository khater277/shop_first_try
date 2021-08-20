import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:last_try/network/local/cache_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/login/login_screen.dart';
import 'package:last_try/shop_app/shop_cubit/shop_cubit.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';

class SettingsScreen extends StatelessWidget {

  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopUpdateUserSuccessState)
          {
            toastBuilder(msg: "${state.loginModel.message}", color: Colors.grey[700]);
          }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        nameController.text='${cubit.userModel!.userData!.name}';
        emailController.text='${cubit.userModel!.userData!.email}';
        phoneController.text='${cubit.userModel!.userData!.phone}';
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  defaultTextFiled(
                    controller: nameController,
                    inputType: TextInputType.name,
                    prefixIcon: Icons.person_outline,
                    label: 'Name',
                    textColor: Colors.grey[800],
                    borderColor: Colors.grey,
                    preIconColor: Colors.grey[700],
                  ),
                  SizedBox(height: 20,),
                  defaultTextFiled(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    label: 'Email Address',
                    textColor: Colors.grey[800],
                    borderColor: Colors.grey,
                    preIconColor: Colors.grey[700],
                  ),
                  SizedBox(height: 20,),
                  defaultTextFiled(
                    controller: phoneController,
                    inputType: TextInputType.phone,
                    prefixIcon: Icons.phone_outlined,
                    label: 'Phone number',
                    textColor: Colors.grey[800],
                    borderColor: Colors.grey,
                    preIconColor: Colors.grey[700],
                  ),SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                      if(formKey.currentState!.validate())
                      {
                        cubit.updateUser(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text
                        );
                      }
                    },
                    minWidth: double.infinity,
                    height:40,
                    color: Colors.black,
                    child:state is ShopUpdateUserLoadingState==false? Text(
                      'UPDATE PROFILE',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                    :Container(
                      width: 20,height: 20,
                        child: CircularProgressIndicator(color: Colors.white,)
                    ),
                  ),
                  SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                      CacheHelper.removeData(key: 'token').then((value){
                        navigateAndFinish(context: context, widget: LoginScreen());
                        cubit.currentIndex=0;
                      });
                    },
                    minWidth: double.infinity,
                    height:40,
                    color: Colors.black,
                    child: Text(
                      'LOGOUT',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
