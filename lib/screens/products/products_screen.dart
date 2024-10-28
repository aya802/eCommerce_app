


import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../cubit/shop_cubit.dart';
import '../../cubit/shop_state.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';


class ProductScreen extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel !=null,
          builder: (context) => productBuilder(cubit.homeModel!,cubit.categoriesModel!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget productBuilder(HomeModel model, CategoriesModel categoriesModel, BuildContext context) => SingleChildScrollView(
  physics: BouncingScrollPhysics(),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CarouselSlider(
          items: model.data?.banners
              .map((e) => Image(
              image: NetworkImage(
                  'https://www.shutterstock.com/image-vector/concept-online-shopping-on-social-600w-1769713256.jpg')))
              .toList(),
          options: CarouselOptions(
            height: 250,
            // aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          )),

      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 10.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categories',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100.0,
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>buildCategoryItem(categoriesModel.data!.data[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 10.0,),
                  itemCount: categoriesModel.data!.data.length),
            )  ,
            SizedBox(
              height: 30,
            ),
            Text('New Products',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        color: Colors.grey[300],
        child: GridView.count(
          shrinkWrap: true,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          childAspectRatio: 1 / 1.6,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: List.generate(model.data!.products.length,
                  (index) => buildGridProduct((model.data!.products[index]),context)),
        ),
      )
    ],
  ),
);
Widget buildCategoryItem(DataModel model)=> Stack(
  alignment: AlignmentDirectional.bottomCenter,
  children: [
    Image(
      image: NetworkImage(model.image!),
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
    ),
    Container(
      width: 100.0,
      color: Colors.black.withOpacity(0.7),
      child: Text(
        model.name!,
        style: TextStyle(color: Colors.white, fontSize: 20),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
);
Widget buildGridProduct(ProductModel model,context) => Container(
  color: Colors.white,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(model.image!),
            width: double.infinity,
            height: 200,
          ),
          if (model.discount != 0)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 10),
              ),
              color: Colors.red,
            )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14, height: 1.3),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  '${model.price!.round()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: MyColors.defaultColor),
                ),
                SizedBox(width: 5),
                if (model.discount != 0)
                  Text(
                    '${model.oldPrice!.round()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      print('hellow');
                    },
                    icon:CircleAvatar(
                      radius: 15,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]!?MyColors.defaultColor:Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14,
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
    ],
  ),
);
