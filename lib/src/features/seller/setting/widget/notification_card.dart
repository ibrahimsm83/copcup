import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_svg/svg.dart';

class NotificationCard extends StatelessWidget {
  final String iconImage;
  final String title;
  final String subTitle;
  final double? imageSize;
  final void Function()? ontap;
  const NotificationCard(
      {super.key,
      required this.iconImage,
      required this.title,
      required this.subTitle,
      this.ontap,
      this.imageSize});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CustomContainer(
        borderColor: colorScheme(context).onSurface.withOpacity(.10),
        borderRadius: 12,
        height: 70,
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            CircleAvatar(
              backgroundColor: colorScheme(context).secondary,
              radius: 20,
              child: Center(
                  child: SvgPicture.asset(
                iconImage,
                height: imageSize ?? 15,
                color: colorScheme(context).surface,
              )),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                Text(subTitle,
                    style: textTheme(context).bodyMedium?.copyWith(
                        color: AppColor.appGreyColor,
                        fontSize: 8,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
