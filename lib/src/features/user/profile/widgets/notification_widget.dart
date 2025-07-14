import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/notification_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Icon(Icons.arrow_back)),
                Text(
                  AppLocalizations.of(context)!.notificationTitle,
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
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.todayLabel,
                style: textTheme(context).headlineSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            NotificationTile(
              imagesvg: AppIcons.bookMarkIcon,
              title: "30% Special Discount",
              subtitle: 'Special Discount valid today',
            ),
            SizedBox(
              height: 10,
            ),
            NotificationTile(
              imagesvg: AppIcons.lockIcon,
              title: "Password Updated",
              subtitle: 'Your password Updated successfuly',
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                AppLocalizations.of(context)!.yesterdayLabel,
                style: textTheme(context).headlineSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationTile(
                imagesvg: AppIcons.recipientIcon,
                title: "Account Setup Successfully",
                subtitle: 'Account has been set',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            NotificationTile(
              imagesvg: AppIcons.profileInActiveIcon,
              title: "Debit Card Added Successfully",
              subtitle: 'Card has been added successfully',
            ),
          ],
        ),
      ),
    );
  }
}

class ResponsibleNotificationWidget extends StatelessWidget {
  const ResponsibleNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    AppLocalizations.of(context)!.notificationTitle,
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.todayLabel,
                  style: textTheme(context).headlineSmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              NotificationTile(
                imagesvg: AppIcons.bookMarkIcon,
                title: "30% Special Discount",
                subtitle: 'Special Discount valid today',
              ),
              SizedBox(
                height: 10,
              ),
              NotificationTile(
                imagesvg: AppIcons.lockIcon,
                title: "Password Updated",
                subtitle: 'Your password Updated successfuly',
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.yesterdayLabel,
                  style: textTheme(context).headlineSmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {},
                child: NotificationTile(
                  imagesvg: AppIcons.recipientIcon,
                  title: "Account Setup Successfully",
                  subtitle: 'Account has been set',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              NotificationTile(
                imagesvg: AppIcons.profileInActiveIcon,
                title: "Debit Card Added Successfully",
                subtitle: 'Card has been added successfully',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponsibleNotification extends StatelessWidget {
  ResponsibleNotification({super.key});

  @override
  Widget build(BuildContext context) {
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
        builder: (context, value, child) => value.resNotification
            ? ResponsibleNotificationWidget()
            : ResponsibleProfilePage()),
  ];
}
