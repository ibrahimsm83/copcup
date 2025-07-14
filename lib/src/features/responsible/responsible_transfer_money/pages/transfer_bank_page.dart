import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';

import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/bank_select_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/money_transfer_appBar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfe_money_amount_widget.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class SelectBankTransfer extends StatelessWidget {
  SelectBankTransfer({super.key});

  final List<Color> bankColorList = [
    AppColor.mcbBankColor,
    AppColor.alfalaBankColor,
    AppColor.jazzCashBankColor,
    AppColor.alfalaBankColor.withOpacity(.8),
    AppColor.ublBankColor.withOpacity(.7),
    AppColor.ublBankColor,
    AppColor.jazzCashBankColor,
    AppColor.easyPassaBankColor,
    AppColor.alfalaBankColor.withOpacity(.6),
    AppColor.contentColorWhite,
    AppColor.mcbBankColor,
    AppColor.alfalaBankColor.withOpacity(.85)
  ];

  final List<String> bankNameList = [
    'MCB',
    'Afalah',
    'Soneri',
    'BOP',
    'HBL',
    'UBL',
    'JazzCash',
    'EasyPaisa',
    'MobiCash',
    'Payoneer',
    'PayPal',
    'Stripe'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 60),
          child: MoneyTransferAppbar(titil: 'Select a Bank')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            TransfeMoneyWidget(
              description:
                  'Please, select a bank from which you want to do the money transfer.',
              amountText: '',
            ),
            Expanded(
              child: Consumer<BankSelectionProvider>(
                builder: (context, bankProvider, child) => GridView.builder(
                  itemCount: bankColorList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Material(
                      elevation: index == 9 ? 2 : 0,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          bankProvider
                              .selectBank(index); 
                          context.pushNamed(AppRoute.topUpSimCardPage);
                        },
                        child: CustomContainer(
                          height: 112,
                          width: 109,
                          borderRadius: 10,
                          color: bankColorList[index],
                          borderColor: bankProvider.selectedBankIndex == index
                              ? Colors.blueAccent 
                              : Colors.transparent, 
                          borderWidth:
                              bankProvider.selectedBankIndex == index ? 2 : 0,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(
                                bankNameList[index],
                                style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
