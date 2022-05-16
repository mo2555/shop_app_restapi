import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Cache/shared_preferences.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/LoginCubit/login_cubit.dart';
import 'package:shop_app_flutter/Screens/HomeScreens/HomePage/home_page.dart';
import 'package:shop_app_flutter/Screens/FirstPages/register_screen.dart';

import '../../Cubit/LoginCubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {
        if (state is AppLoginSuccessState) {
          if (state.loginModel.status == true) {
            CacheHelper.setToken(
                    key: 'token', value: state.loginModel.data!.token!)
                .then((value) {
                  if(value) {
                    token = state.loginModel.data!.token!;
                    navigatorAndReplace(context,const MyHomePage());
                messageToast(
                  msg: state.loginModel.message.toString(),
                  color: Colors.green,
                );
              }
                  else{
                    messageToast(
                      msg: state.loginModel.message.toString(),
                      color: Colors.red,
                    );
                  }
            });
          } else {
            messageToast(
              msg: state.loginModel.message.toString(),
              color: Colors.red,
            );
          }
        }
      },
      builder: (BuildContext context, state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontFamily: 'Loly',
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              fontFamily: 'Loly',
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Email must not be empty';
                          }
                          return null;
                        },
                        label: const Text('Email Address'),
                        prefix: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              emailAddress: emailController.text,
                              password: passwordController.text,
                            );
                            print('validate');
                          } else
                            return;
                        },
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Password must not be empty';
                          }
                          return null;
                        },
                        label: const Text('Password'),
                        prefix: const Icon(Icons.lock_outline_rounded),
                        suffix: cubit.passwordShown
                            ? GestureDetector(
                                child:
                                    const Icon(Icons.visibility_off_outlined),
                                onTap: () {
                                  cubit.changePasswordVisibility();
                                },
                              )
                            : GestureDetector(
                                child: const Icon(Icons.visibility_outlined),
                                onTap: () {
                                  cubit.changePasswordVisibility();
                                },
                              ),
                        isPassword: !cubit.passwordShown,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      state is AppLoginLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  color: Theme.of(context).buttonColor,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userLogin(
                                          emailAddress: emailController.text,
                                          password: passwordController.text,
                                        );
                                        print('validate');
                                      } else
                                        return;
                                    },
                                    child: Text(
                                      'LOGIN',
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don\'t have an account?',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    textButton(
                                      () {
                                        navigatorAndReplace(
                                            context, RegisterScreen());
                                      },
                                      'REGISTER',
                                      context,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
