import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/RegisterCubit/register_cubit.dart';
import 'package:shop_app_flutter/Cubit/LoginCubit/login_cubit.dart';
import 'package:shop_app_flutter/Cubit/SearchCubit/search_cubit.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_cubit.dart';
import 'package:shop_app_flutter/Screens/FirstPages/login_screen.dart';
import 'package:shop_app_flutter/Screens/FirstPages/on_boarding_screen.dart';

import 'Cache/shared_preferences.dart';
import 'Screens/HomeScreens/HomePage/home_page.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  bool toLogin = await CacheHelper.getData(key: 'onBoarding');
  String? toHome = await CacheHelper.getToken(key: 'token');
  token = toHome;

  Widget screen;
  if(toLogin==true){
    if(toHome!=null){
      screen = const MyHomePage();
    }else{
      screen = LoginScreen();
    }
  }
  else{
    screen = OnBoardingScreen();
  }
  runApp( MyApp(screen: screen,),);
}

class MyApp extends StatelessWidget {
  final screen;
  const MyApp({Key? key, this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>AppCubit()..getUserData()),
        BlocProvider(create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()),
        BlocProvider(create: (context)=>RegisterCubit()..getUserData(),),
          BlocProvider(create: (context)=>SearchCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        home: screen,
      ),
    );
  }
}
