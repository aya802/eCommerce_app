import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubit/shop_cubit.dart';
import '../../cubit/shop_state.dart';
import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder:( context,index)=> Divider(
              thickness: 0.5,
              color: Colors.grey,
              indent: 10,
              endIndent: 10,
              height: 4,),
            itemCount:ShopCubit.get(context).categoriesModel!.data!.data.length );
      } ,
    );
  }
}
Widget buildCatItem(DataModel model)=>Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      Image(
        image:NetworkImage(model.image!),
        height: 100.0,
        width: 100.0,
        fit: BoxFit.cover,
      ),
      SizedBox(width: 20,),
      Text(model.name!,style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
      Spacer(),
      Icon(Icons.arrow_forward_ios),


    ],
  ),
);