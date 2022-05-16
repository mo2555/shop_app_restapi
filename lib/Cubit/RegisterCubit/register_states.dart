import 'package:shop_app_flutter/Models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  final LoginModel registerModel;

  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterStates {
  final error;

  RegisterErrorState(this.error);
}

class RegisterChangePasswordState extends RegisterStates {}
//
// class AppSignOutLoadingState extends RegisterStates {}
//
// class AppSignOutSuccessState extends RegisterStates {
// }
//
// class AppSignOutErrorState extends RegisterStates {
//   final error;
//
//   AppSignOutErrorState(this.error);
// }
//
class RegisterProfileLoadingState extends RegisterStates {}

class RegisterProfileSuccessState extends RegisterStates {
  final LoginModel userData;

  RegisterProfileSuccessState(this.userData);
}

class RegisterProfileErrorState extends RegisterStates {
  final error;

  RegisterProfileErrorState(this.error);
}
