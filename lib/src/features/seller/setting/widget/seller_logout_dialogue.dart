import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SellerLogOutDialogue extends StatefulWidget {
  const SellerLogOutDialogue({super.key});

  @override
  State<SellerLogOutDialogue> createState() => _SellerLogOutDialogueState();
}

class _SellerLogOutDialogueState extends State<SellerLogOutDialogue> {
  final AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    return CustomContainer(
        height: m.height * 0.2,
        width: m.width,
        borderRadius: 0,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!.logoutConfirmation,
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              CustomContainer(
                onTap: () {
                  Navigator.pop(context);
                },
                height: 45,
                width: 170,
                color: colorScheme(context).surface,
                borderRadius: 100,
                borderColor: colorScheme(context).secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        AppLocalizations.of(context)!.cancel_button,
                        style: textTheme(context)
                            .titleSmall
                            ?.copyWith(color: colorScheme(context).secondary),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: colorScheme(context).secondary,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: colorScheme(context).surface,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              CustomContainer(
                onTap: () {
                  authController.logout(
                    context: context,
                    onError: (val) {},
                    onSuccess: (val) async {
                      StaticData.isLoggedIn = false;
                      await SharedPrefHelper.saveBool(isLoggedInText, false);

                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();

                      final tempDir = await getTemporaryDirectory();
                      if (tempDir.existsSync()) {
                        tempDir.deleteSync(recursive: true);
                      }

                      MyAppRouter.clearAndNavigate(
                        context,
                        AppRoute.sigInMethodSelectionPage,
                      );
                    },

                    // onSuccess: (message) {
                    //   Navigator.pop(context);
                    //   MyAppRouter.clearAndNavigate(
                    //       context, AppRoute.sigInMethodSelectionPage);
                    // },
                    // (sucess) {
                    //   context.loaderOverlay.hide();
                    //   showSnackbar(
                    //     message: "Logout Sucessfully",
                    //     isError: false,
                    //   );
                    //   context.goNamed(AppRoute.sigInMethodSelectionPage,
                    //       extra: {'role': 'seller'});
                    // },
                    // (error) {
                    //   context.loaderOverlay.hide();
                    //   showSnackbar(
                    //     message: "Logout Failed",
                    //     isError: true,
                    //   );
                    // },
                  );
                },
                height: 45,
                width: 170,
                color: colorScheme(context).secondary,
                borderRadius: 100,
                borderColor: colorScheme(context).secondary,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        AppLocalizations.of(context)!.yesButton,
                        style: textTheme(context)
                            .titleSmall
                            ?.copyWith(color: colorScheme(context).surface),
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: colorScheme(context).surface,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            color: colorScheme(context).secondary,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ],
        ));
  }
}
