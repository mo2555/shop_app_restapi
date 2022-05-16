import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/SearchCubit/search_cubit.dart';
import 'package:shop_app_flutter/Cubit/SearchCubit/search_states.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: ListView(
              children: [
                defaultFormField(
                  onChanged: (value) {
                    cubit.search(value);
                  },
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'You must enter a text';
                    }
                    return null;
                  },
                  label: const Text('Search'),
                  prefix: const Icon(Icons.search),
                ),
                const SizedBox(
                  height: 20,
                ),
                 if(state is SearchLoadingState)
                   const LinearProgressIndicator(),
                if(state is SearchLoadingState)
                  const SizedBox(
                  height: 20,
                ),
                if(cubit.searchModel!=null)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Row(
                        children: [
                          fadeInImage(
                            networkImagePath:
                                '${cubit.searchModel!.data!.data![index].image}',
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.searchModel!.data!.data![index]
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
                                        cubit.searchModel!.data!.data![index]
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
                                      const Spacer(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => Container(
                      height: 1,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      color: Colors.grey,
                    ),
                    itemCount: cubit.searchModel!.data!.data!.length,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
