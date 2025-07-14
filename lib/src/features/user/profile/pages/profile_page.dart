// ignore_for_file: unused_element
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';

import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_switch.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/profile/widgets/settings_option.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../seller/setting/provider/seller_setting_provider.dart';
import '../provider/user_data_provider.dart';

class ProfilePage extends StatefulWidget {
  bool isFromHome;
   ProfilePage({super.key,this.isFromHome=true});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
    });

    super.initState();
  }

  getUser() async {
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    await provider.getUsersData();
  }

  final AuthController authController = AuthController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    log('-|||||||-------------------${StaticData.email}');
    log('-|||||||-------------------${widget}');
    log('--ZZZZZZZZZZZZZ------------------${SharedPrefHelper.getString(emailText)}');
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.profilePageTitle,
        isLeadingIcon: widget.isFromHome,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      // appBar: CustomAppBar(
      //   title: AppLocalizations.of(context)!.profilePageTitle,
      //   onLeadingPressed: () {},
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   AppLocalizations.of(context)!.profilePageTitle,
            //   style: textTheme(context).headlineSmall?.copyWith(
            //         fontSize: 21,
            //         color: colorScheme(context).onSurface,
            //         fontWeight: FontWeight.w600,
            //       ),
            // ),
            // SizedBox(
            //   height: 20,
           // ),
            Consumer<UserDataProvider>(builder: (context, provider, child) {
              log(provider.user.toString());
              log('${StaticData.userId}');

              final user = provider.user;
              log(user.toString());

              log(user?.image.toString() ?? '');
              if (user == null) {
                return SizedBox(
                    height: 100,
                    child: Center(child: CircularProgressIndicator()));
              }
              log('.........................................${user.image}');

              return SizedBox(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 110,
                            width: 130,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: colorScheme(context).primary),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: CachedNetworkImageProvider(
                                    user.image ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: user.image ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      radius: 50,
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: CircleAvatar(
                                        radius: 50,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.name ?? 'Name not available',
                      style: textTheme(context).headlineMedium?.copyWith(
                          fontSize: 24,
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Text(
                      user.email ?? 'Email not available',
                      style: textTheme(context).bodySmall?.copyWith(
                          fontSize: 13,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.4),
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                provider.updateEventBool(true);
                context.pushNamed(AppRoute.editProfilePage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme(context).primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.editProfileTitle,
                style: textTheme(context).labelSmall?.copyWith(
                    color: colorScheme(context).surface,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.generalInformationTitle,
                style: textTheme(context).headlineSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                provider.updateEventBool(true);

                context.pushNamed(AppRoute.editProfilePage);
              },
              child: SettingsOption(
                imagesvg: AppIcons.profileInActiveIcon,
                title: AppLocalizations.of(context)!.editProfileTitle,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                provider.updateEventBool(true);
                context.pushNamed(AppRoute.notificationsPage);
              },
              child: Consumer<SellerSettingProvider>(
                builder: (context, value, child) => CustomContainer(
                  borderColor: colorScheme(context).onSurface.withOpacity(0.15),
                  borderRadius: 12,
                  height: 60,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                          backgroundColor:
                              colorScheme(context).onSurface.withOpacity(0.2),
                          radius: 20,
                          child: Center(
                              child: SvgPicture.asset(
                            AppIcons.fillBellIcon,
                            height: 15,
                          ))),
                      SizedBox(
                        width: 15,
                      ),
                      Text(AppLocalizations.of(context)!.notificationTitle,
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: AppColor.appGreyColor,
                              fontWeight: FontWeight.w600)),
                      Spacer(),
                      CustomSwitch(
                        activeTrackColor: colorScheme(context).primary,
                        value: value.settingSwitch,
                        onChanged: (val) {
                          value.settingSwitchToggle();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.updateEventBool(true);

                context.pushNamed(AppRoute.changePasswordPage);
              },
              child: SettingsOption(
                imagesvg: AppIcons.lockIcon,
                title: AppLocalizations.of(context)!.changePasswordTitle,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.updateEventBool(true);

                context.pushNamed(AppRoute.userContactUsPage);
              },
              child: SettingsOption(
                imagesvg: AppIcons.contactUsIcon,
                title: AppLocalizations.of(context)!.contactUsTitle,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.updateEventBool(true);
                context.pushNamed(AppRoute.chooseLanguagePage);
              },
              child: SettingsOption(
                imagesvg: AppIcons.languageXaIcon,
                title: AppLocalizations.of(context)!.languageOption,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showDeleteBottomSheet(context);
              },
              child: SettingsOption(
                imagesvg: AppIcons.deleteIcon1,
                title: AppLocalizations.of(context)!.deleteAccountOption,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                provider.updateEventBool(true);
                context.pushNamed(AppRoute.transactionPage);
              },
              child: SettingsOption(
                imagesvg: AppIcons.profileInActiveIcon,
                title: AppLocalizations.of(context)!.transactionOption,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.termsConditionPage);
              },
              child: SettingsOption(
                imagesvg: AppIcons.termsConditionIcon,
                title: AppLocalizations.of(context)!.termsConditionOption,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _showLogoutBottomSheet(context);
              },
              child: SettingsOption(
                imagesvg: AppIcons.logOutIcon,
                title: AppLocalizations.of(context)!.logoutOption,
                trailing: Icon(
                  Icons.arrow_forward,
                  color: colorScheme(context).primary,
                  size: 18,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

void _showDeleteBottomSheet(BuildContext context) {
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
            Text(
              AppLocalizations.of(context)!.deleteConfirmation,
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
                        Text(AppLocalizations.of(context)!.cancelButton,
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
                Consumer<AuthController>(
                  builder: (context, provider, child) => SizedBox(
                    width: size.width * 0.48,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        provider.requestOtpDelete(
                          context,
                          (success) {
                            context.pushNamed(AppRoute.otpDeleteUserProfile);
                            showSnackbar(
                              message: AppLocalizations.of(context)!
                                  .na_sendOtpDeleteAccountSuccess,
                              isError: true,
                            );
                          },
                          (error) {
                            showSnackbar(
                              message:
                                  AppLocalizations.of(context)!.na_errorSendOtp,
                              isError: true,
                            );
                          },
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
                          Text(AppLocalizations.of(context)!.yesButton,
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
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

void _showLogoutBottomSheet(BuildContext context) {
  final AuthController authController = AuthController();
  final size = MediaQuery.of(context).size;
  final btmBarProvider =
      Provider.of<NavigationProvider>(context, listen: false);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(context)!.logoutConfirmation,
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
                  width: size.width * 0.43,
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
                        Text(AppLocalizations.of(context)!.cancelButton,
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
                  width: size.width * 0.5,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () async {
                      await authController.logout(
                        onError: (error) {},
                        context: context,
                        // onSuccess: (message) {
                        //   MyAppRouter.clearAndNavigate(
                        //       context, AppRoute.sigInMethodSelectionPage);

                        //   btmBarProvider.setCurrentIndex(0);
                        // },
                        onSuccess: (val) async {
                          StaticData.isLoggedIn = false;
                          await SharedPrefHelper.saveBool(
                              isLoggedInText, false);

                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();

                          final tempDir = await getTemporaryDirectory();
                          if (tempDir.existsSync()) {
                            tempDir.deleteSync(recursive: true);
                          }

                          MyAppRouter.clearAndNavigate(
                            context,
                            AppRoute.sigInMethodSelectionPage,
                          );

                          btmBarProvider.setCurrentIndex(0);
                        },
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
                        Text(AppLocalizations.of(context)!.logoutOption,
                            style: textTheme(context).bodyLarge?.copyWith(
                                color: colorScheme(context).surface,
                                fontWeight: FontWeight.w500)),
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
