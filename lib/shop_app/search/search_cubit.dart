import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_try/models/search_model.dart';
import 'package:last_try/network/remote/END_POINTS.dart';
import 'package:last_try/network/remote/dio_helper.dart';
import 'package:last_try/shared/constants.dart';
import 'package:last_try/shop_app/search/search_states.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

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