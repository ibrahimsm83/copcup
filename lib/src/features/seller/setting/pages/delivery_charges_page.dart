import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/validations.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/controller/delivery_charges_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class DeliveryChargesPage extends StatefulWidget {
  const DeliveryChargesPage({super.key});

  @override
  State<DeliveryChargesPage> createState() => _DeliveryChargesPageState();
}

class _DeliveryChargesPageState extends State<DeliveryChargesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resDeliveryCharges
            ? DeliveryChargesWidget()
            : ResponsibleProfilePage()),
  ];
}

class DeliveryChargesWidget extends StatelessWidget {
  DeliveryChargesWidget({super.key});

  @override
  final basedeliveryfee = TextEditingController();
  final deliveryperkm = TextEditingController();
  final minimumorderfee = TextEditingController();
  final freethreshold = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Form(
        key: _formKey,
        child: Consumer<ResponsibleAuthController>(
            builder: (context, provider, child) {
          log(provider.userProfessionalModel.toString());
          log('${StaticData.userId}');

          final user = provider.userProfessionalModel;
          log(user.toString());
          log(user?.image.toString() ?? '');
          if (user == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    AppLocalizations.of(context)!.create_delivery_charges,
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
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.base_delivery_fee,
                style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.enter_delivery_fee,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Enter delivery fee'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: basedeliveryfee,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.delivery_per_km,
                style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.enter_value,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Enter value'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: deliveryperkm,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.minimum_order_fee,
                style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.order_fee,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Order fee'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: minimumorderfee,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.fee_threshold,
                style: textTheme(context).titleSmall?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.threshold,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Threshold'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: freethreshold,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                isDense: true,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              SizedBox(
                height: 90,
              ),
              Consumer<DeliveryChargesController>(
                builder: (context, provider, child) => CustomButton(
                    iconColor: colorScheme(context).secondary,
                    arrowCircleColor: colorScheme(context).surface,
                    text: AppLocalizations.of(context)!.create,
                    backgroundColor: colorScheme(context).secondary,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final overlay = context.loaderOverlay;

                        overlay.show();
                        provider.createDeliveryCharges(
                          context: context,
                          sellerid: StaticData.userId.toString(),
                          basedeliveryfee: basedeliveryfee.text,
                          deliveryperkm: deliveryperkm.text,
                          minimumorderfee: minimumorderfee.text,
                          freedeliverythreshold: freethreshold.text,
                          onSuccess: (message) async {
                            overlay.hide();
                            showSnackbar(message: 'Sucess$message');
                            context.pushNamed(AppRoute.responsibleBottomBar);
                          },
                          onError: (error) {
                            showSnackbar(message: error, isError: true);
                          },
                        );
                      }
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
