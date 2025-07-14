import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/widget/appbar.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class PayemtCardsPage extends StatelessWidget {
  PayemtCardsPage({super.key});

  @override
  List<String> iconsList = [
    AppIcons.visaIcon,
    AppIcons.masterCardIcon,
    AppIcons.americanExpressIcon,
    AppIcons.paypalIcon,
    AppIcons.dinnerCardIcon
  ];

  List<String> cardNameList = [
    'Visa',
    'MasterCard',
    'American Express',
    'PayPal',
    'Diners'
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: PaymentAppBar(title: 'Add Payment method'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Column(
            children: List.generate(
                5,
                (index) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed(AppRoute.cardDataPage);
                              },
                              child: Row(
                                children: [
                                  CustomContainer(
                                      height: 48,
                                      width: 48,
                                      borderColor: AppColor.textFieldHintColor,
                                      borderRadius: 4,
                                      color: index == 1
                                          ? colorScheme(context).surface
                                          : colorScheme(context).onSurface,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          iconsList[index],
                                          height: index == 3
                                              ? 25
                                              : index == 4
                                                  ? 17
                                                  : 12,
                                        ),
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    cardNameList[index],
                                    style: textTheme(context)
                                        .titleMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                    color:
                                        AppColor.appGreyColor.withOpacity(.5),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Divider(
                              color:
                                  AppColor.textFieldHintColor.withOpacity(.5),
                            ),
                          )
                        ],
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
