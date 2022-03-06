import 'package:application_1/shop_app/constant/constant_screen.dart';
import 'package:application_1/shop_app/cubit/app_cubit.dart';
import 'package:application_1/shop_app/cubit/app_states.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/color/theme_screen.dart';

var formKey = GlobalKey<FormState>();

class SettingScreeen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataState) {}
      },
      builder: (context, state) {
        // thecubit
        var cubit = AppCubit.get(context);
        AppCubit cubit_2 = AppCubit.get(context);
        nameController.text = cubit_2.userModel!.data!.name;
        emailController.text = AppCubit.get(context).userModel!.data!.email;
        phoneController.text = AppCubit.get(context).userModel!.data!.phone;
        return ConditionalBuilder(
          condition: cubit.userModel != null,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // ده بيظهر الخط لما بتعمل تعديل علي البيانات الي موجوده
                    if (state is ShopLoadingUpdateUserState)
                      const LinearProgressIndicator(),
                    const SizedBox(height: 20.0),
                    // for mame
                    TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'name must be founde';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'email must be founde';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone must be founde';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),

                    // BOTTTUN UPDATA
                    Container(
                      width: double.infinity,
                      color: defultColor,
                      child: MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            AppCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        child: const Text(
                          'UPDATA',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // BOTTUN SIGN OUT
                    Container(
                      width: double.infinity,
                      color: defultColor,
                      child: MaterialButton(
                        onPressed: () {
                          signOut(context);
                        },
                        child: const Text(
                          'LOGOUT',
                          style: TextStyle(color: Colors.white, fontSize: 20),
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
