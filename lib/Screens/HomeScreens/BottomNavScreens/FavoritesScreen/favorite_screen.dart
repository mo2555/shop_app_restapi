import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_states.dart';

import '../../../../Cubit/ShopCubit/shop_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.favoritesScreen.isNotEmpty,
          builder: (BuildContext context) =>
             Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemBuilder: (context, index) =>
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              fadeInImage(
                                networkImagePath:
                                '${cubit.favoritesScreen[index].product!
                                    .image}',
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                              if (cubit.favoritesScreen[index].product!
                                  .discount != 0)
                                Container(
                                  color: Colors.red,
                                  padding: const EdgeInsets.all(5),
                                  child: const Text(
                                    'DISCOUNT',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.favoritesScreen[index].product!
                                        .description
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                      height: 1.2,
                                    ),
                                    maxLines: 2,
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        cubit.favoritesScreen[index].product!
                                            .price
                                            .toString() +
                                            ' \$',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          overflow: TextOverflow.ellipsis,
                                          height: 1.2,
                                        ),
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      if (cubit.favoritesScreen[index].product!
                                          .discount !=
                                          0)
                                        Text(
                                          cubit.favoritesScreen[index].product!
                                              .oldPrice
                                              .toString() +
                                              ' \$',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis,
                                              height: 1.2,
                                              decoration: TextDecoration
                                                  .lineThrough),
                                          maxLines: 1,
                                        ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          cubit.changeFavorites(
                                              cubit.favoritesScreen[index]
                                                  .product!.id!);
                                        },
                                        child: CircleAvatar(
                                          backgroundColor: cubit.favorites[cubit
                                              .favoritesScreen[index].product!
                                              .id] == true
                                              ? Colors.blue
                                              : Colors.grey,
                                          radius: 15,
                                          child: const Icon(
                                            Icons.favorite_border,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) =>
                    Container(
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: Colors.grey,
                    ),
                itemCount: cubit.favoritesScreen.length,
              ),
            )
          ,
          fallback: (BuildContext context) => const Center(
              child: Text('You don\'t add any products to favorites.',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Loly',
                color: Colors.blue,
              ),
              ),
          ),

        );
      },
    );
  }
}

