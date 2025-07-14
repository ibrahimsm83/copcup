import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);
    return Drawer(
      child: Consumer<UserDataProvider>(builder: (context, provider, child) {
        log(provider.user.toString());
        log('${StaticData.userId}');

        final user = provider.user;
        log(user.toString());
        log(user?.image.toString() ?? '');
        if (user == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      navProvider.updateEventBool(true);
                      context.pushNamed(AppRoute.userProfilePage);
                    },
                    child: Container(
                      height: 90,
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme(context).primary),
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          user.image ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    user.name ?? 'James S',
                    style: textTheme(context).headlineMedium?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerItem(
                    svgImage: AppIcons.homeIcon,
                    text: 'Home',
                    onTap: () {
                      navProvider.updateEventBool(true);
                      context.pop();
                      context.pushNamed(AppRoute.userBottomNavBar);
                    },
                  ),
                  DrawerItem(
                    svgImage: AppIcons.searchIcon,
                    text: 'Search Event',
                    onTap: () {
                      context.pop();

                      navProvider.updateEventBool(true);

                      context.pushNamed(AppRoute.searchPage);
                    },
                  ),
                  // DrawerItem(
                  //   svgImage: AppIcons.generalInfoIcon,
                  //   text: 'General Information',
                  //   onTap: () {},
                  // ),
                  // DrawerItem(
                  //   svgImage: AppIcons.cookieIcon,
                  //   text: 'Cookie Management',
                  //   onTap: () {},
                  // ),
                  DrawerItem(
                    svgImage: AppIcons.timerIcon,
                    text: 'Add My Orders',
                    onTap: () {
                      context.pop();

                      navProvider.setCurrentIndex(3);

                      // context.pushNamed(AppRoute.allOrderPage);
                    },
                  ),
                  // DrawerItem(
                  //   svgImage: AppIcons.shareIcon,
                  //   text: 'Invite Friends',
                  //   onTap: () {},
                  // ),
                  DrawerItem(
                    svgImage: AppIcons.notificationIcon,
                    text: 'Notifications',
                    onTap: () {
                      context.pop();

                      navProvider.updateEventBool(true);
                      navProvider.setCurrentIndex(4);

                      context.pushNamed(AppRoute.notificationsPage);
                    },
                  ),
                  DrawerItem(
                    svgImage: AppIcons.favouriteIcon,
                    text: 'Favorites',
                    onTap: () {
                      navProvider.updateEventBool(true);

                      context.pop();

                      context.pushNamed(AppRoute.favouriteEventPage);
                    },
                  ),
                  // DrawerItem(
                  //   svgImage: AppIcons.privacyIcon,
                  //   text: 'Privacy',
                  //   onTap: () {},
                  // ),
                  DrawerItem(
                    svgImage: AppIcons.emailIcon,
                    text: 'Message',
                    onTap: () {
                      navProvider.updateEventBool(true);
                      context.pop();

                      context.pushNamed(AppRoute.inbox);
                    },
                  ),
                  DrawerItem(
                    svgImage: AppIcons.callIcon,
                    text: 'Contact Us',
                    onTap: () {
                      navProvider.updateEventBool(true);
                      context.pop();

                      context.pushNamed(AppRoute.contactUsPage);
                    },
                  ),
                  // DrawerItem(
                  //   svgImage: AppIcons.settingsIcon,
                  //   text: 'Settings',
                  //   onTap: () {},
                  // ),
                  DrawerItem(
                    svgImage: AppIcons.logOutIcon,
                    text: 'Logout',
                    onTap: () {
                      _showLogoutBottomSheet(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String svgImage;
  final String text;
  final VoidCallback onTap;

  const DrawerItem({
    Key? key,
    required this.svgImage,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        svgImage,
        height: 15,
        width: 15,
      ),
      title: Text(
        text,
        style: textTheme(context).titleSmall?.copyWith(
            color: colorScheme(context).onSurface, fontWeight: FontWeight.w700),
      ),
      onTap: onTap,
    );
  }
}

void _showLogoutBottomSheet(BuildContext context) {
  final AuthController authController = AuthController();
  final size = MediaQuery.of(context).size;
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure to logout?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.4,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).surface,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorScheme(context).primary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cancel',
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 13,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: colorScheme(context).primary,
                          child: Icon(
                            Icons.arrow_forward,
                            color: colorScheme(context).surface,
                            size: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.48,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      authController.logout(
                        onError: (error) {},
                        context: context,
                        onSuccess: (message) {
                          MyAppRouter.clearAndNavigate(
                              context, AppRoute.sigInMethodSelectionPage);
                        },
                        // context,
                        // (sucess) {
                        //   context.loaderOverlay.hide();
                        //   showSnackbar(
                        //     message: "Logout Sucessfully",
                        //     isError: true,
                        //   );
                        //   // context.pushNamed(AppRoute.signInPage,
                        //   //     extra: {'role': 'user'});
                        //   context.goNamed(AppRoute.sigInMethodSelectionPage);
                        // },
                        // (error) {
                        //   context.loaderOverlay.hide();
                        //   showSnackbar(
                        //     message: "Logout Failed",
                        //     isError: true,
                        //   );
                        // },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).primary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorScheme(context).primary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Yes Logout ',
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).surface,
                                fontWeight: FontWeight.w600)),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: colorScheme(context).surface,
                          child: Icon(
                            Icons.arrow_forward,
                            color: colorScheme(context).primary,
                            size: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
