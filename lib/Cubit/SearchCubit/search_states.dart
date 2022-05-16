abstract class SearchStates{}

class SearchInitialState extends SearchStates{}

class SearchLoadingState extends SearchStates{}

class SearchSuccessState extends SearchStates{}

class SearchErrorState extends SearchStates{}

class ShopHomeLoadingState extends SearchStates{}

class ShopHomeSuccessState extends SearchStates{}

class ShopHomeErrorState extends SearchStates{}

class ShopFavoritesSuccessState extends SearchStates{}

class ShopFavoritesErrorState extends SearchStates{}

class ShopGetFavoritesLoadingState extends SearchStates{}

class ShopGetFavoritesSuccessState extends SearchStates{}

class ShopGetFavoritesErrorState extends SearchStates{}