import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AddPaymentPage extends StatelessWidget {
  AddPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    context.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: SvgPicture.asset(AppIcons.backIcon),
                  )),
              SizedBox(
                width: 15,
              ),
              Text(
                'Add Payment method',
                style: textTheme(context).headlineMedium?.copyWith(
                    color: AppColor.naviBlueColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text('No Payment Found',
                  style: textTheme(context).bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      color: AppColor.appGreyColor.withOpacity(.6),
                      fontSize: 16)),
              SizedBox(
                height: 10,
              ),
              Text('You can add and edit payments during checkout',
                  style: textTheme(context).bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0,
                      color: AppColor.appGreyColor.withOpacity(.6),
                      fontSize: 10)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(5),
                child: CustomContainer(
                  onTap: () {
                    context.pushNamed(AppRoute.payemtCardsPage);
                  },
                  color: colorScheme(context).surface,
                  borderRadius: 5,
                  width: double.infinity,
                  borderColor: colorScheme(context).onSurface.withOpacity(.08),
                  height: 200,
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.paymentShadowColor.withOpacity(.08),
                        blurRadius: 24,
                        offset: Offset(0, 16))
                  ],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        child: Center(
                            child: Icon(
                          Icons.add,
                          size: 35,
                          color: colorScheme(context).secondary,
                        )),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: colorScheme(context).secondary,
                                width: 2.5)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Add Payment Method',
                        style: textTheme(context).titleMedium?.copyWith(
                            color: colorScheme(context).secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
