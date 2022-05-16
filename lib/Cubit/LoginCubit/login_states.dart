import 'package:shop_app_flutter/Models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppLoginLoadingState extends AppStates {}

class AppLoginSuccessState extends AppStates {
  final LoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}

class AppLoginErrorState extends AppStates {
  final error;

  AppLoginErrorState(this.error);
}

class AppChangePasswordState extends AppStates {}

class AppSignOutLoadingState extends AppStates {}

class AppSignOutSuccessState extends AppStates {
}

class AppSignOutErrorState extends AppStates {
  final error;

  AppSignOutErrorState(this.error);
}

class AppLProfileLoadingState extends AppStates {}

class AppProfileSuccessState extends AppStates {
  final LoginModel userData;

  AppProfileSuccessState(this.userData);
}

class AppProfileErrorState extends AppStates {
  final error;

  AppProfileErrorState(this.error);
}

class AppUpdateProfileLoadingState extends AppStates {}

class AppUpdateProfileSuccessState extends AppStates {
  final LoginModel userData;

  AppUpdateProfileSuccessState(this.userData);
}

class AppUpdateProfileErrorState extends AppStates {
  final error;

  AppUpdateProfileErrorState(this.error);
}

