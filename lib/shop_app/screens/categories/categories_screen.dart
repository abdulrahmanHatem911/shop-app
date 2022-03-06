import 'package:application_1/shop_app/cubit/app_cubit.dart';
import 'package:application_1/shop_app/cubit/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/shop_app/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // the cubit for data
        AppCubit cubit = AppCubit.get(context);
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCategoriesItem(
              cubit.categoriesModel!.data!.data[index], context),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: const SizedBox(
                height: 1.0,
              ),
              color: Colors.black45,
            ),
          ),
          itemCount: cubit.categoriesModel!.data!.data.length,
        );
      },
    );
  }

  Widget buildCategoriesItem(DataModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(
              model.image,
            ),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 20.0),
          // text
          Expanded(
            child: Text(
              model.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios_outlined,
          ),
        ],
      ),
    );
  }
}
