import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/new_change_password.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/widgets/account_alert_dialog.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';


import '../../../../common/utils/custom_snack_bar.dart';
import '../../../user/profile/provider/user_data_provider.dart';

class ResponsibleProfilePage extends StatefulWidget {
  const ResponsibleProfilePage({super.key});

  @override
  State<ResponsibleProfilePage> createState() => _ResponsibleProfilePageState();
}

class _ResponsibleProfilePageState extends State<ResponsibleProfilePage> {
  @override
  void initState() {
    super.initState();

    // Provider.of<UserDataProvider>(context, listen: false).getUser();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
    });
  }

  getUser() async {
    final provider =
        Provider.of<ResponsibleAuthController>(context, listen: false);
    if (provider.userProfessionalModel == null) {
      await provider.getProfessionalDetail(
        context: context,
        onError: (error) {
          customAlertDialog(
            context: context,
            content: error,
            onPressed: () {
              getUser();
              context.pop();
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final resNavbarProvider = Provider.of<ResponsibleHomeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<ResponsibleAuthController>(
            builder: (context, provider, child) {
          // log(provider.user.toString());
          // log('${StaticData.userId}');

          final user = provider.userProfessionalModel;
          // log('Baner image-----------${user?.professional.first.bannerImage}');
          log(user?.image.toString() ?? '');
          if (user == null) {
            return Center(child: CircularProgressIndicator());
          }
          log(user.name);
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //   image: NetworkImage(user
                            //           .professional.first.bannerImage ??
                            //       'https://static.vecteezy.com/system/resources/thumbnails/037/814/719/small_2x/ai-generated-autumn-leaves-in-the-forest-nature-background-photo.jpg'),
                            //   fit: BoxFit.cover,
                            // ),

                            ),
                        child: CachedNetworkImage(
                          imageUrl: user.professional.first.bannerImage ??
                              StaticData.defultImage,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 200,
                                width: double.infinity,
                              )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned(
                        bottom: -40,
                        left: 20,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.white,
                              child: CachedNetworkImage(
                                imageUrl: user.image ?? StaticData.defultImage,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  radius: 42,
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: CircleAvatar(
                                    radius: 42,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorScheme(context).primary,
                                        width: 4),
                                    borderRadius: BorderRadius.circular(12),
                                    color: colorScheme(context).surface,
                                  ),
                                  child: Icon(Icons.photo_outlined,
                                      color: colorScheme(context).primary,
                                      size: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name ?? 'Cop Cup',
                          style: textTheme(context).headlineMedium?.copyWith(
                              color: colorScheme(context).onSurface,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          user.email ?? 'Copcup@123gmail.com',
                          style: textTheme(context).labelMedium?.copyWith(
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     AppLocalizations.of(context)!.na_disconnect,
                        //     style: textTheme(context).labelMedium?.copyWith(
                        //         color: colorScheme(context).surface,
                        //         fontWeight: FontWeight.w500),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: colorScheme(context).secondary,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 30),
                        buildMenuItem(
                          AppIcons.profileInActiveIcon,
                          AppLocalizations.of(context)!.na_manageAccount,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);
                            context
                                .pushNamed(AppRoute.responsibleManageAccount);
                          },
                        ),
                        // buildMenuItem(
                        //   AppIcons.boxIcon,
                        //   AppLocalizations.of(context)!.na_modifyEstablishment,
                        //   () {
                        //     context.pushNamed(AppRoute.editSellerPage);
                        //   },
                        // ),
                        buildMenuItem(
                          AppIcons.boxIcon,
                          AppLocalizations.of(context)!.all_delivery_charges,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.allDeliveryCharges);
                          },
                        ),
                        buildMenuItem(
                          AppIcons.emailIcon,
                          'Change Email',
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.changeEmailPage);
                          },
                        ),

                        buildMenuItem(
                          AppIcons.cuponIcon,
                          AppLocalizations.of(context)!.coupons,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.allCoupon);
                          },
                        ),

                        buildMenuItem(
                          AppIcons.boxIcon,
                          AppLocalizations.of(context)!.manage_events,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.allEventsPage);
                          },
                        ),
                        buildMenuItem(
                          AppIcons.shoppingCartIcon,
                          AppLocalizations.of(context)!.delivery_charges,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.createDeliveryCharges);
                          },
                        ),

                        // buildMenuItem(
                        //   AppIcons.salesIcon,
                        //   AppLocalizations.of(context)!.sales_report,
                        //   () {
                        //     resNavbarProvider.updateResponsibleBool(true);

                        //     context.pushNamed(AppRoute.responsibleSalesReport);
                        //   },
                        // ),
                        // buildMenuItem(
                        //   AppIcons.adminUserManagement,
                        //   'Create Professional Account',
                        //   () {
                        //     context
                        //         .pushNamed(AppRoute.responsibleUpdateAccount);
                        //   },
                        // ),
                        // buildMenuItem(
                        //   AppIcons.circleQuestionIcon,
                        //   'Setting',
                        //   () {},
                        // ),
                        // buildMenuItem(
                        //   AppIcons.circleQuestionIcon,
                        //   'Payement Methods',
                        //   () {
                        //     context.pushNamed(AppRoute.addPaymentPage);
                        //   },
                        // ),
                        // buildMenuItem(
                        //   AppIcons.masterCardIcon,
                        //   'Transfer Money',
                        //   () {
                        //     context.pushNamed(AppRoute.moneyTransferPage);
                        //   },
                        // ),
                        buildMenuItem(
                          AppIcons.boxIcon,
                          AppLocalizations.of(context)!.orders,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.responsibleOrderPage);
                          },
                        ),
                        // buildMenuItem(
                        //   AppIcons.boxIcon,
                        //   AppLocalizations.of(context)!.add_events,
                        //   () {
                        //     context.pushNamed(AppRoute.addEventsPage);
                        //   },
                        // ),
                        // buildMenuItem(
                        //   AppIcons.boxIcon,
                        //   AppLocalizations.of(context)!.add_seller_bank_account,
                        //   () {
                        //     resNavbarProvider.updateResponsibleBool(true);

                        //     context.pushNamed(AppRoute.createSellerBankAccount);
                        //   },
                        // ),

                        buildMenuItem(
                          AppIcons.lockIcon,
                          AppLocalizations.of(context)!.change_password,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            log('--------:${user.email ?? 'Copcup@123gmail.com'}');

                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => NewChangePassword(
                            //               email: user.email ?? 'Copcup@123gmail.com',
                            //               token: StaticData.accessToken,
                            //             )));
                            context
                                .pushNamed(AppRoute.responsibleChangePassword);
                          },
                        ),
                        // buildMenuItem(
                        //   AppIcons.clipCircle,
                        //   AppLocalizations.of(context)!.add_event_category,
                        //   () {
                        //     context.pushNamed(AppRoute.allEventCatagories);
                        //   },
                        // ),

                        buildMenuItem(
                          AppIcons.contactUsIcon,
                          AppLocalizations.of(context)!.contactUsTitle,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(AppRoute.contactUsPage);
                          },
                        ),
                        buildMenuItem(
                          AppIcons.languageXaIcon,
                          AppLocalizations.of(context)!.language,
                          () {
                            resNavbarProvider.updateResponsibleBool(true);

                            context.pushNamed(
                                AppRoute.responsibleChooseLanguagePage);
                          },
                        ),
                        // SizedBox(height: 20),
                        // GestureDetector(
                        //   onTap: () {
                        //     context.pushNamed(
                        //         AppRoute.responsibleChooseLanguagePage);
                        //   },
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Padding(
                        //         padding: const EdgeInsets.only(left: 16),
                        //         child: SvgPicture.asset(
                        //           AppIcons.languageXaIcon,
                        //           height: 14,
                        //           width: 14,
                        //           color: colorScheme(context).onSurface,
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 180),
                        //         child: Text(
                        //           AppLocalizations.of(context)!.language,
                        //           style: textTheme(context).bodyLarge?.copyWith(
                        //               color: colorScheme(context).onSurface,
                        //               fontWeight: FontWeight.w700),
                        //         ),
                        //       ),
                        //       Padding(
                        //           padding: const EdgeInsets.only(right: 30),
                        //           child: Icon(
                        //             Icons.arrow_forward_ios,
                        //             color: colorScheme(context).onSurface,
                        //             size: 16,
                        //           )),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(height: 20),
                        buildMenuItem(
                          AppIcons.logOutIcon,
                          AppLocalizations.of(context)!.logout,
                          () {
                            _showLogoutBottomSheet(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          );
        }),
        // }),
      ),
    );
  }

  Widget buildMenuItem(
      String imageSvg, String title, final VoidCallback onTap) {
    return ListTile(
      leading: SvgPicture.asset(
        imageSvg,
        height: 14,
        width: 14,
        color: colorScheme(context).onSurface,
      ),
      title: Text(
        title,
        style: textTheme(context).bodyLarge?.copyWith(
            color: colorScheme(context).onSurface, fontWeight: FontWeight.w700),
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}

void _showLogoutBottomSheet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final AuthController authController = AuthController();
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
                  width: size.width * 0.42,
                  height: size.height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).surface,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorScheme(context).secondary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.cancelButton,
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).secondary,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          width: 13,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: colorScheme(context).secondary,
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
                    onPressed: () async {
                      await authController.logout(
                        context: context,
                        onError: (error) {},

                        // onSuccess: (val) {
                        //   StaticData.isLoggedIn = false;
                        //   SharedPrefHelper.saveBool(isLoggedInText, false);
                        //   MyAppRouter.clearAndNavigate(
                        //       context, AppRoute.sigInMethodSelectionPage);
                        // },
                        onSuccess: (val) async {
                          // Update login state
                          StaticData.isLoggedIn = false;
                          await SharedPrefHelper.saveBool(
                              isLoggedInText, false);

                          // Clear all SharedPreferences (including login data, tokens, etc.)
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.clear();

                          // Clear temporary directories (cache, etc.)
                          final tempDir = await getTemporaryDirectory();
                          if (tempDir.existsSync()) {
                            tempDir.deleteSync(recursive: true);
                          }

                          // Navigate to login or selection screen
                          MyAppRouter.clearAndNavigate(
                            context,
                            AppRoute.sigInMethodSelectionPage,
                          );
                        },

                        //   context,
                        //   (sucess) {
                        //     context.loaderOverlay.hide();
                        //     showSnackbar(
                        //       message: "Logout Sucessfully",
                        //       isError: false,
                        //     );
                        //     context.goNamed(AppRoute.sigInMethodSelectionPage,
                        //         extra: {'role': 'professional'});
                        //   },
                        //   (error) {
                        //     context.loaderOverlay.hide();
                        //     showSnackbar(
                        //       message: "Logout Failed",
                        //       isError: true,
                        //     );
                        //   },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme(context).secondary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: colorScheme(context).secondary),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!.logout,
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).surface,
                                fontWeight: FontWeight.w600)),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: colorScheme(context).surface,
                          child: Icon(
                            Icons.arrow_forward,
                            color: colorScheme(context).secondary,
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
