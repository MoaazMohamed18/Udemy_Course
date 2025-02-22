import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/Shop_app/cubit/cubit.dart';
import 'package:todo/Shop_app/cubit/states.dart';
import 'package:todo/shared/components/components.dart';
import 'package:todo/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel!;

        nameController.text = model.data!.name;
        emailController.text = model.data!.email;
        phoneController.text = model.data!.phone;

        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserDataState)
                    const LinearProgressIndicator(),
                    const SizedBox(
                      height: 20.0,
                    ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefix: Icons.alternate_email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'email must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone Number',
                      prefix: Icons.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone must not be empty';
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        if(formKey.currentState!.validate()) {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'update'
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                      function: () {
                        signOut(context);
                      },
                      text: 'logout'
                  ),
                ],
              ),
            ),
          ),
          fallback:  (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
