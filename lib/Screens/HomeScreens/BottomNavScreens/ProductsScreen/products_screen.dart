import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_cubit.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_states.dart';
import 'package:shop_app_flutter/Widgets/products_categories_widget.dart';
import 'package:shop_app_flutter/Widgets/products_view_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        print('token = ' + token.toString());
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) {
            return ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                CarouselSlider(
                  items: cubit.homeModel?.data?.banners!
                      .map(
                        (banner) =>
                            //     Image(
                            //   image: NetworkImage(banner.image.toString()),
                            //   width: double.infinity,
                            //   fit: BoxFit.cover,
                            // ),
                            fadeInImage(
                          networkImagePath: banner.image.toString(),
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    height: 250,
                    initialPage: 0,
                    reverse: false,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 3),
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    viewportFraction: 1,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //Cat
                ProductsCategoriesWidget(
                  data: cubit.categoriesModel!.categoriesData!.data!,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'New Products',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //product
                ProductsViewWidget(products: cubit.homeModel!.data!.products!),
              ],
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
/* Container(
                  color: Colors.grey,
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(
                      cubit.homeModel!.data!.products!.length,
                      (index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            children: [
                              Image(
                                image: NetworkImage(cubit
                                    .homeModel!.data!.products![index].image
                                    .toString()),
                                width: double.infinity,
                                fit: BoxFit.fill,
                                height: 200,
                              ),
                              if (cubit.homeModel!.data!.products![index]
                                      .discount !=
                                  0)
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
                          // Container(
                          //   height: 2,
                          //   width: double.infinity,
                          //   color: Colors.grey,
                          //   margin: const EdgeInsets.symmetric(horizontal: 10,),
                          // ),
                          Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    cubit.homeModel!.data!.products![index]
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        cubit.homeModel!.data!.products![index]
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
                                      if (cubit.homeModel!.data!
                                              .products![index].discount !=
                                          0)
                                        Text(
                                          cubit.homeModel!.data!
                                                  .products![index].oldPrice
                                                  .toString() +
                                              ' \$',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10,
                                              overflow: TextOverflow.ellipsis,
                                              height: 1.2,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                          maxLines: 1,
                                        ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.favorite_border,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2 / 3.07,
                  ),
                ),*/

/*Container(
                  height: 100,
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image(
                          image: NetworkImage(
                            '${cubit.categoriesModel!.categoriesData!.data![index].image}',
                          ),
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          width: 100,
                          color: Colors.black54,
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            '${cubit.categoriesModel!.categoriesData!.data![index].name}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: cubit.categoriesModel!.categoriesData!.data!.length,
                  ),
                ),*/
