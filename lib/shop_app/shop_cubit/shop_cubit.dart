import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_try/models/change_favourite_model.dart';
import 'package:last_try/models/favourites_model.dart';
import 'package:last_try/models/categories_model.dart';
import 'package:last_try/models/home_model.dart';
import 'package:last_try/models/login_model.dart';
import 'package:last_try/models/search_model.dart';
import 'package:last_try/network/remote/END_POINTS.dart';
import 'package:last_try/network/remote/dio_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shared/default_widgets.dart';
import 'package:last_try/shop_app/shop_cubit/shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  void changeNavBar(index) {
    currentIndex = index;
    emit(ShopNavBarState());
  }

  Map<int?,bool?>favourites={};
  HomeModel? homeModel;
  void getHomeData(){
    emit(ShopHomeLoadingState());
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value){
      homeModel=HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favourites.addAll({
          element.id!:element.inFavorites!
        });
      });
      print(favourites);
      emit(ShopHomeSuccessState());
    }).catchError((error){
      print("error in getHomeData===>$error");
      emit(ShopHomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories(){
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error){
      print("error in getCategoriesData===>$error");
      emit(ShopCategoriesErrorState());
    });
  }

  FavouritesModel? favouritesModel;
  void getFavourites(){
    emit(ShopFavouritesLoadingState());
    DioHelper.getData(
      url: FAVOURITES,
      token: token,
    ).then((value){
      favouritesModel=FavouritesModel.fromJson(value.data);
      print(favouritesModel!.data!.data[0].product!.name);
      emit(ShopFavouritesSuccessState());
    }).catchError((error){
      print("error in getFavourites===>$error");
      emit(ShopFavouritesErrorState());
    });
  }

  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites({@required int? productID}){
    if(favourites[productID]==true) {
      favourites[productID] = false;
      toastBuilder(msg: 'deleted from favourites', color: Colors.grey[800]);
    }
    else {
      favourites[productID] = true;
      toastBuilder(msg: 'added to favourites', color: Colors.grey[800]);
    }
    emit(ShopFavouritesChangeState());
    DioHelper.postData(
        url: FAVOURITES,
        data: {
          'product_id':productID
        },
      token: token,
    ).then((value){
      changeFavouritesModel=ChangeFavouritesModel.fromJson(value.data);
      if(changeFavouritesModel!.status!=true)
      {
        if(favourites[productID]==true)
          favourites[productID]=false;
        else
          favourites[productID]=true;
      }else{
        getFavourites();
      }
      emit(ShopChangeFavouritesSuccessState());
    }).catchError((error){
      if(favourites[productID]==true)
        favourites[productID]=false;
      else
        favourites[productID]=true;
      print('error in changeFavourites==>$error');
      emit(ShopChangeFavouritesErrorState());
    });
  }

  LoginModel? userModel;
  void getUserData(){
    emit(ShopUserDataLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value){
      userModel=LoginModel.fromJson(value.data);
      print("name======>${userModel!.userData!.name}");
      emit(ShopUserDataSuccessState());
    }).catchError((error){
      print("error in getUserData===>$error");
      emit(ShopUserDataErrorState());
    });
  }

  void updateUser({
  @required String? name,
    @required String? email,
    @required String? phone,
}){
    emit(ShopUpdateUserLoadingState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        data: {
          'name':name,
          'email':email,
          'phone':phone,
        },
      token: token,
        ).then((value) {
          userModel=LoginModel.fromJson(value.data);
      emit(ShopUpdateUserSuccessState(userModel!));
    }).catchError((error){
      print("error in updateUser==>$error");
      emit(ShopUpdateUserErrorState());
    });
  }


  SearchModel? searchModel;
  void search(String? text){
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text':text,
        }
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      print(searchModel!.data!.data[0].name);
      emit(SearchSuccessState());
    }).catchError((error){
      print("error in search=====>$error");
      emit(SearchErrorState());
    });
  }
}