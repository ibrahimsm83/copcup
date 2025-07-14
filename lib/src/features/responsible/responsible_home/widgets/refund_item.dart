import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

import 'package:flutter_application_copcup/src/features/responsible/responsible_home/widgets/custom_check_box.dart';

class RefundItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(4, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(2, (colIndex) {
              int index = rowIndex * 4 + colIndex;
              return Row(
                children: [
                  CustomCheckbox(index: index),
                  SizedBox(width: 10),
                  Text(
                    "Burger - \$25.0",
                    style: textTheme(context).labelMedium?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              );
            }),
          ),
        );
      }),
    );
  }
}
