import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'component/cubit/home_cubit.dart';
import 'features/authentication/widget_components/validator_components.dart';


class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getUserData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: null,
              title: Text(
                cubit.title[cubit.currentIndex],
                style: textTheme(fontSize: 22),
              ),
              centerTitle: false,

            ),
            body: ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.black,
              selectedItemColor: Colors.red.shade900,
              unselectedItemColor: Colors.grey,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: cubit.bottomItems,
            ),
          );
        },
      ),
    );
  }
}
