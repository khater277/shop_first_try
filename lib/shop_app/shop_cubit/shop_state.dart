import 'package:last_try/models/login_model.dart';
import 'package:last_try/shop_app/login/cubit/login_cubit.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{} ////initial

class ShopNavBarState extends ShopStates{}   ////NavBar

class ShopHomeLoadingState extends ShopStates{} /////
class ShopHomeSuccessState extends ShopStates{}   ///////get home data
class ShopHomeErrorState extends ShopStates{}   /////

class ShopCategoriesLoadingState extends ShopStates{} /////
class ShopCategoriesSuccessState extends ShopStates{}   ///////get categories data
class ShopCategoriesErrorState extends ShopStates{}   /////

class ShopFavouritesLoadingState extends ShopStates{} /////
class ShopFavouritesSuccessState extends ShopStates{}   ///////get favourites data
class ShopFavouritesErrorState extends ShopStates{}   /////

class ShopChangeFavouritesSuccessState extends ShopStates{}  //////// change favourites
class ShopChangeFavouritesErrorState extends ShopStates{}    ///////
class ShopFavouritesChangeState extends ShopStates{}         /////// change button

class ShopUserDataLoadingState extends ShopStates{} /////
class ShopUserDataSuccessState extends ShopStates{}   ///////get user data
class ShopUserDataErrorState extends ShopStates{}   /////

class ShopUpdateUserLoadingState extends ShopStates{} /////
class ShopUpdateUserSuccessState extends ShopStates{
  final LoginModel loginModel;

  ShopUpdateUserSuccessState(this.loginModel);

}   ///////update user data
class ShopUpdateUserErrorState extends ShopStates{}   /////

class SearchLoadingState extends ShopStates{} /////
class SearchSuccessState extends ShopStates{}   ///////get search data
class SearchErrorState extends ShopStates{}   /////
