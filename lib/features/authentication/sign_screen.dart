import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tattoapp/features/PhotoScreen.dart';
import 'package:tattoapp/features/authentication/widget_components/login_components.dart';
import 'package:tattoapp/features/authentication/widget_components/register_components.dart';
import 'package:tattoapp/main.dart';

import '../../component/shared_preferences.dart';
import '../../home_page.dart';
import 'login_cubit/login_cubit.dart';
import 'login_cubit/login_states.dart';
import 'widget_components/validator_components.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPass = true;
  bool isSwitch = true;
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            );
            uId = state.uId;
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLayout(),
                ),
                (route) => false);
          } else if (state is RegisterSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            );
            uId = state.uId;

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeLayout(),
                ),
                (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5),
                child: Column(
                  children: [
                    isSwitch
                        ? Text(
                            'Welcome Back',
                            style: textTheme(fontSize: 22),
                          )
                        : Text(
                            'Create Account',
                            style: textTheme(fontSize: 22),
                          ),
                    const SizedBox(
                      height: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Column(
                        children: [
                          isSwitch
                              ? LoginWidget(
                                  isSwitch: isSwitch,
                                  passwordController: passwordController,
                                  isPass: isPass,
                                  emailController: emailController,
                                )
                              : RegisterWidget(
                                  isSwitch: isSwitch,
                                  passwordController: passwordController,
                                  isPass: isPass,
                                  emailController: emailController,
                                  phoneController: phoneController,
                                  nameController: nameController,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isSwitch
                                  ? Text(
                                      'Don\'t Have Account?',
                                      style: textTheme(),
                                    )
                                  : Text(
                                      'Have Account?',
                                      style: textTheme(),
                                    ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    isSwitch = !isSwitch;
                                    print(isSwitch);
                                  });
                                },
                                child: Text(
                                  isSwitch ? 'Sign Up' : 'LOGIN',
                                  style: textTheme(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
