// ignore_for_file: avoid_print

import 'package:application_1/shop_app/constant/Netowrk/end_point.dart';
import 'package:application_1/shop_app/constant/Netowrk/remotle/dio_helper.dart';
import 'package:application_1/shop_app/constant/constant_screen.dart';
import 'package:application_1/shop_app/cubit/app_states.dart';
import 'package:application_1/shop_app/model/shop_app/categories_model.dart';
import 'package:application_1/shop_app/model/shop_app/home_model.dart';
import 'package:application_1/shop_app/model/shop_app/login_model.dart';
import 'package:application_1/shop_app/screens/products/products_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/shop_app/change_favourites_model.dart';
import '../model/shop_app/favorites_model.dart';
import '../screens/categories/categories_screen.dart';
import '../screens/favourites/favourites_screen.dart';
import '../screens/settings/setting_screeen.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppinInitialStates());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    FavoritesScreen(),
    SettingScreeen(),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavigationState());
  }

  // احنا هنستقبل البيانات كلها هنا
  HomeModel? homeModel;
  Map<int, bool> favourites = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //كدا هيبدا يطبع الببيانات كلها هنا ));
      // print(homeModel!.data!.banners[2].image);

      homeModel!.data!.products.forEach(
        (element) {
          favourites.addAll({
            element.id: element.inFavorites,
          });
        },
      );
      print('/---------------Fav--------------------/');
      print(favourites.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErroroHomeDataState());
    });
  }

  // احنا هنستقبل البيانات كلها هنا
  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJason(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErroroCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favourites[productId] = favourites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      if (!changeFavoritesModel!.status!) {
        favourites[productId] = favourites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error) {
      favourites[productId] = favourites[productId]!;

      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(userModel.data.name);

      // userModel!
      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

// to update the data in the app

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //printFullText(userModel!.data!.name!);

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
