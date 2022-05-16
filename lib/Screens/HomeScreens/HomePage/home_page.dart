import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_cubit.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_states.dart';

import '../SearchScreen/search_screen.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {
      },
      builder: (BuildContext context, Object? state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla'),
            actions: [
              IconButton(onPressed: (){
                navigatorTo(context,  SearchScreen());
              }, icon: const Icon(Icons.search),),
            ],
          ),
         body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: cubit.bottomNavigationBarItem,
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
          ),
        );
      },
    );
  }
}
