// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';

import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/controller/contact_us_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class UserContactUsPage extends StatelessWidget {
  UserContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      resizeToAvoidBottomInset: false,
      body: Consumer<NavigationProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    UserHomePage(),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    Consumer<NavigationProvider>(
        builder: (context, value, child) => value.userContactUsBool
            ? UserContactUsPageWidget()
            : ProfilePage()),
  ];
}

class UserContactUsPageWidget extends StatefulWidget {
  const UserContactUsPageWidget({super.key});

  @override
  State<UserContactUsPageWidget> createState() =>
      _UserContactUsPageWidgetState();
}

class _UserContactUsPageWidgetState extends State<UserContactUsPageWidget> {
  @override
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatController>(context);
    final userProvider = Provider.of<UserDataProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  Text(
                    AppLocalizations.of(context)!.contactUsTitle,
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
              Container(
                height: 115,
                width: 115,
                child: Center(
                    child: SvgPicture.asset(
                  AppIcons.sellerContactUsIcon,
                  height: 40,
                )),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme(context).secondary,
                    border: Border.all(
                      color: colorScheme(context).surface,
                      width: 4,
                    ),
                    boxShadow: [
                      BoxShadow(
                          color:
                              colorScheme(context).onSurface.withOpacity(.25),
                          offset: Offset(0, 2),
                          blurRadius: 10)
                    ]),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.nameHint,
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                fillColor: colorScheme(context).surface,
                filled: true,
                focusBorderColor: AppColor.appGreyColor.withOpacity(.15),
                controller: nameController,
                validationType: ValidationType.name,
                borderRadius: 12,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderColor: AppColor.appGreyColor.withOpacity(.15),
                // focusNode: FocusNode(),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                hint: 'Enter here name',
                hintSize: 12,
                hintColor: AppColor.appGreyColor.withOpacity(.7),
              ),
              SizedBox(
                height: 10,
              ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     AppLocalizations.of(context)!.emailHint,
              //     style: textTheme(context)
              //         .titleSmall
              //         ?.copyWith(color: colorScheme(context).onSurface),
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CustomTextFormField(
              //   fillColor: colorScheme(context).surface,
              //   filled: true,
              //   controller: emailController,
              //   validationType: ValidationType.email,
              //   autoValidateMode: AutovalidateMode.onUserInteraction,
              //   borderRadius: 12,
              //   borderColor: AppColor.appGreyColor.withOpacity(.15),
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              //   hint: 'Enter here email',
              //   hintSize: 12,
              //   hintColor: AppColor.appGreyColor.withOpacity(.7),
              // ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.messageFieldLabel,
                  style: textTheme(context)
                      .titleSmall
                      ?.copyWith(color: colorScheme(context).onSurface),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                maxline: 8,
                fillColor: colorScheme(context).surface,
                filled: true,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                controller: msgController,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Message'),
                borderRadius: 12,
                focusBorderColor: AppColor.appGreyColor.withOpacity(.15),
                borderColor: AppColor.appGreyColor.withOpacity(.15),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                hint: AppLocalizations.of(context)!.messageFieldHint,
                hintSize: 12,
                hintColor: AppColor.appGreyColor.withOpacity(.7),
              ),
              SizedBox(
                height: 100,
              ),
              Consumer<ContactUsController>(
                builder: (context, provider, child) => CustomButton(
                  height: 55,
                  arrowCircleRadius: 22,
                  text: AppLocalizations.of(context)!.submitButton,
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      final overlay = context.loaderOverlay;

                      overlay.show();
                      await chatProvider.createChatRoom(
                          onSuccess: (val) {
                            context.pushNamed(
                              AppRoute.userChat,
                              extra: {
                                'id': val.id,
                                'reciverName': 'Admin User'
                              },
                            );
                            chatProvider.sendMessage(
                                context: context,
                                chatRoomID: val.id,
                                message: msgController.text.toString());
                          },
                          name: userProvider.user!.name,
                          members: [
                            StaticData.userId,
                            1,
                          ],
                          type: 'private',
                          context: context);

                      provider.contactUs(
                        name: nameController.text,
                        email: emailController.text,
                        message: msgController.text,
                        onSuccess: (message) async {
                          overlay.hide();
                          showSnackbar(message: 'Sucess$message');
                        },
                        onError: (error) {
                          showSnackbar(message: error, isError: true);
                        },
                      );
                    }
                  },
                  iconColor: colorScheme(context).secondary,
                  textColor: colorScheme(context).surface,
                  arrowCircleColor: colorScheme(context).surface,
                  backgroundColor: colorScheme(context).secondary,
                  boxShadow: [BoxShadow()],
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
