import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Models/login_model.dart';
import 'package:shop_app_flutter/Network/dio_helper.dart';

import '../../Cache/shared_preferences.dart';
import '../../Consts/consts.dart';
import '../../Screens/FirstPages/login_screen.dart';
import 'login_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool passwordShown = false;

  late LoginModel loginModel;

   LoginModel? userData;

  getUserData() {
    emit(AppLProfileLoadingState());

    DioHelper.getData(
            url: 'profile',
            token: token,
    )
        .then((value) {
      print(value.toString());
      userData = LoginModel.fromJson(value.data);
      print(userData!.data);
      emit(AppProfileSuccessState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(AppProfileErrorState(error.toString()));
    });
  }

  userLogin({
    required String emailAddress,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    DioHelper.postData(
        url: 'login',
        data: {
          'email': emailAddress,
          'password': password,
        },
        lang: 'en')
        .then((value) {
      print(value.toString());
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data);
      emit(AppLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppLoginErrorState(error.toString()));
    });
  }

  changePasswordVisibility() {
    passwordShown = !passwordShown;
    emit(AppChangePasswordState());
  }

  signOut(BuildContext context) {
    emit(AppSignOutLoadingState());
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        print(value);
        navigatorAndReplace(context, LoginScreen());
        emit(AppSignOutSuccessState());
      }
    }).catchError((error) {
      print(error.toString());
      emit(AppSignOutErrorState(error.toString()));
    });
  }

  //update-profile

  updateUserProfile({
    required String emailAddress,
    required String phone,
    required String name,

  }) async {
    emit(AppUpdateProfileLoadingState());

    DioHelper.updateData(
        url: 'update-profile',
        data: {
          'name':name,
          'email': emailAddress,
          'phone':phone,
        },
        token: token,
    )
        .then((value) {
      print(value.toString());
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel.data);
      emit(AppUpdateProfileSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppUpdateProfileErrorState(error.toString()));
    });
  }
}
