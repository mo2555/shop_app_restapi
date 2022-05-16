import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Cubit/RegisterCubit/register_states.dart';

import '../../Cache/shared_preferences.dart';
import '../../Consts/consts.dart';
import '../../Cubit/RegisterCubit/register_cubit.dart';
import '../HomeScreens/HomePage/home_page.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel.status == true) {
            CacheHelper.setToken(
                    key: 'token', value: state.registerModel.data!.token!)
                .then((value) {
              if (value) {
                token = state.registerModel.data!.token!;
                navigatorAndReplace(context, const MyHomePage());
                messageToast(
                  msg: state.registerModel.message.toString(),
                  color: Colors.green,
                );
              } else {
                messageToast(
                  msg: state.registerModel.message.toString(),
                  color: Colors.red,
                );
              }
            });
          } else {
            messageToast(
              msg: state.registerModel.message.toString(),
              color: Colors.red,
            );
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        RegisterCubit cubit = RegisterCubit.get(context);
        return Scaffold(
            body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
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
                        'register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                              fontFamily: 'Loly',
                            ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        textStyle: const TextStyle(
                          fontFamily: 'Loly',
                          fontWeight: FontWeight.bold,
                        ),
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'User Name must not be empty';
                          }
                          return null;
                        },
                        label: const Text('User Name'),
                        prefix: const Icon(Icons.person),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        textStyle: const TextStyle(
                          fontFamily: 'Loly',
                          fontWeight: FontWeight.bold,
                        ),
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
                        textStyle: const TextStyle(
                          fontFamily: 'Loly',
                          fontWeight: FontWeight.bold,
                        ),
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
                        suffix: cubit.passwordRegisterShown
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
                        isPassword: !cubit.passwordRegisterShown,

                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      defaultFormField(
                        textStyle: const TextStyle(
                          fontFamily: 'Loly',
                          fontWeight: FontWeight.bold,
                        ),
                        controller: phoneController,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'Phone must not be empty';
                          }
                          return null;
                        },
                        label: const Text('Phone'),
                        prefix: const Icon(Icons.phone),
                        onSubmit: (value) {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              emailAddress: emailController.text,
                              password: passwordController.text,
                              userName: nameController.text,
                              phone: phoneController.text,
                            );
                            print('validate');
                          } else
                            return;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      state is RegisterLoadingState?const Center(
                        child: CircularProgressIndicator(),
                      ):
                      Column(
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            color: Theme.of(context).buttonColor,
                            child: MaterialButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    emailAddress: emailController.text,
                                    password: passwordController.text,
                                    userName: nameController.text,
                                    phone: phoneController.text,
                                  );
                                  print('validate');
                                } else
                                  return;
                              },
                              child: Text(
                                'REGISTER',
                                style: Theme.of(context).textTheme.bodyText2,
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
                                'Already have an account?',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              textButton(
                                    () {
                                  navigatorAndReplace(context, LoginScreen());
                                },
                                'LOGIN',
                                context,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
      },
    );
  }
}
