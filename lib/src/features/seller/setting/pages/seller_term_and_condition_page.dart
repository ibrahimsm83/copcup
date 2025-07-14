import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerTermAndConditionPage extends StatelessWidget {
  const SellerTermAndConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back)),
        title: Text(
          AppLocalizations.of(context)!.termsConditionOption,
          style: textTheme(context).headlineSmall?.copyWith(
                fontSize: 21,
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.userResponsibilitiesTitle,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.userResponsibilitiesContent,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(.50),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.dataPrivacyTitle,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.dataPrivacyContent,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(.50),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.conditionsTitle,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.conditionsContent,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(.50),
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
