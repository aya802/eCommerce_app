import 'package:e_commerce_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>?  onSubmit,
  VoidCallback? onTab,
  ValueChanged<String>? onChange,
  required String? textOfValidation,
  required String lable,
  required IconData? prefix,
  IconData? suffix,
  bool isPassword=false,
  Function ?suffixPressed,

}) {
  return TextFormField(

    controller: controller,
    keyboardType: type,
    obscureText: isPassword,

    // onChanged:( s)
    // {
    //    onChange!(s);
    //  },
    onFieldSubmitted: (s){
      onSubmit!(s);
    },

    validator: (String? value) {
      if (value!.isEmpty) {
        return '$textOfValidation';
      } else {
        return null;
      }
    },
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MyColors.borderGrayColor),
          borderRadius: BorderRadius.circular(10)
      ),


      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: MyColors.borderGrayColor),
          borderRadius: BorderRadius.circular(10)
      ),
      fillColor: MyColors.lightGrayColor,

      filled: true,
      labelStyle: TextStyle(color: Colors.grey[600],fontSize: 12,fontWeight: FontWeight.w500),
      labelText: lable,
      prefixIcon: Icon(prefix,color: Colors.grey[600],),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: MyColors.borderGrayColor),
        borderRadius: BorderRadius.circular(10)

      ),
      suffixIcon: suffix !=null?IconButton(
        onPressed: (){
          suffixPressed!();
        },
        icon:Icon(suffix, color: Colors.grey[600],) ,

      ):null,
    ),
    onTap: onTab,
  );
}
Future<bool?> showToast({
  required String text,
  required ToastStates state
}){
  return  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;


  }

  return color;
}

Widget defaultButton({


 required VoidCallback? onPressed,

  required String text,
required double width,
  required double height,



}) {

   return MaterialButton(

      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(10.0), // Border radius
      ),
      onPressed: onPressed,

     child: Text(text,),
     height: height,
     minWidth: width,
       color: MyColors.defaultColor,





  );
}