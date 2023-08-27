import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tattoapp/features/onboarding/view/screens/onboarding_screen.dart';

import 'component/shared_preferences.dart';

import 'features/authentication/sign_screen.dart';

import 'home_page.dart';

String uId = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId') ?? '';
  bool isOnboarding = CacheHelper.getData(key: 'isOnboarding') ?? false;


  Widget startWidget = OnBoardingScreen();
  await CacheHelper.init();
  if (isOnboarding) {
    if (uId == '') {
      startWidget = const SignUpScreen();
    } else {
      startWidget = HomeLayout();
    }
  }
  runApp(MyApp(startWidget));
}

class MyApp extends StatelessWidget {
  MyApp(this.startWidget, {super.key});
  Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: startWidget,
    );
  }
}
