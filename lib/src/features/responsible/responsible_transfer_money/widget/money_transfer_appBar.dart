import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_svg/svg.dart';

class MoneyTransferAppbar extends StatelessWidget {
  final String titil;
  final void Function()? onTap;
  const MoneyTransferAppbar({super.key, required this.titil, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          CustomContainer(
            onTap: onTap ??
                () {
                  Navigator.pop(context);
                },
            height: 34,
            width: 65,
            color: colorScheme(context).secondary,
            borderRadius: 100,
            child: Center(
              child: SvgPicture.asset(AppIcons.backIcon,
                  height: 15, color: colorScheme(context).surface),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            titil,
            style: textTheme(context)
                .titleMedium
                ?.copyWith(color: colorScheme(context).onSurface),
          )
        ],
      ),
    );
  }
}
