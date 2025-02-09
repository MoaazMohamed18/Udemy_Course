import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shop_app/cubit/states.dart';
import 'package:todo/Shop_app/models/categories_model.dart';
import 'package:todo/Shop_app/models/changeFav_model.dart';
import 'package:todo/Shop_app/models/favorites_model.dart';
import 'package:todo/Shop_app/models/home_model.dart';
import 'package:todo/Shop_app/models/login_model.dart';
import 'package:todo/Shop_app/modules/categories/categories_screen.dart';
import 'package:todo/Shop_app/modules/favorites/favorites_screen.dart';
import 'package:todo/Shop_app/modules/products/products_screen.dart';
import 'package:todo/Shop_app/modules/settings/settings_screen.dart';
import 'package:todo/shared/components/constants.dart';
import 'package:todo/shared/network/end_points.dart';
import 'package:todo/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> BottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('Error is ---> ${error.toString()}');
      emit(ShopErrorHomeDataState());
    });
  }

  late CategoriesModel categoriesModel;

  void getCategories() {
    DioHelper.getData(url: GET_CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print('Error is ---> ${error.toString()}');
      emit(ShopErrorCategoriesState());
    });
  }

  late ChangeFavoritesModel changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;

    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
          'product_id':productId,
        },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if(!changeFavoritesModel.status){
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }

      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print('Error is in getFavorites() ---> ${error.toString()}');
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());

    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print('Error is in getUserData ---> ${error.toString()}');
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataState());

    DioHelper.putData(url: UPDATE_PROFILE, token: token,
        data: {
      'name': name,
      'email': email,
      'phone': phone,
        }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserDataState(userModel!));
    }).catchError((error) {
      print('Error is in getUserData ---> ${error.toString()}');
      emit(ShopErrorUpdateUserDataState());
    });
  }
}
