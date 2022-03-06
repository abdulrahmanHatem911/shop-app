// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import

import 'package:application_1/shop_app/constant/color/theme_screen.dart';
import 'package:application_1/shop_app/cubit/app_cubit.dart';
import 'package:application_1/shop_app/cubit/app_states.dart';
import 'package:application_1/shop_app/model/shop_app/home_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/constant_screen.dart';
import '../../model/shop_app/categories_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (!state.model.status!) {
            showToast(
              text: state.model.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => productsBuilder(
            cubit.homeModel,
            cubit.categoriesModel,
            context,
          ),
        );
      },
    );
  }

  Widget productsBuilder(
    HomeModel? model,
    CategoriesModel? category,
    context,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model!.data!.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10.0),
          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                // عرض الايتم داخل اليست
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildCategoriesItem(category!.data!.data[index]),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10.0,
                    ),
                    itemCount: category!.data!.data.length,
                  ),
                ),
                // new productes
                const SizedBox(height: 20.0),
                const Text(
                  'New Productes',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ),
          // the GridView to display
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 1.5,
              shrinkWrap: true,
              //اول رقم بيمثل العرض و التاني بيمثل الطول
              childAspectRatio: 1 / 1.58,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data!.products.length,
                (index) => buildGrideViewForItemes(
                    model.data!.products[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // build the grid items to desplay
  Widget buildCategoriesItem(DataModel model) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
          width: 100.0,
          height: 100.0,
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          width: 100.0,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget buildGrideViewForItemes(ProductModel model, context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
              ),
              if (model.discount != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  color: Colors.red,
                  child: const Text(
                    'DESCOUNT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.2,
                  ),
                ),

                // علشان يعرصض السعر الخاص بالمنتجات
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(
                        color: defultColor,
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          AppCubit.get(context).changeFavorites(model.id);
                          print(model.id);
                        },
                        icon: AppCubit.get(context).favourites[model.id]!
                            ? const CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.favorite,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                              )
                            : const CircleAvatar(
                                radius: 15.0,
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 17.0,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
