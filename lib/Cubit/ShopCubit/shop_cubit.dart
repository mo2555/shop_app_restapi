import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Cache/shared_preferences.dart';
import 'package:shop_app_flutter/Cubit/ShopCubit/shop_states.dart';
import 'package:shop_app_flutter/Models/categories_model.dart';
import 'package:shop_app_flutter/Models/favorites_model.dart';
import 'package:shop_app_flutter/Models/get_favorites_model.dart';
import 'package:shop_app_flutter/Models/home_model.dart';
import 'package:shop_app_flutter/Network/dio_helper.dart';

import '../../Consts/consts.dart';
import '../../Screens/HomeScreens/BottomNavScreens/CategoriesScreen/categories_screen.dart';
import '../../Screens/HomeScreens/BottomNavScreens/FavoritesScreen/favorite_screen.dart';
import '../../Screens/HomeScreens/BottomNavScreens/ProductsScreen/products_screen.dart';
import '../../Screens/HomeScreens/BottomNavScreens/SettingScreen/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List screens =  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.apps,
        ),
        label: 'Categories'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'Settings'),
  ];

  HomeModel? homeModel;

  CategoriesModel? categoriesModel;

  Map<int?, bool?> favorites = {};
  List<DataProducts> favoritesScreen = [];

  FavoritesModel? favoritesModel;

  GetFavoritesModel? getFavoritesModel;

  changeIndex(index) {
    currentIndex = index;
    emit(ShopBottomNavState());
  }

  getHomeData() {
    emit(ShopHomeLoadingState());
    CacheHelper.getToken(key: 'token')?.then((value) {
      token = value;
      DioHelper.getData(url: 'home', token: token).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data!.products!.forEach((product) {
          favorites.addAll({
            product.id: product.inFavorites,
          });
        });
        print(favorites);
        print(homeModel?.status);
        print(homeModel?.message);
        print(homeModel?.data!.products?[0].name);
        printFullText(homeModel.toString());
        emit(ShopHomeSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(ShopHomeErrorState());
      });
    });
  }

  getCategoriesData() {
    emit(ShopCategoriesLoadingState());
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel?.status);
      print(categoriesModel?.message);
      print(categoriesModel?.categoriesData!.data);
      printFullText(homeModel.toString());
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState());
    });
  }

  changeFavorites(int productId) {
    var saveElement;
    favorites[productId] = !favorites[productId]!;
    if (favorites[productId] == true) {
      homeModel!.data!.products!.forEach((element) {
        if (element.id == productId) {
          favoritesScreen.add(
            DataProducts(
              product: Product(
                id: element.id,
                price: element.price,
                oldPrice: element.oldPrice,
                description: element.description,
                discount: element.discount,
                image: element.image,
                name: element.name,
              ),
            ),
          );
        }
      });
    } else {
      favoritesScreen.removeWhere((element) {
        saveElement = element;
        return element.product!.id == productId;
      });
    }

    emit(ShopFavoritesSuccessState());
    DioHelper.postData(
      url: 'favorites',
      data: {
        "product_id": productId,
      },
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      if (favoritesModel!.status != true) {
        favorites[productId] = !favorites[productId]!;
        favoritesScreen.add(saveElement);
        messageToast(
            msg: favoritesModel!.message.toString(), color: Colors.red);
      } else {
        messageToast(
            msg: favoritesModel!.message.toString(), color: Colors.green);
      }
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      favoritesScreen.add(saveElement);
      messageToast(msg: error.toString(), color: Colors.red);
      emit(ShopFavoritesErrorState());
    });
  }

  getFavoritesData() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      getFavoritesModel!.data!.data!.forEach((element) {
        favoritesScreen.add(element);
      });
      print('getFavoritesModel = ${getFavoritesModel?.status}');
      print(getFavoritesModel?.message);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }
}
