// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_images.dart';

class ResponsibleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? action;
  final Function()? onLeadingPressed;

  const ResponsibleAppBar({
    Key? key,
    required this.title,
    this.action,
    this.onLeadingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(left: onLeadingPressed != null ? 0 : 60),
          child: Text(
            title,
            style: textTheme(context).headlineSmall?.copyWith(
                  fontSize: 21,
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        leading: onLeadingPressed != null
            ? IconButton(
                icon: SvgPicture.asset(AppIcons.backIcon,
                    height: 15, color: colorScheme(context).onSurface),
                onPressed: onLeadingPressed,
              )
            : null, //

        actions: action != null ? [action!] : null,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
