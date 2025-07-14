// ignore_for_file: must_be_immutable, override_on_non_overriding_member
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_switch.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/widget/seller_order_dialog.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:shimmer/shimmer.dart';

class SellerHomePage extends StatefulWidget {
  SellerHomePage({super.key});

  @override
  State<SellerHomePage> createState() => _SellerHomePageState();
}

class _SellerHomePageState extends State<SellerHomePage> {
  @override
  void initState() {
    super.initState();

    log('<<<<<<<<<<<<<<<<<<<<<<<<<${StaticData.sellerEventId}>>>>>>>>>>>>>>>>>>>>>>>>>');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SellerOrderProvider>(context, listen: false);
      provider.getAllOrders(context: context);
      getSeller();
    });
  }

  getSeller() async {
    final provider = Provider.of<SellerAuthController>(context, listen: false);
    await provider.getSellerData();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerHomeProvider>(context);
    final orderProvider = Provider.of<SellerOrderProvider>(context);
    var m = MediaQuery.of(context).size;
    int ordersInProgressCount = orderProvider.allOrders
        .where((order) => order.status == 'In Progress')
        .length;

    int ordersWaitingCount = orderProvider.allOrders
        .where((order) => order.status == 'Order placed')
        .length;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: m.height * 0.37,
                  child: Column(
                    children: [
                      Consumer<SellerAuthController>(
                          builder: (context, authprovider, child) {
                        log(authprovider.seller.toString());
                        log('${StaticData.userId}');

                        final user = authprovider.seller;
                        log(user.toString());
                        log(user?.image.toString() ?? '');
                        if (user == null) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                          height: m.height * 0.34,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: colorScheme(context).secondary,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(50))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        provider.updateSellerBool(true);
                                        provider.setCurrentIndex(4);
                                        context.pushNamed(
                                            AppRoute.sellerNotificationPage);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Center(
                                            child: SvgPicture.asset(
                                                AppIcons.bellIcon)),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: colorScheme(context)
                                                    .surface,
                                                width: 2)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.updateSellerBool(true);
                                        provider.setCurrentIndex(4);
                                        context.pushNamed(
                                            AppRoute.sellerProfilePage);
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: user.image ??
                                                StaticData.defultImage,
                                            imageBuilder:
                                                (context, imageProvider) =>
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
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          // Image.network(
                                          //   user.image ?? '',
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: GestureDetector(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'Heyyyyyy ',
                                            style: textTheme(context)
                                                .titleMedium
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  color: colorScheme(context)
                                                      .surface,
                                                ),
                                          ),
                                          TextSpan(
                                            text: '${user.name} !',
                                            style: textTheme(context)
                                                .titleMedium
                                                ?.copyWith(
                                                  fontSize: 16,
                                                  color: colorScheme(context)
                                                      .surface,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .sellerHomeActionPrompt,
                                    style: textTheme(context)
                                        .headlineLarge
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20.0),
                //   child: CustomContainer(
                //     boxShadow: [
                //       BoxShadow(
                //           color:
                //               colorScheme(context).onSurface.withOpacity(.10),
                //           offset: Offset(0, 3),
                //           blurRadius: 12)
                //     ],
                //     child: CustomTextFormField(
                //       fillColor: colorScheme(context).surface,
                //       borderRadius: 15,
                //       hint: AppLocalizations.of(context)!.searchBarHint,
                //       hintColor: AppColor.appGreyColor.withOpacity(.5),
                //       prefixIcon: Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: SvgPicture.asset(AppIcons.searchIcon),
                //       ),
                //       suffixIcon: SizedBox(
                //         width: 55,
                //         height: 40,
                //         child: Center(
                //           child: CustomContainer(
                //             height: 39,
                //             width: 39,
                //             borderRadius: 10,
                //             color: colorScheme(context).secondary,
                //             child: Center(
                //                 child: SvgPicture.asset(
                //               AppIcons.moreIcon,
                //               height: 22,
                //             )),
                //           ),
                //         ),
                //       ),
                //       contentPadding: EdgeInsets.symmetric(vertical: 20),
                //     ),
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: CustomContainer(
            //     height: 53,
            //     color: colorScheme(context).surface,
            //     borderColor: AppColor.appGreyColor.withOpacity(.2),
            //     borderRadius: 9,
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 0.0),
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.symmetric(
            //               horizontal: 8.0,
            //             ),
            //             child: Text(
            //               AppLocalizations.of(context)!
            //                   .sellerHomeSwitchToResponsibleMode,
            //               style: textTheme(context).bodySmall?.copyWith(
            //                   color: AppColor.appGreyColor.withOpacity(.8),
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.w600),
            //             ),
            //           ),
            //           Spacer(),
            //           Consumer<SellerHomeProvider>(
            //             builder: (context, value, child) => CustomSwitch(
            //               value: value.switchToggle,
            //               onChanged: (p0) {
            //                 value.updateSwitchStatus();

            //                 // if (p0) {
            //                 //   context.pushReplacementNamed(
            //                 //       AppRoute.responsibleBottomBar);
            //                 // } else {
            //                 //   context.pushReplacementNamed(
            //                 //       AppRoute.sellerBottomBar);
            //                 // }
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  CustomContainer(
                    height: 144,
                    borderRadius: 8,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    color: AppColor.aliceBlueColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          orderProvider.allOrders.length.toString(),
                          style: textTheme(context).displaySmall?.copyWith(
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          AppLocalizations.of(context)!.sellerHomeOrdersTaken,
                          style: textTheme(context).displaySmall?.copyWith(
                                color: AppColor.appGreyColor
                                    .withOpacity(.6), //Color(0xff97919B),
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.sellerHomeByMe,
                          style: textTheme(context).displaySmall?.copyWith(
                              color: AppColor.appGreyColor.withOpacity(.6),
                              fontWeight: FontWeight.w400,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomContainer(
                          height: 67,
                          width: m.width * 0.53,
                          borderRadius: 8,
                          color: AppColor.lightGreenColor,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ordersInProgressCount.toString(),
                                  style: textTheme(context)
                                      .titleLarge
                                      ?.copyWith(
                                        color: colorScheme(context).onSurface,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .sellerHomeOrdersBySomeone,
                                    style:
                                        textTheme(context).titleLarge?.copyWith(
                                              color: AppColor.appGreyColor
                                                  .withOpacity(.6),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                            ),
                                  ),
                                  // TextSpan(
                                  //   text: ' by someone',
                                  //   style:
                                  //       textTheme(context).titleLarge?.copyWith(
                                  //             color: AppColor.appGreyColor
                                  //                 .withOpacity(.6),
                                  //             fontWeight: FontWeight.w400,
                                  //             fontSize: 14,
                                  //           ),
                                  // ),
                                ])),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      CustomContainer(
                          height: 67,
                          // padding: EdgeInsets.symmetric(horizontal: 10),
                          width: m.width * 0.53,
                          borderRadius: 8,
                          color: AppColor.peachColor.withOpacity(.4),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  ordersWaitingCount.toString(),
                                  style: textTheme(context)
                                      .titleLarge
                                      ?.copyWith(
                                        color: colorScheme(context).onSurface,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .sellerHomeOrdersOnWaiting,
                                  style:
                                      textTheme(context).titleLarge?.copyWith(
                                            color: AppColor.appGreyColor
                                                .withOpacity(.6),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                          ),
                                )
                              ],
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.sellerHomePendingOrders,
                    style: textTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColor.naviBlueColor,
                        ),
                  ),
                ],
              ),
            ),
            Consumer<SellerOrderProvider>(
              builder: (context, orderProvder, child) {
                if (orderProvder.isAllOrdersLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = orderProvder.allOrders
                    .where(
                      (order) => order.status == "pending",
                    )
                    .toList();

                if (data.isEmpty) {
                  return SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Text("No Pending Order"),
                    ),
                  );
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: GridView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 245,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final order = data[index];
                      return CustomContainer(
                        onTap: () async {
                          context.loaderOverlay.show();
                          final userProvider = Provider.of<UserDataProvider>(
                              context,
                              listen: false);
                          final customer = await userProvider.getUserById(
                              userId: order.userId);
                          context.loaderOverlay.hide();
                          if (customer != null) {
                            print(customer);
                            // sellerOrderDialog(
                            //   context: context,
                            //   order: order,
                            //   customer: customer,
                            //   isAccepted:
                            //       order.status == 'In Progress' ? true : false,
                            // );

                            log('----------customer token ------${customer}');
                            sellerRedyForPickupDialogue(
                                context: context,
                                order: order,
                                customer: customer,
                                isAccepted: true);
                          }
                        },
                        color: colorScheme(context).surface,
                        boxShadow: [
                          BoxShadow(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(.25),
                              offset: Offset(0, 1),
                              blurRadius: 2)
                        ],
                        borderColor: AppColor.appGreyColor.withOpacity(.02),
                        borderRadius: 24,
                        child: Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24)),
                                child: Container(
                                  width: double.infinity,
                                  // child: CachedNetworkImage(
                                  //   imageUrl:
                                  //       Uri.parse(ApiEndpoints.baseImageUrl)
                                  //           .resolve(order
                                  //               .orderItems[0].foodItem!.image
                                  //               .toString())
                                  //           .toString(),
                                  //   height: 137,
                                  //   fit: BoxFit.cover,
                                  //   errorWidget: (context, url, error) =>
                                  //       Icon(Icons.image_outlined),
                                  //   placeholder: (context, url) => Center(
                                  //     child: CircularProgressIndicator(),
                                  //   ),
                                  // ),
                                  child: CachedNetworkImage(
                                    imageUrl: order.orderItems.isNotEmpty
                                        ? Uri.parse(ApiEndpoints.baseImageUrl)
                                            .resolve(order.orderItems.first
                                                .foodItem!.image
                                                .toString())
                                            .toString()
                                        : 'https://images.slurrp.com/prod/recipe_images/transcribe/main%20course/shahi-chicken-korma.webp?impolicy=slurrp-20210601&width=1200&height=675',
                                    width: 95,
                                    height: 75,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        width: 95,
                                        height: 75,
                                        color: Colors.white,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error, size: 24),
                                  ),
                                )),
                            Expanded(
                              child: CustomContainer(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.id.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onSurface,
                                              fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "address N/A",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme(context)
                                          .bodyMedium
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onSurface
                                                  .withOpacity(.5),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 10),
                                    ),
                                    Spacer(),
                                    // SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Cancel',
                                            style: textTheme(context)
                                                .bodyMedium
                                                ?.copyWith(
                                                    color: colorScheme(context)
                                                        .onSurface
                                                        .withOpacity(.5),
                                                    fontSize: 13),
                                          ),
                                          CustomContainer(
                                            borderRadius: 50,
                                            color:
                                                colorScheme(context).secondary,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 1.5),
                                            child: Text('Accept',
                                                style: textTheme(context)
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color:
                                                            colorScheme(context)
                                                                .surface,
                                                        fontSize: 13)),
                                          )
                                        ])
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
