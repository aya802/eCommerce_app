

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/screens/get_started/get_started_screen.dart';
import 'package:e_commerce_app/screens/home/shop_home_screen.dart';
import 'package:e_commerce_app/screens/register/register_screen.dart';
import 'package:e_commerce_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../shared/componant/componant.dart';
import '../../shared/local/shared_pref_cache.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_state.dart';


class LoginScreen extends StatelessWidget {
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopLoginCubit(),
        child: BlocConsumer<ShopLoginCubit, LoginStates>(
            listener: (context, state) {
              if (state is LoginSuccessState) {
                if (state.loginModel.status!) {
                  print(state.loginModel.data?.token);
                  print(state.loginModel.message);
                  CacheHelper.saveData(
                    key: 'token',
                    value: state.loginModel.data?.token,
                  ).then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GetStarted(),
                        ),
                            (Route<dynamic> route) => false);
                  });
                } else {
                  print(state.loginModel.message);
                  showToast(
                      text: state.loginModel.message!, state: ToastStates.ERROR);
                }
              }
            }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome Back!',

                        style: TextStyle(
                            fontSize: 36.0, fontWeight: FontWeight.w700),
                      ),

                      SizedBox(
                        height: 60.h,
                      ),
                      defaultFormField(
                        controller: emailcontroller,
                        type: TextInputType.emailAddress,
                        textOfValidation: 'please enter your email address',
                        lable: 'Username or Email',
                        prefix: Icons.person,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultFormField(
                          controller: passwordcontroller,
                          type: TextInputType.emailAddress,
                          textOfValidation: 'password is too short',
                          lable: 'Password',
                          prefix: Icons.lock,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: () {
                            ShopLoginCubit.get(context)
                                .changePasswordVisibility();
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                            }
                          }),
                      TextButton(
                          onPressed:(){

                          }, child: Text('Forgot Password?',style: TextStyle(color: MyColors.pinkColor),)),
                      SizedBox(
                        height: 30,
                      ),

                      ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: 55.h,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                // Border color and width
                                borderRadius: BorderRadius.circular(10.0), // Border radius
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailcontroller.text,
                                      password: passwordcontroller.text);
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.white,fontSize: 20),
                              ),
                              color: MyColors.pinkColor,

                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator(color: MyColors.pinkColor,))),
                      SizedBox(
                        height: 60.h,
                      ),
                      Text('- OR Continue with -',style: TextStyle(color:MyColors.grayColor),),

                      SizedBox(
                        height: 20.h,
                      ), Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/img/Google.png',width:54.w,height: 54.h,),
                          SizedBox(
                            width: 10.w,
                          ),
                          Image.asset('assets/img/Apple.png',width:54.w,height: 54.h,),
                          SizedBox(
                            width: 10.w,
                          ),
                          Image.asset('assets/img/Facebook.png',width:54.w,height: 54.h,)
                          ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create An Account',
                            style: TextStyle(

                                color:MyColors.grayColor
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RegisterScreen(),
                                    ));
                              },
                              child: Text('Sign Up',  style: TextStyle(

                                  color:MyColors.pinkColor
                              ),)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
