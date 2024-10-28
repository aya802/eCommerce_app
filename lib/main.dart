import 'package:e_commerce_app/screens/home/shop_home_screen.dart';
import 'package:e_commerce_app/screens/login/login_screen.dart';
import 'package:e_commerce_app/screens/on_boarding/on_boarding_screen.dart';
import 'package:e_commerce_app/screens/splash_screen.dart';
import 'package:e_commerce_app/shared/componant/constants.dart';
import 'package:e_commerce_app/shared/local/shared_pref_cache.dart';
import 'package:e_commerce_app/shared/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await  CacheHelper.init();
  var onBoarding= CacheHelper.getData(key:'onBoarding');
  token= CacheHelper.getData(key:'token');
 // print(token);
  late Widget widget;

  if(onBoarding != null){
    if(token != null){
      widget=ShopLayout();
    }else{
      widget=LoginScreen();
    }
  }else{
    widget= OnBoardingScreen();
  }
  runApp((MyApp(startWidget: widget,)));
}


class MyApp extends StatelessWidget{
  final Widget startWidget;

  MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      //designSize: Size(412, 915),
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child) {
          return  MaterialApp(
            theme: ThemeData(fontFamily: 'Montserrat'),
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        }
    );
  }

}
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// void main() async{
//
//   WidgetsFlutterBinding.ensureInitialized();
//   Bloc.observer = MyBlocObserver();
//   DioHelper.init();
//   await  CacheHelper.init();
//   bool onBoarding= CacheHelper.getData(key:'onBoarding');
//   token= CacheHelper.getData(key:'token');
//   print(token);
//   late Widget widget;
//
//   if(onBoarding !=null){
//     if(token != null){
//       widget=ShopLayout();
//     }else{
//       widget=LoginScreen();
//     }
//   }else{
//     widget= OnBoardingScreen();
//   }
//   runApp((MyApp(startWidget: widget,)));
// }
// class MyApp extends StatelessWidget {
//   final Widget startWidget;
//
//   MyApp({required this.startWidget});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: startWidget,
//     );
//   }
// }
//



