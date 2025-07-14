import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class TransfeMoneyWidget extends StatelessWidget {
  final String? availableBalance;
  final String? dollarPrice;
  final String? description;
  final String? amountText;

  const TransfeMoneyWidget(
      {super.key,
      this.availableBalance,
      this.dollarPrice,
      this.description,
      this.amountText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            availableBalance ?? 'Available Balance',
            style: textTheme(context).titleMedium?.copyWith(
                color: AppColor.appGreyColor.withOpacity(.75),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            dollarPrice ?? '\$2,85,856.20',
            style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).secondary,
                fontSize: 30,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            description ??
                'Please, enter the receiver’s bank account\nnumber in below field.',
            style: textTheme(context).titleMedium?.copyWith(
                color: AppColor.appGreyColor.withOpacity(.75),
                fontSize: 11,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            amountText ?? 'Account No.',
            style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).secondary,
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
