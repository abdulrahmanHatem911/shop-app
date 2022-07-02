import 'package:flutter/material.dart';

import '../../../cubit/app_cubit.dart';
import '../../../model/shop_app/favorites_model.dart';

Widget buildListProduct(FavoritesData model, context) {
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product!.image),
                width: 120.0,
                height: 120.0,
              ),
              if (model.product!.discount != 0)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product!.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.product!.price}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    if (model.product!.discount != 0)
                      Text(
                        '${model.product!.oldPrice}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    Expanded(
                      child: IconButton(
                          icon: AppCubit.get(context)
                                  .favourites[model.product!.id]!
                              ? const Icon(
                                  Icons.favorite,
                                  size: 17.0,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  size: 17.0,
                                  // color: Colors.white,
                                ),
                          onPressed: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
