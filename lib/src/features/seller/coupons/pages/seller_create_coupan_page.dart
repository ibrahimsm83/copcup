import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/controller/coupon_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerCreateCoupanPage extends StatefulWidget {
  const SellerCreateCoupanPage({super.key});

  @override
  State<SellerCreateCoupanPage> createState() => _SellerCreateCoupanPageState();
}

class _SellerCreateCoupanPageState extends State<SellerCreateCoupanPage> {
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
        builder: (context, value, child) => value.resCreateCoupon
            ? GenerateCouponWidget()
            : ResponsibleProfilePage()),
  ];
}

class GenerateCouponWidget extends StatelessWidget {
  GenerateCouponWidget({super.key});
  TextEditingController amountController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController lastDateController = TextEditingController();
  TextEditingController limitController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
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
                  AppLocalizations.of(context)!.generate_coupon,
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
              AppLocalizations.of(context)!.discount_amount,
              style: textTheme(context).titleSmall,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: amountController,
              borderColor: Colors.grey.shade300,
              hint: AppLocalizations.of(context)!.enter_amount,
              keyboardType: TextInputType.number,
              validationType: ValidationType.field,
              autoValidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.discount_percentage,
              style: textTheme(context).titleSmall,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: percentageController,
              borderColor: Colors.grey.shade300,
              keyboardType: TextInputType.number,
              hint: AppLocalizations.of(context)!.enter_percentage,
              validationType: ValidationType.field,
              autoValidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.valid_from,
              style: textTheme(context).titleSmall,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  // Format the selected date if needed
                  fromDateController.text =
                      "${selectedDate.toLocal()}".split(' ')[0];
                }
              },
              child: AbsorbPointer(
                absorbing: true,
                child: CustomTextFormField(
                  readOnly: true,
                  controller: fromDateController,
                  borderColor: Colors.grey.shade300,
                  hint: AppLocalizations.of(context)!.valid_from,
                  validationType: ValidationType.field,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.valid_until,
              style: textTheme(context).titleSmall,
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  lastDateController.text =
                      "${selectedDate.toLocal()}".split(' ')[0];
                }
              },
              child: AbsorbPointer(
                absorbing: true,
                child: CustomTextFormField(
                  controller: lastDateController,
                  borderColor: Colors.grey.shade300,
                  hint: AppLocalizations.of(context)!.valid_until,
                  validationType: ValidationType.field,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.usage_limit,
              style: textTheme(context).titleSmall,
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              controller: limitController,
              keyboardType: TextInputType.number,
              borderColor: Colors.grey.shade300,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              hint: AppLocalizations.of(context)!.enter_limit,
              validationType: ValidationType.field,
            ),
            SizedBox(height: 70),
            Consumer<CouponController>(
              builder: (context, provider, child) => CustomButton(
                backgroundColor: colorScheme(context).secondary,
                text: AppLocalizations.of(context)!.generate,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final discount = int.parse(amountController.text.trim());
                    final percentage =
                        int.parse(percentageController.text.trim());
                    final fromDate = fromDateController.text.trim();
                    final lastDate = lastDateController.text.trim();
                    final usageLimit = int.parse(limitController.text.trim());

                    provider.generateCoupon(
                        context: context,
                        discountAmount: discount,
                        discountPercentage: percentage,
                        validFrom: fromDate,
                        validUntil: lastDate,
                        usageLimit: usageLimit);
                  }
                },
                iconColor: colorScheme(context).primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
