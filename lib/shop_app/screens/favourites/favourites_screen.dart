import 'package:application_1/shop_app/cubit/app_cubit.dart';
import 'package:application_1/shop_app/cubit/app_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';

import '../../model/shop_app/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! ShopLoadingGetFavoritesState,
          widgetBuilder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => buildListProduct(
              cubit.favoritesModel!.data!.data![index],
              context,
            ),
            separatorBuilder: (context, index) => Container(),
            itemCount: cubit.favoritesModel!.data!.data!.length,
          ),
          fallbackBuilder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
