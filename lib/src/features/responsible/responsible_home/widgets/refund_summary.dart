import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class RefundSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Order ID",
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "#254656",
              style: textTheme(context).labelMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Orders",
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "5",
              style: textTheme(context).labelMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Refund Amount",
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              "\$125.00",
              style: textTheme(context).labelMedium?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
