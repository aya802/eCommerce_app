import 'package:e_commerce_app/main.dart';
import 'package:e_commerce_app/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

//import '../modules/log_in/login_screen.dart';
//import '../shared/network/local/cache_helper.dart';

class ModelOnBoarding {
  final String? img;
  final String? title;
  final String? body;
  ModelOnBoarding({
    required this.img,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // const ({Key? key}) : super(key: key);
  var boardController = PageController();

  List<ModelOnBoarding> boarding = [
    ModelOnBoarding(
        img: 'assets/img/onboarding_1.jpg',
        title: 'Choose Products',
        body:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.'),
    ModelOnBoarding(
        img: 'assets/img/onboarding_1.jpg',
        title: 'Make Payment',
        body:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.'),
    ModelOnBoarding(
        img: 'assets/img/onboarding_1.jpg',
        title: 'Get Your Order',
        body:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.'),
  ];

  bool isLast = false;
  // void submit(){
  //   CacheHelper.saveData(key:'onBoarding', value: true).then((value) {
  //     if(value){
  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder:(context) => LoginScreen(),),
  //               (Route<dynamic>route)=>false
  //       );
  //     }
  //   });

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                    (Route<dynamic> route) => false);
                // submit;
              },
              child: Text(
                'Skip',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0,left: 16,bottom: 8),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return buildBoardingItem(boarding[index]);
                },
                controller: boardController,
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(

              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                        activeDotColor: MyColors.grayColor,
                        dotColor: Colors.grey,
                        spacing: 5.0,
                        expansionFactor: 4,
                        dotWidth: 10.w,
                        dotHeight: 10.h),
                    count: boarding.length),
                Spacer(),
                TextButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (Route<dynamic> route) => false);
                      //  submit;
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child:isLast? Text(
                    'Get Started',
                    style: TextStyle(
                        color: MyColors.defaultColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ):Text(
                    'Next',
                    style: TextStyle(
                        color: MyColors.defaultColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(ModelOnBoarding myboardmodel) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('${myboardmodel.img}'),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '${myboardmodel.title}',
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            '${myboardmodel.body}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
