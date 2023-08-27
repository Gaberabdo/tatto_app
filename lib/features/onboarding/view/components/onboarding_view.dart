import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/onboarding_cubit.dart';
import '../../model/onboarding_model.dart';

Widget onboardBuildPage(OnboardingCubit cubit, OnboardingModel model, int index,
    context, PageController pageController) {
  return Image.network(
    model.imagePath,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.fill,
  );
}
