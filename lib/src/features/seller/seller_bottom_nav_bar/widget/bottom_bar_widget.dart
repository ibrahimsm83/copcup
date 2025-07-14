import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class SellerBottomBarWidget extends StatelessWidget {
  SellerBottomBarWidget({super.key});

  @override
  final List<String> inactiveIcons = [
    AppIcons.sellerHome,
    AppIcons.sellerStock,
    AppIcons.qrIcon,
    AppIcons.sellerOrder,
    AppIcons.sellerProfile,
  ];

  final List<String> activeIcons = [
    AppIcons.sellerHomeOutline,
    AppIcons.sellerStockOutline,
    AppIcons.qrIcon,
    AppIcons.sellerOrderOutline,
    AppIcons.sellerProfileOutline,
  ];

  final List<String> bottomBarText = [
    'Home',
    'Stocks',
    '',
    'Orders',
    'Profile',
  ];

  Widget build(BuildContext context) {
    return Consumer<SellerHomeProvider>(
      builder: (context, value, child) => Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: colorScheme(context).secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Consumer(
                builder: (context, value, child) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavBarItem(context, index: 0),
                        _buildNavBarItem(context, index: 1),
                        const SizedBox(width: 60),
                        _buildNavBarItem(context, index: 3),
                        _buildNavBarItem(context, index: 4),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -20,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: GestureDetector(
              onTap: () {
                // navigationProvider.setCurrentIndex(2);
              },
              child: Container(
                  height: 70,
                  width: 65,
                  decoration: BoxDecoration(
                    color: colorScheme(context).surface,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          value.setCurrentIndex(2);
                        },
                        child: CircleAvatar(
                          radius: 26,
                          backgroundColor: colorScheme(context).secondary,
                          child: Center(
                            child: SvgPicture.asset(
                              AppIcons.qrIcon,
                              color: Theme.of(context).colorScheme.surface,
                              width: 30,
                              height: 30,
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(BuildContext context, {required int index}) {
    final navigationProvider = Provider.of<SellerHomeProvider>(context);
    bool isActive = navigationProvider.currentIndex == index;

    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          child: SvgPicture.asset(
            isActive ? activeIcons[index] : inactiveIcons[index],
            width: 24,
            height: 24,
          ),
          onTap: () {
            navigationProvider.updateSellerBool(false);
            navigationProvider.setCurrentIndex(index);
          },
        ),
        Text(
          bottomBarText[index],
          style: textTheme(context).labelSmall?.copyWith(
              fontSize: 8,
              color: isActive
                  ? colorScheme(context).surface
                  : AppColor.appGreyColor.withOpacity(.75)),
        ),
      ],
    );
  }
}
