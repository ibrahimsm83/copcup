import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_svg/svg.dart';

class PaymentAppBar extends StatelessWidget {
  final String title;
  final Widget? addIcon;
  final void Function()? ontap;
  const PaymentAppBar(
      {super.key, required this.title, this.addIcon, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            InkWell(
                onTap: ontap ??
                    () {
                      Navigator.pop(context);
                    },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: SvgPicture.asset(AppIcons.backIcon),
                )),
            SizedBox(
              width: 15,
            ),
            Text(
              title ?? 'Add Payment method',
              style: textTheme(context).headlineMedium?.copyWith(
                  color: AppColor.naviBlueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Spacer(),
            addIcon ??
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      size: 25,
                      color: colorScheme(context).onSurface.withOpacity(.8),
                    ))
          ],
        ),
      ),
    );
  }
}
