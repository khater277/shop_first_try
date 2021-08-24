import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:last_try/network/local/cache_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/home/home_screen.dart';
import 'package:last_try/shop_app/register/cubit/register_cubit.dart';
import 'package:last_try/shop_app/register/cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {

  TextEditingController nameController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context)=>RegisterCubit(),
        child: BlocConsumer<RegisterCubit,RegisterStates>(
          listener: (context,state){
            if(state is ShopRegisterSuccessState){
              if(state.registerModel.status==true)
                {
                  CacheHelper.saveData(
                      key: 'token',
                      value: state.registerModel.userData!.token,
                  ).then((value){
                    token=state.registerModel.userData!.token;
                    navigateAndFinish(context: context, widget: HomeScreen());
                  });
                }else
              {
                toastBuilder(
                  msg: "${state.registerModel.message}",
                  color: Colors.grey[700],
                );
              }
            }
          },
          builder: (context,state){
            RegisterCubit cubit = RegisterCubit.get(context);
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        'Register now to browse our hot offers',
                        style: TextStyle(
                          //fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
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
                      SizedBox(height: 15,),
                      defaultTextFiled(
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        label: 'Email Address',
                        textColor: Colors.grey[800],
                        borderColor: Colors.grey,
                        preIconColor: Colors.grey[700],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      defaultTextFiled(
                        controller: passwordController,
                        isPassword: cubit.isPassword,
                        inputType: TextInputType.visiblePassword,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: cubit.icon,
                        suffixPressed: () {
                          cubit.changeVisibility();
                        },
                        label: 'Password',
                        textColor: Colors.grey[800],
                        borderColor: Colors.grey,
                        preIconColor: Colors.grey[700],
                        suffixIconColor: Colors.grey,
                      ),
                      SizedBox(height: 15,),
                      defaultTextFiled(
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        prefixIcon: Icons.phone,
                        label: 'Phone number',
                        textColor: Colors.grey[800],
                        borderColor: Colors.grey,
                        preIconColor: Colors.grey[700],
                      ),
                      SizedBox(height: 20,),
                      MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.getRegisterData(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text
                            );
                          }
                        },
                        minWidth: double.infinity,
                        height: 40,
                        color: Colors.black,
                        child: Conditional.single(
                          context: context,
                          conditionBuilder: (context)=>state is! ShopRegisterLoadingState,
                          widgetBuilder: (context)=>Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          fallbackBuilder: (context)=>Center(
                            child: Container(
                              width: 20,height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],

                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}