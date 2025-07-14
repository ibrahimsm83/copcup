import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';

import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'package:provider/provider.dart';

class AddSellerPage extends StatefulWidget {
  const AddSellerPage({super.key});

  @override
  State<AddSellerPage> createState() => _AddSellerPageState();
}

class _AddSellerPageState extends State<AddSellerPage> {
  @override
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
        builder: (context, value, child) => value.resCreateSeller
            ? ResponsibleCreateSellerWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleCreateSellerWidget extends StatefulWidget {
  const ResponsibleCreateSellerWidget({super.key});

  @override
  State<ResponsibleCreateSellerWidget> createState() =>
      _ResponsibleCreateSellerWidgetState();
}

class _ResponsibleCreateSellerWidgetState
    extends State<ResponsibleCreateSellerWidget> {
  final email = TextEditingController();
  final name = TextEditingController();
  final surName = TextEditingController();
  final attributedEvent = TextEditingController();
  final password = TextEditingController();
  final address = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<EventModel> events = [];
  int? selectedEventId;
  String? selectedEvent;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProfessionalEvents();
    });
    super.initState();
  }

  getProfessionalEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getProfessionalUnAssignedEvents();
    if (mounted) {
      setState(() {
        events = provider.professionalUnAssignedEventList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatController>(context);

    final visibilityProvider =
        Provider.of<PasswordVisibilityProvider>(context, listen: false);
    final sellerAuthController =
        Provider.of<SellerAuthController>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Icon(Icons.arrow_back)),
            SizedBox(
              height: 10,
            ),
            Text(
              AppLocalizations.of(context)!.na_createSellerAccount,
              style: textTheme(context).headlineSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              AppLocalizations.of(context)!
                  .na_askInformationToManageSellerAccount,
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.nameHint,
              inputAction: TextInputAction.next,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validationType: ValidationType.name,
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: name,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              isDense: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.surNameHint,
              inputAction: TextInputAction.next,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  Validation.fieldValidation(value, ' Sur Name'),
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: surName,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              isDense: true,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              hint: AppLocalizations.of(context)!.emailHint,
              inputAction: TextInputAction.next,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              validationType: ValidationType.email,
              borderRadius: 12,
              hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              controller: email,
              filled: true,
              fillColor: colorScheme(context).surface,
              borderColor: colorScheme(context).onSurface.withOpacity(.10),
              height: 70,
              focusBorderColor: colorScheme(context).onSurface.withOpacity(.10),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SvgPicture.asset(
                  AppIcons.emailIcon,
                  height: 15,
                ),
              ),
              isDense: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<PasswordVisibilityProvider>(
              builder: (context, visibilityProvider, child) {
                return CustomTextFormField(
                  obscureText: visibilityProvider.isPasswordObscured,
                  hint: AppLocalizations.of(context)!.passwordHint,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validationType: ValidationType.password,
                  borderRadius: 12,
                  hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                  controller: password,
                  filled: true,
                  fillColor: colorScheme(context).surface,
                  borderColor: colorScheme(context).onSurface.withOpacity(.10),
                  height: 60,
                  focusBorderColor:
                      colorScheme(context).onSurface.withOpacity(.10),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(
                      AppIcons.lockIcon,
                      height: 19,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        visibilityProvider.togglePasswordVisibility();
                      },
                      child: visibilityProvider.isPasswordObscured
                          ? Icon(
                              Icons.visibility_off_outlined,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.8),
                            )
                          : Icon(
                              Icons.visibility_outlined,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.8),
                            ),
                    ),
                  ),
                  isDense: true,
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                log('log ');
                if (events.length == 0) {
                  showSnackbar(message: 'You add all seller to specific event');
                } else {
                  log('data in list');
                }
              },
              child: Container(
                width: double.infinity,
                height: size.height * 0.07,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colorScheme(context).onSurface.withOpacity(.10),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    underline: SizedBox.shrink(),
                    value: selectedEvent,
                    hint: Text(AppLocalizations.of(context)!.select_event),
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    items: events.map((event) {
                      return DropdownMenuItem(
                        value: event.eventName,
                        child: Text(
                          event.eventName,
                          style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedEvent = value;
                        selectedEventId = events
                            .firstWhere((event) => event.eventName == value)
                            .id;
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            CustomButton(
                iconColor: colorScheme(context).secondary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.na_createAccount,
                backgroundColor: colorScheme(context).secondary,
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      selectedEventId != null) {
                    context.loaderOverlay.show();
                    await sellerAuthController
                        .registerSellerAccount(
                      context: context,
                      name: name.text,
                      surname: surName.text,
                      email: email.text,
                      password: password.text,
                      eventid: selectedEventId!,
                      onSuccess: (message) async {
                        // chatProvider.createChatRoom(
                        //     name: 'as',
                        //     onSuccess: (val) {},
                        //     members: [
                        //       StaticData.userId,
                        //       message.,
                        //     ],
                        //     type: 'private',
                        //     context: context);
                        // context.pushNamed(
                        //   AppRoute.sellerCreatePin,
                        //   extra: {'email': email.text},
                        // );
                      },
                      onError: (error) {
                        // showSnackbar(message: error, isError: true);

                        // context.loaderOverlay.hide();
                      },
                    )
                        .then((val) {
                      if (val) {
                        showSnackbar(message: 'Seller create successfully');
                        sellerAuthController.getSellerList();
                        context.pop();
                        getProfessionalEvents();
                        context.loaderOverlay.hide();
                      } else {
                        showSnackbar(
                            message: 'Something went wrong try again',
                            isError: true);

                        context.loaderOverlay.hide();
                      }
                    });
                    context.loaderOverlay.hide();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
