import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/professional_qr/professional_qr_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ResponsibleManageAccountPage extends StatefulWidget {
  const ResponsibleManageAccountPage({super.key});

  @override
  State<ResponsibleManageAccountPage> createState() =>
      _ResponsibleManageAccountPageState();
}

class _ResponsibleManageAccountPageState
    extends State<ResponsibleManageAccountPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSeller();
      // getResponsible();
    });

    super.initState();
  }

  getSeller() async {
    final provider = Provider.of<SellerAuthController>(context, listen: false);
    await provider.getSellerList();
    print("sellers are ${provider.allSellerList}");
  }

  // getResponsible() async {
  //   final provider =
  //       Provider.of<ResponsibleAuthController>(context, listen: false);
  //   await provider.getProfessionalData();
  //   print(provider.professional);
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerAuthController>(context);

    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resAllSeller
            ? ResponsibleAllSellerWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleAllSellerWidget extends StatefulWidget {
  const ResponsibleAllSellerWidget({super.key});

  @override
  State<ResponsibleAllSellerWidget> createState() =>
      _ResponsibleAllSellerWidgetState();
}

class _ResponsibleAllSellerWidgetState
    extends State<ResponsibleAllSellerWidget> {
  @override
  getSeller() async {
    final provider = Provider.of<SellerAuthController>(context, listen: false);
    await provider.getSellerList();
    print("sellers are ${provider.allSellerList}");
  }

  Widget build(BuildContext context) {
    final resNavbarProvider = Provider.of<ResponsibleHomeProvider>(context);

    return RefreshIndicator(
      onRefresh: () async {
        await getSeller();
        // await getResponsible();
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.na_manageAccount,
                  style: textTheme(context).headlineSmall?.copyWith(
                        fontSize: 21,
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.na_sellerAccounts,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Consumer<SellerAuthController>(
                builder: (context, provider, child) {
                  if (provider.isSelerLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (provider.allSellerList.isEmpty) {
                    return Center(
                      child:
                          Text(AppLocalizations.of(context)!.na_noSellerFound),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.allSellerList.length,
                    itemBuilder: (context, index) {
                      print(provider.allSellerList);

                      final seller = provider.allSellerList[index];
                      log('the image of the selller is thsi ${seller.image}');
                      UserProfessionalModel userProfessionalModel =
                          UserProfessionalModel(
                              image: seller.image,
                              qrcode: seller.qrcode,
                              latitude: seller.latitude,
                              longitude: seller.longitude,
                              countryCode: seller.countryCode,
                              id: seller.id,
                              name: seller.name,
                              surName: seller.surName,
                              email: seller.email,
                              contactNumber: seller.contactNumber,
                              pin: seller.pin,
                              pinExpiresAt: seller.pinExpiresAt,
                              walletBalance: seller.walletBalance,
                              createdAt: seller.createdAt,
                              updatedAt: seller.updatedAt,
                              roles: seller.roles,
                              professional: seller.professional);
                      log('....................${seller.email}-----${seller.id}');
                      return AccountCard(
                        image: seller.image.toString(),
                        id: seller.id.toString(),
                        name: seller.name,
                        editOnTap: () {
                          context.pushNamed(AppRoute.editSellerPage, extra: {
                            'userProfessionalModel': userProfessionalModel
                          });
                        },
                        role: AppLocalizations.of(context)!.role_seller,
                        selected: false,
                      );
                    },
                  );
                },
              ),
            ),
            CustomButton(
              text: AppLocalizations.of(context)!.na_addSellerAccount,
              onPressed: () {
                resNavbarProvider.updateResponsibleBool(true);
                context.pushNamed(AppRoute.addSellerAccount);
              },
              backgroundColor: colorScheme(context).secondary,
              iconColor: colorScheme(context).secondary,
            ),
            // SizedBox(
            //   height: 10,
            // )
          ],
        ),
      ),
    );
  }
}

class AccountCard extends StatefulWidget {
  final String id;
  final String name;
  final String role;
  final bool selected;
  final String image;
  final void Function()? editOnTap;
  final void Function()? deletOnTap;

  AccountCard({
    required this.id,
    required this.name,
    required this.role,
    required this.selected,
    this.editOnTap,
    this.deletOnTap,
    required this.image,
  });

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  getSeller() async {
    final provider = Provider.of<SellerAuthController>(context, listen: false);
    await provider.getSellerList();
    print("sellers are ${provider.allSellerList}");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerAuthController>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: colorScheme(context).onSurface.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor: colorScheme(context).secondary,
            child: CachedNetworkImage(
              imageUrl: widget.image ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
              imageBuilder: (context, imageProvider) => CircleAvatar(
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            //  SvgPicture.asset(
            //   AppIcons.profileInActiveIcon,
            //   height: 17,
            // ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.id,
                  style: textTheme(context).labelMedium?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.3),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.green,
              child: IconButton(
                onPressed: widget.editOnTap,
                // onPressed: () {
                //   context.pushNamed(AppRoute.editSellerPage);
                // },
                icon: Icon(
                  Icons.edit,
                  color: colorScheme(context).surface,
                  size: 15,
                ),
              ),
            ),
          ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.red,
            child: IconButton(
              // onPressed: deletOnTap,
              onPressed: () async {
                await provider
                    .deleteSeller(context: context, id: widget.id)
                    .then((onValue) {
                  getSeller();
                });
              },
              icon: Icon(
                Icons.delete,
                color: colorScheme(context).surface,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfessionalCard extends StatelessWidget {
  final String name;
  final String image;
  final String role;
  final bool selected;

  ProfessionalCard(
      {required this.name,
      required this.role,
      required this.selected,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: colorScheme(context).onSurface.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // CircleAvatar(
          //     radius: 19,
          //     backgroundColor: colorScheme(context).secondary,
          //     child: SvgPicture.asset(
          //       AppIcons.profileInActiveIcon,
          //       height: 17,
          //     )),

          CircleAvatar(
            radius: 19,
            backgroundColor: colorScheme(context).secondary,
            child: CachedNetworkImage(
              imageUrl: image ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
              imageBuilder: (context, imageProvider) => CircleAvatar(
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            //  SvgPicture.asset(
            //   AppIcons.profileInActiveIcon,
            //   height: 17,
            // ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  role,
                  style: textTheme(context).labelMedium?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.3),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.green,
              child: IconButton(
                onPressed: () {
                  context.pushNamed(AppRoute.editResponsibleProfile);
                },
                icon: Icon(
                  Icons.edit,
                  color: colorScheme(context).surface,
                  size: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
