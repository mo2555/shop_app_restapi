import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_cubit.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_states.dart';

import '../Models/home_model.dart';

class ProductsViewWidget extends StatelessWidget {
  const ProductsViewWidget({Key? key, required this.products})
      : super(key: key);
  final List<Products> products;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Container(
          color: Colors.grey,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 2 / 3.2,
            children: List.generate(
              products.length,
                  (index) =>
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          fadeInImage(networkImagePath: products[index].image
                              .toString(),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.fill),
                          if (products[index].discount != 0)
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
                        alignment: Alignment.bottomLeft,
                      ),
                      Flexible(
                        child: Container(
                          height: 110,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  products[index].description.toString(),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                    height: 1.2,
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      products[index].price.toString() + ' \$',
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
                                    if (products[index].discount != 0)
                                      Text(
                                        products[index].oldPrice.toString() +
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
                                        cubit.changeFavorites(products[index].id!);
                                      },
                                      child:  CircleAvatar(
                                        backgroundColor: cubit.favorites[products[index].id]==true?Colors.blue:Colors.grey,
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
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        );
      },
    );
  }
}
