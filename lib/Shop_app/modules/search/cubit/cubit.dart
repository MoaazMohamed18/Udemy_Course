import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shop_app/models/search_model.dart';
import 'package:todo/Shop_app/modules/search/cubit/states.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/network/end_points.dart';
import 'package:todo/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchModel model;

  void search(String text) {
    emit(SearchLoadingState());

    DioHelper.postData(
        url: SEARCH,
        token: token,
        data: {
          'text': text,
        }).then((value) {
          model = SearchModel.fromJson(value.data);

          emit(SearchSuccessState());
    }).catchError((error) {
      print('error in search --> ${error.toString()}');
      emit(SearchErrorState());
    });
  }

}