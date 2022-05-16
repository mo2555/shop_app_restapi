import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';

import '../../../../Cubit/ShopCubit/shop_cubit.dart';
import '../../../../Cubit/ShopCubit/shop_states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.categoriesModel != null,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemBuilder: (context, index) => Row(
                  children: [
                    // Image(
                    //   image: NetworkImage(
                    //     '${cubit.categoriesModel!.categoriesData!.data![index].image}',
                    //   ),
                    //   height: 100,
                    //   width: 100,
                    //   fit: BoxFit.fill,
                    // ),
                    fadeInImage(
                      networkImagePath:
                          '${cubit.categoriesModel!.categoriesData!.data![index].image}',
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${cubit.categoriesModel!.categoriesData!.data![index].name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 40,
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                ),
                itemCount: cubit.categoriesModel!.categoriesData!.data!.length,
              ),
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
