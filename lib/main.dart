// ignore_for_file: unnecessary_null_comparison, use_key_in_widget_constructors

import 'package:application_1/shop_app/constant/bloc_observer.dart';
import 'package:application_1/shop_app/constant/color/theme_screen.dart';
import 'package:application_1/shop_app/constant/constant_screen.dart';

import 'package:application_1/shop_app/cubit/app_cubit.dart';
import 'package:application_1/shop_app/cubit/app_states.dart';
import 'package:application_1/shop_app/onBoardingScreen/Screen/on_boarding_screen.dart';
import 'package:application_1/shop_app/screens/login/shop_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shop_app/constant/Netowrk/remotle/dio_helper.dart';

import 'shop_app/constant/Netowrk/locale/cash_helper.dart';
import 'shop_app/home layout/shop_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.inIt();
  await DioHelper.inIt();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token');
  print('????????????????? token ????????????????');
  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  //final bool isDark;
  final Widget startWidget;
  const MyApp({
    //this.isDark,
    required this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavorites()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
