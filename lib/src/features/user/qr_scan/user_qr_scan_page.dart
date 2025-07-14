import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class UserQrScanPage extends StatefulWidget {
  const UserQrScanPage({
    super.key,
  });

  @override
  UserQrScanPageState createState() => UserQrScanPageState();
}

class UserQrScanPageState extends State<UserQrScanPage> {
  final UserDataProvider userdataprovider = UserDataProvider();

  @override
  Widget build(BuildContext context) {
    log('---');
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context)!.qrTitle,
              style: textTheme(context).headlineMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Center(
          child: Consumer<NavigationProvider>(
            builder: (context, value, child) =>
                value.qrImage == null || value.qrImage!.isEmpty
                    ? Center(
                        child: Text(
                        AppLocalizations.of(context)!.na_selectOrderFirst,
                        style: textTheme(context).bodyLarge?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 18),
                      ))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          QrImageView(
                            data: value.qrImage ?? '',
                            version: QrVersions.auto,
                            size: 200.0,
                          ),
// SizedBox(
//                                         height: 10,
//                                       ),
//                                       Center(
//                                         child: Text(
//                                             value.qrImage!,
//                                             style: textTheme(context)
//                                                 .titleSmall
//                                                 ?.copyWith(
//                                                     color: colorScheme(context)
//                                                         .onSurface
//                                                         .withOpacity(.5),
//                                                     fontWeight:
//                                                         FontWeight.w400)),
//                                       ),
                          // SvgPicture.network(
                          //   Uri.parse(ApiEndpoints.baseImageUrl)
                          //       .resolve(value.qrImage.toString())
                          //       .toString(),
                          //   height: 230,
                          //   width: 190,
                          //   placeholderBuilder: (BuildContext context) =>
                          //       CircularProgressIndicator(),
                          //   fit: BoxFit.contain,
                          // ),
                          SizedBox(
                            height: 40,
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
                                  color: colorScheme(context)
                                      .onSurface
                                      .withOpacity(.50),
                                ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                        ],
                      ),
          ),
        ));
  }
}
