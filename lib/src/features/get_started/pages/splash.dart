// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _navigateToNextScreen() async {
    // if (user == null || user.roles.isEmpty) {
    //   context.pushReplacementNamed(AppRoute.sigInMethodSelectionPage);
    //   return;
    // }

    if (StaticData.isLoggedIn) {
      switch (StaticData.role) {
        case 'seller':
          MyAppRouter.clearAndNavigate(context, AppRoute.sellerBottomBar);
          break;
        case 'user':
          MyAppRouter.clearAndNavigate(context, AppRoute.userBottomNavBar);
          break;
        case 'professional':
          MyAppRouter.clearAndNavigate(context, AppRoute.responsibleLogInPin);
          // MyAppRouter.clearAndNavigate(context, AppRoute.responsibleBottomBar);

          break;
        default:
          MyAppRouter.clearAndNavigate(
              context, AppRoute.sigInMethodSelectionPage);
      }
    } else {
      MyAppRouter.clearAndNavigate(context, AppRoute.sigInMethodSelectionPage);
    }
  }

  // Future<void> getUser() async {
  //   final provider = Provider.of<UserDataProvider>(context, listen: false);
  //   await provider.getUsersData();

  //   _navigateToNextScreen(provider.user);
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateToNextScreen();
      // if (StaticData.accessToken.isEmpty) {
      //   Future.delayed(
      //     Duration(milliseconds: 2500),
      //     () => context.pushNamed(AppRoute.sigInMethodSelectionPage),
      //   );
      // } else {
      //   getUser();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme(context).primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              AppImages.appLogoImageLargen,
              height: size.height * 0.4,
              width: size.width * 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
