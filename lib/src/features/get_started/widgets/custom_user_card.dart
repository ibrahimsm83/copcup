import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/get_started/provider/color_provider.dart';

import 'package:provider/provider.dart';

class CustomUserCard extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String username;
  final Color defaultBackgroundColor;
  final Color onTapBackgroundColor;
  final Color textColor;
  final double borderRadius;
  final VoidCallback ontap;

  const CustomUserCard({
    Key? key,
    required this.ontap,
    required this.height,
    required this.width,
    required this.imagePath,
    required this.username,
    this.defaultBackgroundColor = Colors.grey, // Set default color to grey
    this.onTapBackgroundColor = Colors.blue, // Set onTap color to blue
    this.textColor = Colors.black,
    this.borderRadius = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final roleProvider = Provider.of<RoleProvider>(context);
    final isSelected = roleProvider.selectedRole == username;

    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: isSelected ? onTapBackgroundColor : defaultBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              imagePath,
              height: height * 0.5,
              width: width * 0.9,
            ),
            Text(
              username,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
