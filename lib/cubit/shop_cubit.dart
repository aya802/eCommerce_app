import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/cubit/shop_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../models/categories_model.dart';
import '../models/home_model.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/favorites/favorites_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../shared/componant/constants.dart';
import '../shared/end_points.dart';
import '../shared/remote/dio_helper.dart';


class ShopCubit extends Cubit<ShopStates>{
  ShopCubit():super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> bottomScreens=[
    ProductScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),


  ];
  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());

  }
  late Map<int,bool>favorites={};
  HomeModel? homeModel;
  void getHomeData()async{

    emit(ShopLoadingHomeDtaState());
    await DioHelper.getData(
      url: HOME,
      token: token,
    ).then(
            (value) {
          homeModel =HomeModel.fromJson(value.data);
          // print(homeModel?.data?.banners[0].image);
          //    print(homeModel?.status);
          homeModel?.data?.products.forEach((element) {
            favorites.addAll({
              element.id!:element.inFavorites!,
            });
          });
          print(favorites.toString());
          emit(ShopSuccessHomeDataState());

        }).catchError((error){
      print (error.toString());
      emit(ShopErrorHomeDataState());
    });
  }
  CategoriesModel? categoriesModel;
  void getCategoriesData()async{


    await DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then(
            (value) {
          categoriesModel =CategoriesModel.fromJson(value.data);
          emit(ShopSuccessCategoriesState());



        }).catchError((error){
      print (error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
  void changeFavorites(int productId){
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id':productId,
      },
      token: token,
    ).then((value) {
      emit(ShopSuccessChangeFavoritesState());

    }).catchError((error){
      emit(ShopSuccessChangeFavoritesState());
    });

  }

}


