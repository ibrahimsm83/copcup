import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_svg/svg.dart';

class SettingsOption extends StatelessWidget {
  final String imagesvg;
  final String title;
  final Widget trailing;

  const SettingsOption({
    required this.imagesvg,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: colorScheme(context).surface,
          border: Border.all(
              color: colorScheme(context).onSurface.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme(context).onSurface.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagesvg,
                    height: 14,
                    width: 14,
                    color: colorScheme(context).onSurface,
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w700),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
