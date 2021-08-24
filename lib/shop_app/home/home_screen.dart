import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shop_app/categories/categories_screen.dart';
import 'package:last_try/shop_app/favourites/favourites_screen.dart';
import 'package:last_try/shop_app/products/products_screen.dart';
import 'package:last_try/shop_app/search/search_cubit.dart';
import 'package:last_try/shop_app/search/search_screen.dart';
import 'package:last_try/shop_app/settings/settings_screen.dart';
import 'package:last_try/shop_app/shop_cubit/shop_cubit.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';
import 'package:line_icons/line_icons.dart';


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
            bottomNavigationBar:cubit.homeModel!=null?
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                child: GNav(
                  textStyle: Theme.of(context).textTheme.bodyText2,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 900),
                    gap: 8,
                    color: Colors.grey[800],
                    activeColor: Colors.black87,
                    iconSize: 24,
                    tabBackgroundColor: Colors.black.withOpacity(0.1),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    onTabChange:(index){
                        cubit.changeNavBar(index);
                      },
                    tabs: [
                      GButton(
                        icon: LineIcons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.apps_outlined,
                        text: 'Categories',
                      ),
                      GButton(
                        icon: LineIcons.heart,
                        text: 'Favourites',
                      ),
                      GButton(
                        icon: LineIcons.user,
                        text: 'Profile',
                      )
                    ]
                ),
              ),
            )
                :null,
          );
        },
      ),
    );
  }
}
