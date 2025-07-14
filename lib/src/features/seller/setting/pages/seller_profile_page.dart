import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_switch.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/provider/seller_setting_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';

import 'package:shimmer/shimmer.dart';

import '../../home/provider/seller_home_provider.dart';

class SellerProfilePage extends StatefulWidget {
  const SellerProfilePage({super.key});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSeller();
    });

    super.initState();
  }

  getSeller() async {
    final provider = Provider.of<SellerAuthController>(context, listen: false);
    await provider.getSellerData();
  }

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: SellerBottomBarWidget(),
      body: Consumer<SellerHomeProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    SellerHomePage(),
    SellerStockPage(),
    SellerQrScanPage(),
    SellerAllOrderPage(),
    Consumer<SellerHomeProvider>(
        builder: (context, value, child) => value.sellerProfileBool
            ? SellerprofileWidget()
            : SellerSettingPage()),
  ];
}

class SellerprofileWidget extends StatefulWidget {
  const SellerprofileWidget({super.key});

  @override
  State<SellerprofileWidget> createState() => _SellerprofileWidgetState();
}

class _SellerprofileWidgetState extends State<SellerprofileWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child:
            Consumer<SellerAuthController>(builder: (context, provider, child) {
          log(provider.seller.toString());
          log('${StaticData.userId}');

          final user = provider.seller;
          log(user.toString());
          log(user?.image.toString() ?? '');
          if (user == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    '${AppLocalizations.of(context)!.profilePageTitle}',
                    style: textTheme(context).headlineSmall?.copyWith(
                          fontSize: 21,
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Consumer<SellerSettingProvider>(
                builder: (context, value, child) => Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: colorScheme(context).secondary,
                              width: 1.5)),
                      child: Center(
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //     image: value.profilePmageFile != null
                            //         ? FileImage(value.profilePmageFile!)
                            //         : NetworkImage(user.image ?? ''),
                            //     fit: BoxFit.cover),
                            // border: Border.all(
                            //   color: colorScheme(context).secondary,
                            //   width: 2,
                            // ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: user.image ?? StaticData.defultImage,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 42,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
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
                      ),
                    ),
                    CustomContainer(
                      onTap: () {
                        // showModalBottomSheet(
                        //   context: context,
                        //   shape: Border.all(),
                        //   builder: (context) => CustomContainer(
                        //       height: m.height * 0.2,
                        //       color: colorScheme(context).surface,
                        //       child: Column(
                        //         children: [
                        //           SizedBox(
                        //             height: 20,
                        //           ),
                        //           Text(
                        //             'Pick Image ',
                        //             style: textTheme(context)
                        //                 .titleSmall
                        //                 ?.copyWith(
                        //                     color: colorScheme(context)
                        //                         .onSurface),
                        //           ),
                        //           SizedBox(
                        //             height: 20,
                        //           ),
                        //           Column(
                        //             children: List.generate(2, (index) {
                        //               return Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: GestureDetector(
                        //                   onTap: () {
                        //                     value.selectProfileImageIndex(
                        //                         index);
                        //                     value
                        //                         .pickImageFromGalleryProfile();
                        //                     Navigator.pop(context);
                        //                   },
                        //                   child: Row(
                        //                     children: [
                        //                       SizedBox(
                        //                         width: 30,
                        //                       ),
                        //                       index == 0
                        //                           ? Icon(Icons
                        //                               .camera_alt_outlined)
                        //                           : SvgPicture.asset(
                        //                               AppIcons.galleryIcon,
                        //                               color:
                        //                                   colorScheme(context)
                        //                                       .onSurface,
                        //                             ),
                        //                       SizedBox(
                        //                         width: 20,
                        //                       ),
                        //                       Text(
                        //                         index == 0
                        //                             ? 'Camera'
                        //                             : 'Gallery',
                        //                         style: textTheme(context)
                        //                             .titleSmall
                        //                             ?.copyWith(
                        //                                 color: colorScheme(
                        //                                         context)
                        //                                     .onSurface),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             }),
                        //           ),
                        //         ],
                        //       )),
                        // );
                      },
                      height: 30,
                      width: 30,
                      borderRadius: 8,
                      borderColor: colorScheme(context).secondary,
                      borderWidth: 2,
                      child: Center(
                          child: SvgPicture.asset(
                        AppIcons.galleryIcon,
                        height: 13,
                      )),
                      color: colorScheme(context).surface,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                user.name,
                style: textTheme(context)
                    .titleLarge
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                user.email,
                style: textTheme(context).titleLarge?.copyWith(
                    color: AppColor.appGreyColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              CustomContainer(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                borderRadius: 100,
                color: colorScheme(context).secondary,
                child: Text(
                  AppLocalizations.of(context)!.na_viewProfile,
                  style: textTheme(context).bodySmall?.copyWith(
                      fontSize: 9, color: colorScheme(context).surface),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.general_information,
                  style: textTheme(context).titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 0.2),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Consumer<SellerSettingProvider>(
                builder: (context, value, child) => CustomContainer(
                  borderColor: colorScheme(context).onSurface.withOpacity(.10),
                  borderRadius: 12,
                  height: 60,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                          backgroundColor: AppColor.settingIconColor,
                          radius: 20,
                          child: Center(
                              child: SvgPicture.asset(
                            AppIcons.fillBellIcon,
                            height: 15,
                          ))),
                      SizedBox(
                        width: 15,
                      ),
                      Text('Notifications',
                          style: textTheme(context).bodyMedium?.copyWith(
                              color: AppColor.appGreyColor,
                              fontWeight: FontWeight.w600)),
                      Spacer(),
                      CustomSwitch(
                        value: value.settingSwitch,
                        onChanged: (val) {
                          value.settingSwitchToggle();
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CustomContainer(
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                borderRadius: 12,
                height: 60,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: AppColor.settingIconColor,
                      radius: 20,
                      child: Center(
                          child: SvgPicture.asset(
                        AppIcons.notificationLanguageIcon,
                        height: 15,
                      )),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(AppLocalizations.of(context)!.language,
                        style: textTheme(context).bodyMedium?.copyWith(
                            color: AppColor.appGreyColor,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
