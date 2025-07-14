import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/app_localiztion/provider/app_language_provider.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/custom_buton.dart';

class ChooseLanguagePage extends StatelessWidget {
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English (US)', 'flag': AppImages.usFlag},
    {'code': 'fr', 'name': 'French (FR)', 'flag': AppImages.franceFlag},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appLanguageNotifier = Provider.of<AppLanguageNotifier>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: "App Language",
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected = appLanguageNotifier.locale.languageCode ==
                      language['code'];

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
                              ? colorScheme(context).primary
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
                                    ? Theme.of(context).primaryColor
                                    : Colors.black,
                              ),
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check,
                                color: colorScheme(context).primary),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: 'Done',
              backgroundColor: colorScheme(context).secondary,
              onPressed: () {
                if (appLanguageNotifier.locale.languageCode.isNotEmpty) {
                  context.pushNamed(AppRoute.userBottomNavBar);
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
      ),
    );
  }
}
