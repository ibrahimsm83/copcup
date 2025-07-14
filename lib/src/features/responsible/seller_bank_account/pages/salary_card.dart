// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';

class SalaryCard extends StatefulWidget {
  const SalaryCard({super.key});

  @override
  State<SalaryCard> createState() => _SalaryCardState();
}

class _SalaryCardState extends State<SalaryCard> {
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsibleAppBar(
        title: 'Salary Card',
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              amount.text.isEmpty ? 'Amount: \€0' : 'Amount: ${amount.text} €',
              style: textTheme(context).bodyMedium?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextFormField(
                hint: '\$',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                borderRadius: 12,
                hintColor: colorScheme(context).onSurface.withOpacity(0.8),
                controller: amount,
                filled: true,
                fillColor: AppColor.lightGreishShade,
                borderColor: Colors.transparent,
                height: 70,
                focusBorderColor: Colors.transparent,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 160),
                isDense: true),
            Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(Size(96, 40)),
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.lightBlueShade),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
                ),
                onPressed: () {
                  context.pushNamed(AppRoute.withDrawPayement,
                      extra: amount.text);
                },
                child: Text(
                  "Ready",
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).surface,
                      fontSize: 13,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
