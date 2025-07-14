import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/controller/contact_us_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
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
        builder: (context, value, child) => value.resContactus
            ? ResponsibleContactUsWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleContactUsWidget extends StatelessWidget {
  ResponsibleContactUsWidget({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatController>(context);
    final sellerprovider = Provider.of<ResponsibleAuthController>(context);

    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
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
              //   // child: Text(
              //   //   AppLocalizations.of(context)!.emailHint,
              //   //   style: textTheme(context)
              //   //       .titleSmall
              //   //       ?.copyWith(color: colorScheme(context).onSurface),
              //   // ),
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
                height: 30,
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
                          name: 'sellerprovider.professional!.name',
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
