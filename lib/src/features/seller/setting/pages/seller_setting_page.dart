import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/widget/setting_row_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/widget/seller_logout_dialogue.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SellerSettingPage extends StatefulWidget {
  const SellerSettingPage({super.key});

  @override
  State<SellerSettingPage> createState() => _SellerSettingPageState();
}

class _SellerSettingPageState extends State<SellerSettingPage> {
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

  final SellerAuthController sellerAuthController = SellerAuthController();

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Image"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  await _cropImage(File(pickedFile.path));
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Choose from Gallery"),
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedFile != null) {
                  await _cropImage(File(pickedFile.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Theme.of(context).primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
    );
    if (croppedFile != null) {
      setState(() {
        _selectedImage = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final sellerprovider = Provider.of<SellerHomeProvider>(context);
    var m = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<SellerAuthController>(builder: (context, provider, child) {
        log('${StaticData.userId}');

        final sellerData = provider.seller;

        log(sellerData?.image.toString() ?? '');
        log(sellerData!.email);
        log(sellerData.name);
        log(sellerData.eventId.toString());
        if (sellerData == null) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    height: m.height * 0.8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomContainer(
                          height: m.height * 0.75,
                          width: m.width * 0.9,
                          borderRadius: 16,
                          borderColor: colorScheme(context).secondary,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 70,
                                  ),
                                  Text(
                                    sellerData.name,
                                    style: textTheme(context)
                                        .titleLarge
                                        ?.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    sellerData.email,
                                    style: textTheme(context)
                                        .titleLarge
                                        ?.copyWith(
                                            color: AppColor.appGreyColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 29,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .na_mySettings,
                                        style: textTheme(context)
                                            .titleLarge
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .onSurface,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      sellerprovider.updateSellerBool(true);
                                      context.pushNamed(
                                          AppRoute.sellerProfilePage);
                                    },
                                    iconImage: AppIcons.sellerProfileOutline,
                                    settingName: AppLocalizations.of(context)!
                                        .profilePageTitle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      sellerprovider.updateSellerBool(true);
                                      context.pushNamed(
                                          AppRoute.sellerNotificationPage);
                                    },
                                    iconImage: AppIcons.notificationIcon,
                                    settingName: AppLocalizations.of(context)!
                                        .notificationTitle,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      sellerprovider.updateSellerBool(true);

                                      context.pushNamed(
                                          AppRoute.sellerChangePasswordPage);
                                    },
                                    iconImage: AppIcons.lockIcon,
                                    settingName: AppLocalizations.of(context)!
                                        .changePasswordTitle,
                                  ),

                                  // SettingRowWidget(
                                  //   iconImage: AppIcons.sellerProfileOutline,
                                  //   settingName: AppLocalizations.of(context)!
                                  //       .na_personalDataManagement,
                                  //   ontap: () {
                                  //     sellerprovider.updateSellerBool(true);

                                  //     context.pushNamed(
                                  //         AppRoute.sellerContactUsPage);
                                  //   },
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    iconImage: AppIcons.sellerProfileOutline,
                                    settingName: AppLocalizations.of(context)!
                                        .contactUsTitle,
                                    ontap: () {
                                      sellerprovider.updateSellerBool(true);

                                      context.pushNamed(
                                          AppRoute.sellerContactUsPage);
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    iconImage: AppIcons.sellerProfileOutline,
                                    settingName: AppLocalizations.of(context)!
                                        .termsConditionOption,
                                    ontap: () {
                                      context.pushNamed(
                                          AppRoute.sellerTermAndConditionPage);
                                    },
                                  ),

                                  // SettingRowWidget(
                                  //   // ontap: () {
                                  //   // },
                                  //   iconImage: AppIcons.sellerApplicationIcon,
                                  //   settingName: AppLocalizations.of(context)!
                                  //       .na_applicationTheme,
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      sellerprovider.updateSellerBool(true);

                                      context.pushNamed(
                                          AppRoute.sellerMaximumOrderPage);
                                    },
                                    iconImage: AppIcons.sellerPrivacyIcon,
                                    settingName: AppLocalizations.of(context)!
                                        .na_maximumOrderLimit,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // SettingRowWidget(
                                  //   ontap: () {
                                  //     sellerprovider.updateSellerBool(true);
                                  //     context.pushNamed(AppRoute.allCoupon);
                                  //   },
                                  //   iconImage: AppIcons.cuponIcon,
                                  //   settingName:
                                  //       AppLocalizations.of(context)!.coupons,
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // SettingRowWidget(
                                  //   ontap: () {
                                  //     sellerprovider.updateSellerBool(true);

                                  //     context.pushNamed(
                                  //         AppRoute.createDeliveryCharges);
                                  //   },
                                  //   iconImage: AppIcons.shoppingCartIcon,
                                  //   settingName: AppLocalizations.of(context)!
                                  //       .delivery_charges,
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  SettingRowWidget(
                                    ontap: () {
                                      context.pushNamed(AppRoute.inbox);
                                    },
                                    iconImage: AppIcons.emailIcon,
                                    settingName:
                                        AppLocalizations.of(context)!.messages,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      // context.goNamed(
                                      //     AppRoute.sellerTermAndConditionPage);
                                    },
                                    iconImage: AppIcons.sellerPrivacyIcon,
                                    settingName:
                                        AppLocalizations.of(context)!.privacy,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      context
                                          .pushNamed(AppRoute.sellerFAQSPage);
                                    },
                                    iconImage: AppIcons.sellerPrivacyIcon,
                                    settingName:
                                        AppLocalizations.of(context)!.faqs,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .general_information,
                                      style: textTheme(context)
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              letterSpacing: 0.2),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    iconImage: AppIcons.sellerHelpIcon,
                                    settingName:
                                        AppLocalizations.of(context)!.help,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SettingRowWidget(
                                    ontap: () {
                                      sellerprovider.updateSellerBool(true);
                                      context.pushNamed(
                                          AppRoute.sellerChooseLanguagePage);
                                    },
                                    iconImage: AppIcons.sellerLanguageIcon,
                                    settingName:
                                        AppLocalizations.of(context)!.language,
                                    forwardIcon: Row(
                                      children: [
                                        Icon(Icons.arrow_forward_ios_outlined)
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 80,
                                  ),
                                  CustomButton(
                                    text: AppLocalizations.of(context)!.logout,
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          shape: Border.all(),
                                          builder: (context) =>
                                              SellerLogOutDialogue());
                                    },
                                    height: 54,
                                    arrowCircleRadius: 22,
                                    borderColor: colorScheme(context).secondary,
                                    iconColor: colorScheme(context).surface,
                                    arrowCircleColor:
                                        colorScheme(context).secondary,
                                    backgroundColor:
                                        colorScheme(context).surface,
                                    textColor: colorScheme(context).secondary,
                                    boxShadow: [BoxShadow()],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer<SellerAuthController>(
                      builder: (context, sellerauthcontroller, child) {
                    return Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          // backgroundImage:    NetworkImage(
                          //   sellerData.image ??
                          //       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                          // ),

                          child: CachedNetworkImage(
                            imageUrl: sellerData.image ??
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 50,
                              backgroundImage: imageProvider,
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: CircleAvatar(
                                radius: 50,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // : FileImage(_selectedImage!) as ImageProvider,
                        ),
                        CustomContainer(
                          // onTap: () async {
                          //   _showImagePickerDialog();

                          //   await sellerAuthController
                          //       .updateSellerProfileControllerData(
                          //           image: _selectedImage!,
                          //           email: sellerData.email,
                          //           context: context,
                          //           eventid: int.parse(
                          //               sellerData.eventId.toString()),
                          //           id: sellerData.id,
                          //           name: sellerData.name,
                          //           password: 'Hamza@12',
                          //           onError: (error) {
                          //             ScaffoldMessenger.of(context)
                          //                 .showSnackBar(
                          //               SnackBar(
                          //                   content:
                          //                       Text('Error updating Image')),
                          //             );
                          //           },
                          //           onSuccess: (message) {
                          //             ScaffoldMessenger.of(context)
                          //                 .showSnackBar(
                          //               SnackBar(
                          //                   content: Text(
                          //                       'Profile Image Updated Successfully')),
                          //             );
                          //           });
                          // },

                          height: 28,
                          width: 28,
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
                    );
                  }),
                ],
              ),
            ));
      }),
    );
  }
}
