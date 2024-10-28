import 'package:e_commerce_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/shop_cubit.dart';
import '../../cubit/shop_state.dart';
import '../search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ShopCubit()..getHomeData()..getCategoriesData(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ShopCubit cubit = ShopCubit.get(context);
            return Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.grey[50],
                    elevation: 0.0,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(

                              context,
                              MaterialPageRoute(builder:(context) => SearchScreen(),),

                            );
                          },
                          icon: Icon(Icons.search,color: Colors.black,)),
                    ],
                    title: Text(
                      'Salla',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    )),
                body: cubit.bottomScreens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  iconSize: 30,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: MyColors.defaultColor,
                  onTap: (index) {
                    cubit.changeBottom(index);
                  },
                  currentIndex: cubit.currentIndex,
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.apps_rounded), label: "Categories"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.favorite), label: "Favorite"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), label: "  Settings"),
                  ],
                ));
          },
        ));
  }
}
