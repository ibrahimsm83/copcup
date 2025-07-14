import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';

import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class SellerQrPage extends StatelessWidget {
  const SellerQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SellerHomeProvider>(context);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            forceMaterialTransparency: true,
            centerTitle: true,
            title: Text(
              "Qr Code",
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
                LottieBuilder.asset(
                  AppLottieImage.scanLottie,
                  height: 350,
                  width: 350,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Scan QR Code',
                  style: textTheme(context).headlineMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'The QR code will be automatically detected \nwhen you position it between the guide lines',
                  textAlign: TextAlign.center,
                  style: textTheme(context).bodySmall?.copyWith(
                        fontSize: 10,
                        color: colorScheme(context).onSurface.withOpacity(.50),
                      ),
                ),
                SizedBox(
                  height: 30,
                ),
                CustomContainer(
                  borderRadius: 100,
                  color: colorScheme(context).secondary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  width: MediaQuery.of(context).size.width - 50,
                  child: Center(
                    child: Text(
                      'Scan',
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
