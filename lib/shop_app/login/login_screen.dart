
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:last_try/network/local/cache_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/home/home_screen.dart';
import 'package:last_try/shop_app/register/register_screen.dart';
//import 'package:self_try/Network/Local/cache_helper.dart';
//import 'package:self_try/Shared/constants.dart';
//import 'package:self_try/Shared/default_widgets.dart';
//import 'package:self_try/ShopApp/Home/home_screen.dart';
//import 'package:self_try/ShopApp/Login/cubit/login_cubit.dart';

import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
         if(state is ShopLoginSuccessState)
           {
             if(state.loginModel.status==true)
               {
                 CacheHelper.saveData(
                     key: 'token',
                     value:state.loginModel.userData!.token
                 ).then((value) {
                   token=state.loginModel.userData!.token;
                   navigateAndFinish(context: context, widget: HomeScreen());
                 });
               }else
                 {
                   toastBuilder(
                     msg: "Email or Password you entered is wrong",
                     color: Colors.grey[700],
                   );
                 }
           }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 28,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Login now to browse our hot offers',
                            style: TextStyle(
                              //fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          defaultTextFiled(
                            controller: emailController,
                            inputType: TextInputType.emailAddress,
                            prefixIcon: Icons.email_outlined,
                            label: 'Email Address',
                            textColor: Colors.grey[800],
                            borderColor: Colors.grey,
                            preIconColor: Colors.grey[700],
                          ),
                          SizedBox(height: 15,),
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
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.getLoginData(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            minWidth: double.infinity,
                            height: 40,
                            color: Colors.black,
                            child: Conditional.single(
                              context: context,
                              conditionBuilder: (context)=>state is! ShopLoginLoadingState,
                              widgetBuilder: (context)=>Text(
                                'LOGIN',
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
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Don't have an account?",
                                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                  fontWeight: FontWeight.w100
                                ),
                              ),
                              SizedBox(width: 8,),
                              TextButton(
                                  onPressed: (){
                                    navigateTo(context: context,widget: RegisterScreen());
                                  },
                                  child: Text(
                                    "REGISTER",
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                                        fontWeight: FontWeight.w900
                                    ),
                                  ),
                              )
                            ],
                          )
                        ],

                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
