import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/provider/refund_provider.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class CustomCheckbox extends StatelessWidget {
  final int index;

  CustomCheckbox({required this.index});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RefundProvider>(context);
    bool isChecked = provider.selectedItemIndex == index;

    return GestureDetector(
      onTap: () {
        provider.toggleItemSelection(index);
      },
      child: Container(
        height: 19,
        width: 19,
        decoration: BoxDecoration(
          color:
              isChecked ? colorScheme(context).secondary : Colors.transparent,
          border: Border.all(
            color: isChecked ? colorScheme(context).secondary : Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                size: 15,
                color: Colors.white,
              )
            : null,
      ),
    );
  }
}
