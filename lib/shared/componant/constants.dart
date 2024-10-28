import 'package:flutter/material.dart';

import '../../screens/login/login_screen.dart';
import '../local/shared_pref_cache.dart';




void signout(context){
  CacheHelper.removeData(key:'token').then((value) {
    if (value!) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder:(context) => LoginScreen(),),
              (Route<dynamic>route)=>false
      );
    }
  });
}
String token='';