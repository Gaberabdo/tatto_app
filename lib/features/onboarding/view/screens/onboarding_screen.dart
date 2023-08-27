import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tattoapp/features/authentication/sign_screen.dart';

import '../../../../component/component.dart';
import '../../../../component/shared_preferences.dart';
import '../../cubit/onboarding_cubit.dart';
import '../../cubit/onboarding_state.dart';
import '../../model/onboarding_model.dart';
import '../components/onboarding_view.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = OnboardingCubit.get(context);
          return Scaffold(
            body: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return onboardBuildPage(
                  cubit,
                  onBoardInfo[index],
                  index,
                  context,
                  pageController,
                );
              },
              itemCount: onBoardInfo.length,
              scrollDirection: axisDirectionToAxis(AxisDirection.right),
              onPageChanged: (index) {
                if (cubit.isClick) {
                  cubit.value = cubit.value + 1 / 3;
                } else {
                  cubit.value = cubit.value + 1 / 3;
                }

                if (index == onBoardInfo.length - 1) {
                  cubit.listenPageLastIndex(true);
                } else {
                  cubit.listenPageLastIndex(false);
                }
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: !cubit.isLastPage
                ? SmoothPageIndicator(
                    controller: pageController,
                    count: onBoardInfo.length,
                    effect: ExpandingDotsEffect(
                        dotHeight: 10.0,
                        dotWidth: 10.0,
                        activeDotColor: Colors.red,
                        dotColor: Colors.redAccent.shade100),
                  )
                : MaterialButton(
                    onPressed: () {
                      if (cubit.isLastPage) {
                        CacheHelper.saveData(key: 'isOnboarding', value: true)
                            .then(
                          (value) {
                            RoutePage().navigateAndRemove(
                              context,
                              const SignUpScreen(),
                            );
                          },
                        );
                      }
                    },
                    height: 50,
                    color: Colors.red.shade900,
                    child: Text(
                      'START',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
