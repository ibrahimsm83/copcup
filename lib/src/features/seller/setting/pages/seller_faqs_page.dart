import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerFAQSPage extends StatefulWidget {
  SellerFAQSPage({super.key});

  @override
  _SellerFAQSPageState createState() => _SellerFAQSPageState();
}

class _SellerFAQSPageState extends State<SellerFAQSPage> {
  TextEditingController faqsController = TextEditingController();
  List<String> faqs =
      List.generate(4, (index) => 'Lorem ipsum dolor sit amet?');

  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Icon(Icons.arrow_back)),
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.faqs,
          style: textTheme(context).headlineSmall?.copyWith(
                fontSize: 21,
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      //  CustomAppBar(
      //   title: AppLocalizations.of(context)!.faqs,
      //   onLeadingPressed: () {
      //     context.pop();
      //   },

      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            CustomContainer(
              height: 50,
              width: double.infinity,
              color: colorScheme(context).secondary,
              borderRadius: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      'Lorem ipsum dolor sit amet?',
                      style: textTheme(context)
                          .bodyLarge
                          ?.copyWith(color: colorScheme(context).surface),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 30,
                      color: colorScheme(context).surface,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.',
              style: textTheme(context).bodySmall?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(.7),
                  letterSpacing: 0),
            ),
            SizedBox(height: 20),
            Column(
              children: List.generate(faqs.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: CustomContainer(
                    onTap: () {
                      faqsController.text = faqs[index];
                      showDialog(
                        context: context,
                        builder: (context) => Center(
                          child: CustomContainer(
                            height: m.height * 0.45,
                            width: m.width - 50,
                            color: colorScheme(context).surface,
                            borderRadius: 20,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'FAQS',
                                    style: textTheme(context)
                                        .titleLarge
                                        ?.copyWith(
                                          color: colorScheme(context).onSurface,
                                        ),
                                  ),
                                  SizedBox(height: 15),
                                  Material(
                                    child: CustomTextFormField(
                                      maxline: 8,
                                      controller: faqsController,
                                      fillColor: colorScheme(context).surface,
                                      borderColor: AppColor.appGreyColor
                                          .withOpacity(.15),
                                      focusBorderColor: AppColor.appGreyColor
                                          .withOpacity(.15),
                                      borderRadius: 12,
                                      hint: 'Enter FAQSs',
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomContainer(
                                        onTap: () {
                                          faqsController.text = '';
                                          Navigator.pop(context);
                                        },
                                        color: colorScheme(context).surface,
                                        borderRadius: 100,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 35, vertical: 5),
                                        borderColor:
                                            colorScheme(context).secondary,
                                        child: Text(
                                          'Cancel',
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                color: colorScheme(context)
                                                    .secondary,
                                              ),
                                        ),
                                      ),
                                      CustomContainer(
                                        onTap: () {
                                          setState(() {
                                            faqs[index] = faqsController.text;
                                          });
                                          Navigator.pop(context);
                                        },
                                        color: colorScheme(context)
                                            .secondaryContainer,
                                        borderRadius: 100,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 35, vertical: 5),
                                        borderColor:
                                            colorScheme(context).secondary,
                                        child: Text(
                                          'Save',
                                          style: textTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                color: colorScheme(context)
                                                    .surface,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    borderRadius: 100,
                    height: 40,
                    borderColor: AppColor.appGreyColor.withOpacity(.1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              faqs[index],
                              style: textTheme(context).bodyLarge?.copyWith(
                                  color: AppColor.appGreyColor.withOpacity(.7)),
                              maxLines: null,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 30,
                            color: colorScheme(context).onSurface,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
