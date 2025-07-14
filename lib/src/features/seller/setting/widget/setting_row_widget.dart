import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_svg/svg.dart';

class SettingRowWidget extends StatelessWidget {
  final String iconImage;
  final String settingName;
  final Widget? forwardIcon;
  final void Function()? ontap;

  const SettingRowWidget(
      {super.key,
      required this.iconImage,
      required this.settingName,
      this.forwardIcon,
      this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: CustomContainer(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            SvgPicture.asset(
              iconImage,
              color: AppColor.naviBlueColor,
            ),
            SizedBox(width: 10),
            Text(settingName,
                style: textTheme(context).titleSmall?.copyWith(
                    fontSize: 15,
                    color: AppColor.naviBlueColor,
                    fontWeight: FontWeight.w600)),
            Spacer(),
            forwardIcon ??
                Icon(Icons.arrow_forward_ios_outlined,
                    color: AppColor.naviBlueColor)
          ],
        ),
      ),
    );
  }
}
