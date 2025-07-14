import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> selectedKg = ValueNotifier<int>(1);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: textTheme(context).titleMedium?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
