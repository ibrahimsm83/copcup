import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';

class TransferMoneyCustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const TransferMoneyCustomButton({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      onTap: onTap,
      height: 60,
      width: 153,
      borderRadius: 20,
      color: colorScheme(context).secondary,
      child: Center(
        child: Text(
          text,
          style: textTheme(context).bodyMedium?.copyWith(
              color: colorScheme(context).surface,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
