import 'package:application_1/shop_app/model/shop_app/change_favourites_model.dart';
import 'package:application_1/shop_app/model/shop_app/login_model.dart';

abstract class AppStates {}

class AppinInitialStates extends AppStates {}
// to change in the botton navigation

class ChangeBottomNavigationState extends AppStates {}

class ShopLoadingHomeDataState extends AppStates {}

class ShopSuccessHomeDataState extends AppStates {}

class ShopErroroHomeDataState extends AppStates {}

// for Categories data

class ShopSuccessCategoriesState extends AppStates {}

class ShopErroroCategoriesState extends AppStates {}

class ShopSuccessChangeFavoritesState extends AppStates {
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesState(
    this.model,
  );
}

class ShopChangeFavoritesState extends AppStates {}

class ShopErrorChangeFavoritesState extends AppStates {}

class ShopLoadingGetFavoritesState extends AppStates {}

class ShopSuccessGetFavoritesState extends AppStates {}

class ShopErrorGetFavoritesState extends AppStates {}

// FOR sHOP LOADING

class ShopLoadingUserDataState extends AppStates {}

class ShopSuccessUserDataState extends AppStates {
  final ShopLoginModel loginModel;
  ShopSuccessUserDataState(
    this.loginModel,
  );
}

class ShopErrorUserDataState extends AppStates {}

// USER UPDATE DATA

class ShopLoadingUpdateUserState extends AppStates {}

class ShopSuccessUpdateUserState extends AppStates {
  final ShopLoginModel loginModel;
  ShopSuccessUpdateUserState(
    this.loginModel,
  );
}

class ShopErrorUpdateUserState extends AppStates {}
