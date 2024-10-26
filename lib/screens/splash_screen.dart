
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'on_boarding/on_boarding_screen.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {

      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => OnBoardingScreen(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Image.asset('assets/img/logoipsum.png',width:275.w,height: 100.h,)),
    );

  }
}