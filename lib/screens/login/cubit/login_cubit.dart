import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/login_model.dart';
import '../../../shared/end_points.dart';
import '../../../shared/remote/dio_helper.dart';
import 'login_state.dart';


class ShopLoginCubit extends Cubit<LoginStates>{
  ShopLoginCubit(): super(LoginInitialState());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userLogin(
      {
        required String email,
        required String password,
      }
      ){
    emit(LoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,

        }
    ).then((value) {
      print(value.data);
      loginModel= ShopLoginModel.fromJson(value.data);

      emit(LoginSuccessState(loginModel));
    }).catchError((error){

      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });


  }
  IconData  suffix=Icons.visibility;
  bool isPassword = true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(ShopChangePasswordVisibilityState());
  }
}