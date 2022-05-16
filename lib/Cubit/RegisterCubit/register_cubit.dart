import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Cubit/RegisterCubit/register_states.dart';
import 'package:shop_app_flutter/Models/login_model.dart';
import 'package:shop_app_flutter/Network/dio_helper.dart';

import '../../Consts/consts.dart';


class RegisterCubit extends Cubit<RegisterStates> {

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool passwordRegisterShown = false;

  late LoginModel registerModel;

  LoginModel? userData;

  getUserData() {
    emit(RegisterProfileLoadingState());

    DioHelper.getData(
            url: 'profile',
            token: token,
    )
        .then((value) {
      print(value.toString());
      userData = LoginModel.fromJson(value.data);
      print(userData!.data);
      emit(RegisterProfileSuccessState(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterProfileErrorState(error.toString()));
    });
  }

  userRegister({
    required String emailAddress,
    required String password,
    required String userName,
    required String phone,
  }) {
    emit(RegisterLoadingState());

    DioHelper.postData(
        url: 'register',
        data: {
          'name':userName,
          'phone':phone,
          'email': emailAddress,
          'password': password,
        },
    )
        .then((value) {
      print(value.toString());
      registerModel = LoginModel.fromJson(value.data);
      print(registerModel.data);
      emit(RegisterSuccessState(registerModel));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  changePasswordVisibility() {
    passwordRegisterShown = !passwordRegisterShown;
    emit(RegisterChangePasswordState());
  }
  //
  // signOut(BuildContext context) {
  //   emit(AppSignOutLoadingState());
  //   CacheHelper.removeData(key: 'token').then((value) {
  //     if (value) {
  //       print(value);
  //       navigatorAndReplace(context, LoginScreen());
  //       emit(AppSignOutSuccessState());
  //     }
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AppSignOutErrorState(error.toString()));
  //   });
  // }
}
