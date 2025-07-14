import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/money_transfer_appBar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfe_money_amount_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/transfer_money_custom_button.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../widget/sim_selction_provider.dart';

class SelectSimCardServicPage extends StatelessWidget {
  SelectSimCardServicPage({super.key});

  final List<Color> simCardColorList = [
    AppColor.mcbBankColor.withOpacity(.85),
    AppColor.alfalaBankColor.withOpacity(.8),
    AppColor.ublBankColor.withOpacity(.65),
    AppColor.jazzCashBankColor,
  ];

  final List<String> simCardName = ['Jazz', 'Telenor', 'Zong', 'Ufone'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: MoneyTransferAppbar(titil: 'Top-up Sim Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            TransfeMoneyWidget(
              description:
                  'Please, select a Sim Card Service on which you want to Top-up.',
              amountText: '',
            ),
            Expanded(
              child: Consumer<SimSelectionProvider>(
                builder: (context, simProvider, child) => GridView.builder(
                  itemCount: simCardName.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      simProvider.selectSim(index);
                    },
                    child: CustomContainer(
                      height: 164,
                      borderRadius: 10,
                      boxShadow: [
                        BoxShadow(
                          color:
                              colorScheme(context).onSurface.withOpacity(.08),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        )
                      ],
                      color: simCardColorList[index],
                      borderColor: simProvider.selectedSimIndex == index
                          ? Colors.blueAccent
                          : Colors.transparent,
                      borderWidth:
                          simProvider.selectedSimIndex == index ? 2 : 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Text(
                            simCardName[index],
                            style: textTheme(context).bodySmall?.copyWith(
                                color: colorScheme(context).onSurface),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: TransferMoneyCustomButton(
                text: 'Next',
                onTap: () {
                  final simProvider = context.read<SimSelectionProvider>();
                  if (simProvider.selectedSimIndex != null) {
                    // Navigate if a SIM is selected
                    context.pushNamed(AppRoute.transferMoneyVerifiedNumberPage);
                  } else {
                    // Show error if no SIM is selected
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a SIM card'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
