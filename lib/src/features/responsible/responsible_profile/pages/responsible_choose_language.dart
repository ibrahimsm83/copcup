import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/app_localiztion/provider/app_language_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import '../../../../common/widgets/custom_buton.dart';

class ResponsibleChooseLanguagePage extends StatefulWidget {
  const ResponsibleChooseLanguagePage({super.key});

  @override
  State<ResponsibleChooseLanguagePage> createState() =>
      ResponsibleChooseLanguagePageState();
}

class ResponsibleChooseLanguagePageState
    extends State<ResponsibleChooseLanguagePage> {
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
        builder: (context, value, child) => value.resChoseLanguage
            ? ResponsibleChooseLanguageWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleChooseLanguageWidget extends StatelessWidget {
  ResponsibleChooseLanguageWidget({super.key});
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English (US)', 'flag': AppImages.usFlag},
    {'code': 'fr', 'name': 'French (FR)', 'flag': AppImages.franceFlag},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appLanguageNotifier = Provider.of<AppLanguageNotifier>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                AppLocalizations.of(context)!.app_language,
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
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected =
                    appLanguageNotifier.locale.languageCode == language['code'];

                return GestureDetector(
                  onTap: () {
                    appLanguageNotifier.changeLanguage(
                      Locale(language['code']!),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(23.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? colorScheme(context).secondary
                            : Colors.transparent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(language['flag']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            language['name']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? colorScheme(context).secondary
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check,
                              color: colorScheme(context).secondary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          CustomButton(
            iconColor: colorScheme(context).secondary,
            arrowCircleColor: colorScheme(context).surface,
            text: AppLocalizations.of(context)!.select_language,
            backgroundColor: colorScheme(context).secondary,
            onPressed: () {
              if (appLanguageNotifier.locale.languageCode.isNotEmpty) {
                context.pushNamed(AppRoute.responsibleBottomBar);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please select a language'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
