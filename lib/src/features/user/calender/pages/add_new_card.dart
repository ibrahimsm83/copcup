import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils/validations.dart';
import '../../../../common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});

  @override
  State<AddNewCard> createState() => _AddNewCardState();
}

class _AddNewCardState extends State<AddNewCard> {
  final cardNumber = TextEditingController();
  final cardHolderName = TextEditingController();
  final expiryDate = TextEditingController();
  final cvv = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.addNewCard,
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme(context).primary,
                      colorScheme(context).primary.withOpacity(0.7)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Current Balance',
                          style: textTheme(context).bodyLarge?.copyWith(
                              color:
                                  colorScheme(context).surface.withOpacity(0.4),
                              fontWeight: FontWeight.w500),
                        ),
                        Image.asset(
                          AppImages.masterCardsImageWithText,
                          height: 40,
                          width: 50,
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$5,750.20',
                      style: textTheme(context).headlineLarge?.copyWith(
                          color: colorScheme(context).surface.withOpacity(0.6),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '5282 3456 7890 1289',
                          style: textTheme(context).bodyLarge?.copyWith(
                              color:
                                  colorScheme(context).surface.withOpacity(0.4),
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '09/25',
                          style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.4),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // CustomTextFormField(
              //   hint: AppLocalizations.of(context)!.cardNumber,
              //   autoValidateMode: AutovalidateMode.onUserInteraction,
              //   validator: (value) =>
              //       Validation.fieldValidation(value, 'Card Number'),
              //   borderRadius: 12,
              //   hintColor: colorScheme(context).onSurface.withOpacity(0.8),
              //   controller: cardNumber,
              //   filled: true,
              //   fillColor: colorScheme(context).surface,
              //   borderColor: colorScheme(context).onSurface.withOpacity(.10),
              //   height: 70,
              //   keyboardType: TextInputType.number,
              //   inputFormatters: [
              //     FilteringTextInputFormatter.digitsOnly,
              //     LengthLimitingTextInputFormatter(13),
              //   ],
              //   focusBorderColor:
              //       colorScheme(context).onSurface.withOpacity(.10),
              //   contentPadding:
              //       EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              //   isDense: true,
              // ),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.cardNumber,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Card Number is required';
                  }
                  if (value.length != 16) {
                    return 'Card Number must be 16 digits';
                  }
                  return null;
                },
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: cardNumber,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16), // ⬅️ updated to 16
                ],
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                isDense: true,
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: AppLocalizations.of(context)!.cardHolderName,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    Validation.fieldValidation(value, 'Card Holder Name'),
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: cardHolderName,
                filled: true,
                fillColor: colorScheme(context).surface,
                borderColor: colorScheme(context).onSurface.withOpacity(.10),
                height: 70,
                focusBorderColor:
                    colorScheme(context).onSurface.withOpacity(.10),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                isDense: true,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                          helpText: 'Select Expiration Date',
                        );

                        if (pickedDate != null) {
                          // Format as MM/yy
                          String formattedDate =
                              DateFormat('MM/yy').format(pickedDate);
                          expiryDate.text = formattedDate;
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextFormField(
                          hint: AppLocalizations.of(context)!.expiryDate,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Expiry Date is required';
                            }

                            // Validate MM/yy format using RegExp
                            final regex = RegExp(r"^(0[1-9]|1[0-2])\/\d{2}$");
                            if (!regex.hasMatch(value)) {
                              return 'Enter a valid expiry date (MM/yy)';
                            }

                            return null;
                          },
                          borderRadius: 12,
                          hintColor:
                              colorScheme(context).onSurface.withOpacity(0.8),
                          controller: expiryDate,
                          filled: true,
                          fillColor: colorScheme(context).surface,
                          borderColor:
                              colorScheme(context).onSurface.withOpacity(.10),
                          height: 70,
                          focusBorderColor:
                              colorScheme(context).onSurface.withOpacity(.10),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          isDense: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextFormField(
                      hint: AppLocalizations.of(context)!.cvv,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'CVV is required';
                        }
                        if (!RegExp(r'^\d{3,4}$').hasMatch(value)) {
                          return 'CVV must be 3 or 4 digits';
                        }
                        return null;
                      },
                      borderRadius: 12,
                      hintColor:
                          colorScheme(context).onSurface.withOpacity(0.8),
                      controller: cvv,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4), // Max 4 digits
                      ],
                      filled: true,
                      fillColor: colorScheme(context).surface,
                      borderColor:
                          colorScheme(context).onSurface.withOpacity(.10),
                      height: 70,
                      focusBorderColor:
                          colorScheme(context).onSurface.withOpacity(.10),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      isDense: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 90),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.addCard,
                backgroundColor: colorScheme(context).primary,
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.pushReplacementNamed(AppRoute.userBottomNavBar);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
