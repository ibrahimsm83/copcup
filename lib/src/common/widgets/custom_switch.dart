import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class CustomSwitch extends StatelessWidget {
  final Color? activeTrackColor;
  final Color? inActiveTrackColor;
  final Function(bool)? onChanged;
  final bool value;

  const CustomSwitch(
      {super.key,
      this.activeTrackColor,
      this.inActiveTrackColor,
      this.onChanged,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: .8,
      scaleY: .8,
      child: Switch(
          activeColor: value == false
              ? inActiveTrackColor ?? AppColor.switchColor
              : activeTrackColor ?? colorScheme(context).secondary,
          activeTrackColor: value == false
              ? inActiveTrackColor ?? AppColor.switchColor
              : activeTrackColor ?? colorScheme(context).secondary,
          inactiveTrackColor: AppColor.switchColor,
          trackOutlineColor: WidgetStatePropertyAll(
            value == false
                ? inActiveTrackColor ?? AppColor.switchColor
                : activeTrackColor ?? colorScheme(context).secondary,
          ),
          trackColor: WidgetStatePropertyAll(
            value == false
                ? inActiveTrackColor ?? AppColor.switchColor
                : activeTrackColor ?? colorScheme(context).secondary,
          ),
          thumbColor: WidgetStatePropertyAll(
            value == false
                ? inActiveTrackColor ?? AppColor.switchColor
                : activeTrackColor ?? colorScheme(context).secondary,
          ),
          thumbIcon: WidgetStatePropertyAll(Icon(
            Icons.circle,
            size: 20,
            color: colorScheme(context).surface,
          )),
          value: value,
          onChanged: onChanged
          // (val) {
          //   value.updateSwitchStatus();
          // },
          ),
    );
  }
}
