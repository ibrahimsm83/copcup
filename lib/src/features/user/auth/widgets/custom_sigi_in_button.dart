import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSigInButton extends StatelessWidget {
  final String svgIconPath;
  final String text;
  final VoidCallback onPressed;

  const CustomSigInButton({
    Key? key,
    required this.svgIconPath,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: colorScheme(context).onSurface.withOpacity(0.6),
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: colorScheme(context).surface,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              svgIconPath,
              width: 23,
              height: 23,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.7),
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 23), // Placeholder to balance spacing
          ],
        ),
      ),
    );
  }
}
