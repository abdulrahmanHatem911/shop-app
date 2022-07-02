// ignore_for_file: import_of_legacy_library_into_null_safe, unused_import, avoid_print

import 'package:application_1/shop_app/constant/color/theme_screen.dart';
import 'package:application_1/shop_app/constant/constant_screen.dart';
import 'package:application_1/shop_app/constant/Netowrk/locale/cash_helper.dart';
import 'package:application_1/shop_app/home%20layout/shop_layout.dart';
import 'package:application_1/shop_app/screens/login/cubit/login_state.dart';
import 'package:application_1/shop_app/screens/regester/regester_screen.dart';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubit/login_cubit.dart';

var emailController = TextEditingController();
var passowrdController = TextEditingController();
var formKey = GlobalKey<FormState>();

class ShopLoginScreen extends StatelessWidget {
  const ShopLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.data!.token);
              print(state.loginModel.message);
              print('??????----------SACSSES---------?????');
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                showToast(
                  text: state.loginModel.message,
                  state: ToastStates.SUCSSES,
                );
                navigateToFinish(context, const ShopLayout());
              });
            } else {
              print('?????----------ERROR---------?????');
              print(state.loginModel.message);
              //ده علشان يظهر الرسالة الي بتكون تحت والي بتبين اذا الدخول نجح ولا لا
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          // the cubit for use
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          //
          return Scaffold(
            appBar: AppBar(
              title: const Text('Login Screen'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      color: Colors.black,
                                    ),
                          ),
                          Text(
                            'Login now to brows our hot offers',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Colors.grey,
                                      fontSize: 16.0,
                                    ),
                          ),
                          const SizedBox(height: 30.0),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'enter your email',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter youre email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            controller: passowrdController,
                            obscureText: cubit.isPassword,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'enter your password',
                              prefixIcon:
                                  const Icon(Icons.lock_outline_rounded),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                                icon: (Icon(cubit.suffix)),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                            onFieldSubmitted: (value) {
                              if (formKey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passowrdController.text,
                                );
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is to short ';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15.0),
                          ConditionalBuilder(
                            condition: state is! ShopLoginLoadingState,
                            fallback: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            builder: (context) => Container(
                              width: double.infinity,
                              color: defultColor,
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passowrdController.text,
                                    );
                                  }
                                  navigateTo(context, ShopLayout());
                                },
                                child: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don'nt have acount "),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegesterScreen());
                                  },
                                  child: const Text('Regester'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
