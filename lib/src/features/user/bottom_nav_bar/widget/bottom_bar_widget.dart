import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/cart_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:badges/badges.dart' as badges;

class BottomBarWidget extends StatelessWidget {
  final VoidCallback? ontap;
  BottomBarWidget({super.key, this.ontap});
  int? orderCount;
  final List<String> _inactiveIcons = [
    AppIcons.homeInActiveIcon,
    AppIcons.searchInActiveIcon,
    AppIcons.qrIcon,
    AppIcons.calenderInActiveIcon,
    AppIcons.profileInActiveIcon,
  ];

  final List<String> _activeIcons = [
    AppIcons.homeActiveIcon,
    AppIcons.searchActiveIcon,
    AppIcons.qrIcon,
    AppIcons.calenderActiveIcon,
    AppIcons.profileActiveIcon,
  ];
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final cartItemCount = cartProvider.cartItems
        .fold<int>(0, (sum, item) => sum + item.quantity.value);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: colorScheme(context).primary,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavBarItem(context, index: 0),
                _buildNavBarItem(context, index: 1),
                const SizedBox(width: 60),
                // Calendar Icon with Badge (Item Count)
                _buildNavBarItemWithBadge(context,
                    index: 3, cartItemCount: cartItemCount),
                _buildNavBarItem(context, index: 4),
              ],
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: MediaQuery.of(context).size.width / 2 - 30,
          child: GestureDetector(
              onTap: () {
                navigationProvider.setCurrentIndex(2);
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
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: colorScheme(context).primary,
                        child: Center(
                          child: SvgPicture.asset(
                            AppIcons.qrIcon,
                            color: Theme.of(context).colorScheme.surface,
                            width: 30,
                            height: 30,
                          ),
                        ),
                      )
                    ],
                  ))),
        ),
      ],
    );
  }

  Widget _buildNavBarItem(BuildContext context, {required int index}) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    bool isActive = navigationProvider.currentIndex == index;

    return IconButton(
      icon: SvgPicture.asset(
        isActive ? _activeIcons[index] : _inactiveIcons[index],
        width: 24,
        height: 24,
      ),
      onPressed: () {
        navigationProvider.setCurrentIndex(index);
        navigationProvider.updateEventBool(false);
      },
    );
  }

  Widget _buildNavBarItemWithBadge(BuildContext context,
      {required int index, required int cartItemCount}) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    bool isActive = navigationProvider.currentIndex == index;

    return orderCount == null
        ? IconButton(
            icon: SvgPicture.asset(
              isActive ? _activeIcons[index] : _inactiveIcons[index],
              width: 24,
              height: 24,
            ),
            onPressed: () {
              navigationProvider.setCurrentIndex(index);
            },
          )
        : badges.Badge(
            badgeContent: Text(
              orderCount.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            position: BadgePosition.topEnd(top: 0, end: 3),
            child: IconButton(
              icon: SvgPicture.asset(
                isActive ? _activeIcons[index] : _inactiveIcons[index],
                width: 24,
                height: 24,
              ),
              onPressed: () {
                navigationProvider.setCurrentIndex(index);
              },
            ),
          );
  }
}
