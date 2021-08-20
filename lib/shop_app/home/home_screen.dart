import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shop_app/categories/categories_screen.dart';
import 'package:last_try/shop_app/favourites/favourites_screen.dart';
import 'package:last_try/shop_app/products/products_screen.dart';
import 'package:last_try/shop_app/search/search_cubit.dart';
import 'package:last_try/shop_app/search/search_screen.dart';
import 'package:last_try/shop_app/settings/settings_screen.dart';
import 'package:last_try/shop_app/shop_cubit/shop_cubit.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';


class HomeScreen extends StatelessWidget {

  List<Widget> navBarScreens=[
    ProductsScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)=>
        ShopCubit()..getHomeData()..getCategories()..getFavourites()..getUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit cubit=ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  'Salla',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    fontSize: 22,
                  )
              ),
              actions: [
                IconButton(
                  onPressed: (){
                    navigateTo(context: context, widget: SearchScreen());
                  },
                  icon: Icon(Icons.search),
                )
              ],
            ),
            body: navBarScreens[cubit.currentIndex],
            bottomNavigationBar:cubit.homeModel!=null?BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeNavBar(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favourites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ],
            )
                :null,
          );
        },
      ),
    );
  }
}
