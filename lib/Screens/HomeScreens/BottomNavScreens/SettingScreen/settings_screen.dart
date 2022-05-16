import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_flutter/Consts/consts.dart';
import 'package:shop_app_flutter/Cubit/LoginCubit/login_cubit.dart';

import '../../../../Cubit/LoginCubit/login_states.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    AppCubit.get(context).getUserData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is AppProfileSuccessState ) {
          if (state.userData.status == true) {
            nameController.text = state.userData.data!.name.toString();
            phoneNumberController.text = state.userData.data!.phone.toString();
            emailController.text = state.userData.data!.email.toString();
          } else {
            messageToast(
                msg: state.userData.message.toString(), color: Colors.red);
          }
        }
        if (state is AppUpdateProfileSuccessState ) {
          if (state.userData.status == true) {
            nameController.text = state.userData.data!.name.toString();
            phoneNumberController.text = state.userData.data!.phone.toString();
            emailController.text = state.userData.data!.email.toString();
            messageToast(
                msg: state.userData.message.toString(), color: Colors.green);
          } else {
            messageToast(
                msg: state.userData.message.toString(), color: Colors.red);
          }
        }
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.userData != null,
          fallback: (BuildContext context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (BuildContext context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is AppUpdateProfileLoadingState)
                      const LinearProgressIndicator(),
                    if(state is AppUpdateProfileLoadingState)
                      const SizedBox(height: 20,),

                    defaultFormField(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Loly',
                      ),
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Name must not be empty';
                        }
                        return null;
                      },
                      label: const Text('Name'),
                      prefix: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Loly',
                      ),
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address must not be empty';
                        }
                        return null;
                      },
                      label: const Text('Email Address'),
                      prefix: const Icon(Icons.email),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    defaultFormField(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Loly',
                      ),
                      controller: phoneNumberController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      label: const Text('Phone'),
                      prefix: const Icon(Icons.phone),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Theme.of(context).buttonColor,
                      child: MaterialButton(
                        onPressed: ()async {
                          if (formKey.currentState!.validate()) {
                            await cubit.updateUserProfile(
                              emailAddress: emailController.text,
                              phone: phoneNumberController.text,
                              name: nameController.text,
                            );
                            print('validate');
                          }
                          return;
                        },
                        child: Text(
                          'UPDATE',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      color: Theme.of(context).buttonColor,
                      child: MaterialButton(
                        onPressed: () {
                          cubit.signOut(context);
                        },
                        child: Text(
                          'LOGOUT',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
