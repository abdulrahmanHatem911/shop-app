import 'package:application_1/shop_app/constant/Netowrk/end_point.dart';
import 'package:application_1/shop_app/constant/Netowrk/remotle/dio_helper.dart';
import 'package:application_1/shop_app/constant/constant_screen.dart';
import 'package:application_1/shop_app/model/shop_app/search_model.dart';
import 'package:application_1/shop_app/screens/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
