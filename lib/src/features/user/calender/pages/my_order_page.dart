import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Order",
        onLeadingPressed: () {
          context.pop();
        },
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppIcons.cartIcon,
                height: 140,
                width: 140,
              ),
              const SizedBox(height: 24),
              Text('No Orders Yet',
                  style: textTheme(context).titleLarge?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontSize: 24,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              Text(
                  'Lorem ipsum is a placeholder text commonly used in design and publishing to fill space and give an idea of the final text.',
                  textAlign: TextAlign.center,
                  style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.5),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                height: 90,
              ),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: 'Start Ordering',
                backgroundColor: colorScheme(context).primary,
                onPressed: () {
                  context.pushNamed(AppRoute.allOrderPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
