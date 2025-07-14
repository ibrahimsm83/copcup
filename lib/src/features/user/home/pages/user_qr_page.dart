import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';

import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';

import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class UserQrPage extends StatelessWidget {
  const UserQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerHomeProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.showQrCode,
              style: textTheme(context).headlineMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Lottie.asset(
                  AppLottieImage.scanLottie,
                  height: 350,
                  width: 350,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  AppLocalizations.of(context)!.scanQrTitle,
                  style: textTheme(context).headlineMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.scanQrSubtitle,
                  textAlign: TextAlign.center,
                  style: textTheme(context).bodySmall?.copyWith(
                        fontSize: 10,
                        color: colorScheme(context).onSurface.withOpacity(.50),
                      ),
                ),
                SizedBox(
                  height: 35,
                ),
                CustomContainer(
                  borderRadius: 100,
                  color: colorScheme(context).primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.scanQrButton,
                      style: textTheme(context).bodyMedium?.copyWith(
                          color: colorScheme(context).surface,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
