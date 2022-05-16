import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Cubit/SearchCubit/search_states.dart';
import 'package:shop_app_flutter/Models/search_model.dart';
import 'package:shop_app_flutter/Network/dio_helper.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? searchModel;


  search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(url: 'products/search', data: {
      'text':text,
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.status);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }


}