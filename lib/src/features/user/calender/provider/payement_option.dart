import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/radio_provider.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/global_variable.dart';

class PaymentOption extends StatelessWidget {
  final String image;
  final String title;
  final String value;

  const PaymentOption({
    required this.value,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<PaymentMethodProvider>();
    final isSelected = paymentProvider.selectedPaymentMethod == value;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(image),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: textTheme(context).titleMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Radio<String>(
            value: value,
            groupValue: paymentProvider.selectedPaymentMethod,
            onChanged: (newValue) {
              paymentProvider.selectPaymentMethod(newValue);
            },
            activeColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}
