// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback onPressed;
  final double height;
  final Color? arrowCircleColor;
  final Color? iconColor;
  final Color? borderColor;

  final double? arrowCircleRadius;

  final List<BoxShadow>? boxShadow;

  const CustomButton({
    this.iconColor,
    this.arrowCircleColor,
    Key? key,
    required this.text,
    this.backgroundColor,
    this.textColor = Colors.white,
    required this.onPressed,
    this.height = 65.0,
    this.borderColor,
    this.boxShadow,
    this.arrowCircleRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            boxShadow: boxShadow ??
                [
                  BoxShadow(
                      color: colorScheme(context).onSurface.withOpacity(.30),
                      offset: Offset(1, 2),
                      blurRadius: 8)
                ],
            border: Border.all(
                color: borderColor ?? colorScheme(context).secondary, width: 1),
            color: backgroundColor ?? colorScheme(context).primary,
            borderRadius: BorderRadius.circular(30)),
        width: double.infinity,
        height: height,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 40,
              ),
              Text(text,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: textColor ?? colorScheme(context).surface,
                      fontWeight: FontWeight.w600)),
              CircleAvatar(
                radius: arrowCircleRadius ?? 23,
                backgroundColor:
                    arrowCircleColor ?? colorScheme(context).onSecondary,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward,
                    color: iconColor ?? iconColor,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
